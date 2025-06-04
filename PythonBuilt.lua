local Python = {}

function Python.abs(x)
	return math.abs(x)
end

function Python.all(iterable)
	for _, v in ipairs(iterable) do
		if not v then return false end
	end
	return true
end

function Python.any(iterable)
	for _, v in ipairs(iterable) do
		if v then return true end
	end
	return false
end

function Python.ascii(obj)
	return tostring(obj):gsub("[^%w]", function(c)
		return string.format("\\x%02x", string.byte(c))
	end)
end

function Python.bin(number)
	return "0b" .. string.format("%b", number)
end

function Python.bool(x)
	return not not x
end

function Python.callable(obj)
	return typeof(obj) == "function"
end

function Python.chr(i)
	return string.char(i)
end

function Python.complex(real, imag)
	return {real = real or 0, imag = imag or 0}
end

function Python.dict(tbl)
	return tbl or {}
end

function Python.dir(obj)
	local result = {}
	for k in pairs(obj) do
		table.insert(result, k)
	end
	table.sort(result)
	return result
end

function Python.divmod(a, b)
	return math.floor(a / b), a % b
end

function Python.enumerate(iterable, start)
	start = start or 0
	local result = {}
	for i, v in ipairs(iterable) do
		table.insert(result, {start + i - 1, v})
	end
	return result
end

function Python.eval(str)
	local func, err = load("return " .. str)
	if func then
		local ok, result = pcall(func)
		return ok and result or nil
	end
	return nil
end

function Python.filter(func, iterable)
	local result = {}
	for _, v in ipairs(iterable) do
		if func(v) then table.insert(result, v) end
	end
	return result
end

function Python.float(x)
	return tonumber(x)
end

function Python.format(value, format_spec)
	return string.format(format_spec, value)
end

function Python.frozenset(tbl)
	return setmetatable({}, {
		__index = tbl,
		__newindex = function() error("frozenset is immutable") end
	})
end

function Python.getattr(obj, attr, default)
	local success, value = pcall(function() return obj[attr] end)
	return success and value or default
end

function Python.globals()
	return _G
end

function Python.hasattr(obj, attr)
	return obj[attr] ~= nil
end

function Python.hash(obj)
	if type(obj) == "number" or type(obj) == "string" then
		return tostring(obj):gsub(".", function(c) return string.byte(c) end)
	else
		return tostring(obj)
	end
end

function Python.hex(n)
	return string.format("0x%x", n)
end

function Python.id(obj)
	return tostring(obj)
end


function Python.int(x)
	return math.floor(tonumber(x) or 0)
end

function Python.isinstance(obj, classinfo)
	return typeof(obj) == classinfo
end


function Python.iter(tbl)
	local i = 0
	local n = #tbl
	return function()
		i = i + 1
		if i <= n then return tbl[i] end
	end
end

function Python.len(obj)
	return #obj
end

function Python.list(iterable)
	local result = {}
	for _, v in ipairs(iterable) do table.insert(result, v) end
	return result
end

function Python.map(func, iterable)
	local result = {}
	for _, v in ipairs(iterable) do
		table.insert(result, func(v))
	end
	return result
end

function Python.max(...)
	local args = {...}
	local m = args[1]
	for i = 2, #args do
		if args[i] > m then m = args[i] end
	end
	return m
end

function Python.min(...)
	local args = {...}
	local m = args[1]
	for i = 2, #args do
		if args[i] < m then m = args[i] end
	end
	return m
end

function Python.next(tbl, key)
	return next(tbl, key)
end

function Python.oct(n)
	return "0o" .. string.format("%o", n)
end

function Python.ord(c)
	return string.byte(c)
end

function Python.pow(x, y)
	return x ^ y
end

function Python.print(...)
	print(...)
end

function Python.range(start, stop, step)
	local result = {}
	if stop == nil then
		stop = start
		start = 0
	end
	step = step or 1
	for i = start, stop - 1, step do
		table.insert(result, i)
	end
	return result
end

function Python.repr(obj)
	return tostring(obj)
end

function Python.reversed(tbl)
	local result = {}
	for i = #tbl, 1, -1 do
		table.insert(result, tbl[i])
	end
	return result
end

function Python.round(number)
	return math.floor(number + 0.5)
end

function Python.set(tbl)
	local s = {}
	for _, v in ipairs(tbl) do s[v] = true end
	return s
end

function Python.sorted(tbl)
	local t = {table.unpack(tbl)}
	table.sort(t)
	return t
end

function Python.str(obj)
	return tostring(obj)
end

function Python.sum(iterable, start)
	local total = start or 0
	for _, v in ipairs(iterable) do
		total = total + v
	end
	return total
end

function Python.tuple(iterable)
	local t = {}
	for i, v in ipairs(iterable) do
		t[i] = v
	end
	return t
end

function Python.type(obj)
	return typeof(obj)
end

function Python.zip(...)
	local argTables = {...}
	local result = {}
	local len = math.huge
	for _, t in ipairs(argTables) do
		if #t < len then len = #t end
	end
	for i = 1, len do
		local group = {}
		for _, t in ipairs(argTables) do
			table.insert(group, t[i])
		end
		table.insert(result, group)
	end
	return result
end

return Python
