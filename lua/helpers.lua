local log = require('plenary.log').new {
	level = "debug",
	use_console = 'async'
}

local function map(tbl, f)
	local t = {}
	for k, v in pairs(tbl) do
		t[k] = f(v)
	end
	return t
end

local function has_value(tab, val)
	for i, v in ipairs(tab) do
		if v == val then
			return true
		end
	end

	return false
end

return {
	log = log,
	map = map,
	has_value = has_value
}
