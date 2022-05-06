local hex = {}

function hex.encode(data)
	return data:gsub(".", function(char)
		return string.format('%02x', char)
	end)
end

function hex.decode(data)
	return data:gsub("%x%x", function(byte)
		return string.char(tonumber(byte, 16))
	end)
end

return hex
