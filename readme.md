# Based

A repository of Lua encoders and deoders for different string encodings.

## Usage

```lua
-- local baseX = require 'based.X.Y'
-- Where X is the base (e.g. 32)
-- and Y is the mapping (e.g. Crockford's)
local base32 = require 'based.32.crockford'

local input = io.read()
local encoded = base32.encode(input)
print(encoded)
local decoded = base32.decode(input)
print(decoded)

assert(input == decoded)
```

Currently implemented:

- Base16 aka. Hexadecimal
- Base32
  - Crockford's
