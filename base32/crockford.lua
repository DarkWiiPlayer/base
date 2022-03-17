local base32 = {}

local encode_lookup = "0123456789ABCDEFGHJKMNPQRSTVWXYZ"
local decode_lookup = {
	nil, nil, nil, nil, nil, nil, nil, nil, nil, nil,
	nil, nil, nil, nil, nil, nil, nil, nil, nil, nil,
	nil, nil, nil, nil, nil, nil, nil, nil, nil, nil,
	nil, nil, nil, nil, nil, nil, nil, nil, nil, nil,
	nil, nil, nil, nil, nil, nil, nil,   0,   1,   2,
	  3,   4,   5,   6,   7,   8,   9, nil, nil, nil,
	nil, nil, nil, nil,  10,  11,  12,  13,  14,  15,
	 16,  17,   1,  18,  19,   1,  20,  21,   0,  22,
	 23,  24,  25,  26, nil,  27,  28,  29,  30,  31,
	nil, nil, nil, nil, nil, nil,  10,  11,  12,  13,
	 14,  15,  16,  17,   1,  18,  19,   1,  20,  21,
	  0,  22,  23,  24,  25,  26, nil,  27,  28,  29,
	30, 31
}

function base32.decode(base32)
	local buffer = {}

	local length = math.floor(#base32*5/8)
	bits = length*8 - #base32*5
	acc = 0
	buffer_pointer = length
	for i=#base32, 1, -1 do
		local word5 = decode_lookup[base32:byte(i)]
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

function base32.encode(binary)
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
			buffer[buffer_pointer] = encode_lookup:sub(b32, b32)
			buffer_pointer = buffer_pointer-1
		end
	end
	return table.concat(buffer)
end

local encoded = base32.encode("Hello, World!")
print(encoded)
local decoded = base32.decode(encoded)
print(decoded)

return base32
