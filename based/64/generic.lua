local base64 = {}

function base64.decode(input, lookup)
	local buffer = {}
	local length = math.floor(#input*6/8)
	local bits = length*8 - #input*6
	local acc = 0
	local buffer_pointer = length
	for i=#input, 1, -1 do
		local word6 = lookup[input:byte(i)]
		word6 = word6 * 2^bits
		bits = bits + 6
		acc = acc + word6
		if bits >= 8 then
			local b256 = acc % 256
			acc = math.floor(acc/256)
			bits = bits - 8
			buffer[buffer_pointer] = string.char(b256)
			buffer_pointer = buffer_pointer-1
		end
	end
	return table.concat(buffer)
end

function base64.encode(binary, lookup)
	local buffer = {}
	local length = math.ceil(#binary*8/6)
	local acc = 0
	local bits = length*6 - #binary*8
	local buffer_pointer = length
	for i=#binary, 1, -1 do
		local byte = binary:byte(i)
		acc = acc + byte * 2^bits
		bits = bits + 8
		while bits >=6 do
			local b64 = (acc % 64)+1
			acc = math.floor(acc / 64)
			bits = bits - 6
			buffer[buffer_pointer] = lookup:sub(b64, b64)
			buffer_pointer = buffer_pointer-1
		end
	end
	return table.concat(buffer)
end

return base64
