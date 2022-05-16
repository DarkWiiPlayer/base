local hex = {}

local function encode(char)
	return string.format('%02x', char:byte())
end

function hex.encode(data)
	return (data:gsub(".", encode))
end

local function decode(byte)
	return string.char(tonumber(byte, 16))
end

function hex.decode(data)
	return (data:gsub("%x%x", decode))
end

return hex
