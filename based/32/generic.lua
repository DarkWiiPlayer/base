local base32 = {}

function base32.decode(input, lookup)
	local buffer = {}
	local length = math.floor(#input*5/8)
	local bits = length*8 - #input*5
	local acc = 0
	local buffer_pointer = length
	for i=#input, 1, -1 do
		local word5 = lookup[input:byte(i)]
		word5 = word5 * 2^bits
		bits = bits + 5
		acc = acc + word5
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

function base32.encode(binary, lookup)
	local buffer = {}
	local length = math.ceil(#binary*8/5)
	local acc = 0
	local bits = length*5 - #binary*8
	local buffer_pointer = length
	for i=#binary, 1, -1 do
		local byte = binary:byte(i)
		acc = acc + byte * 2^bits
		bits = bits + 8
		while bits >=5 do
			local b32 = (acc % 32)+1
			acc = math.floor(acc / 32)
			bits = bits - 5
			buffer[buffer_pointer] = lookup:sub(b32, b32)
			buffer_pointer = buffer_pointer-1
		end
	end
	return table.concat(buffer)
end

return base32
