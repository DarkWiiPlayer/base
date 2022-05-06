# Based

A repository of Lua encoders and deoders for different string encodings.

## Usage

```lua
local baseX = require 'based.X.Y'
-- Where X is the base (e.g. 32)
-- and Y is the mapping (e.g. Crockford's)

local input = io.read()
local encoded = baseX.encode(input)
print(encoded)
local decoded = baseX.decode(input)
print(decoded)

assert(input == decoded)
```

Currently implemented:

- Base16 aka. Hexadecimal
- Base32
  - Crockford's
