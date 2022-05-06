local base32 = require 'base32'

local crockford = {}

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

function crockford.encode(data)
	return base32.encode(data, encode_lookup)
end

function crockford.decode(data)
	return base32.decode(data, decode_lookup)
end

return crockford
