import encode, decode from require 'based.64.rfc'

describe 'base64', ->
	describe 'RFC 4648', ->
		describe 'Encoder', ->
			it 'Pads strings correctly', ->
				assert.equal "==", encode(".")\match("=+")
				assert.equal "=", encode("..")\match("=+")
				assert.equal "==", encode("....")\match("=+")
				assert.is.nil encode("...")\match("=+")
			it 'Encodes simple strings', ->
				assert.equal "AAAA", encode("\0\0\0")
				assert.equal "////", encode("\xff\xff\xff")
			it 'Encodes complex strings', ->
				-- Wikipedia examples:
				assert.equal "bGlnaHQgd29yay4=", encode "light work."
				assert.equal "bGlnaHQgd29yaw==", encode "light work"
				assert.equal "bGlnaHQgd29y",     encode "light wor"
				assert.equal "bGlnaHQgd28=",     encode "light wo"
				assert.equal "bGlnaHQgdw==",     encode "light w"
		describe 'Decoder', ->
			it 'Detects incorrect padding', ->
				assert.is.false select 2, decode "bGlnaHQgd29yay4"
				assert.is.false select 2, decode "bGlnaHQgd29yaw"
				assert.is.false select 2, decode "bGlnaHQgd28"
				assert.is.false select 2, decode "bGlnaHQgdw"
			it 'Decodes simple strings', ->
				assert.equal "\0\0\0", decode("AAAA")
				assert.equal "\xff\xff\xff", decode("////")
			it 'Decodes complex strings', ->
				assert.equal "light work.", decode "bGlnaHQgd29yay4="
				assert.equal "light work", decode "bGlnaHQgd29yaw=="
				assert.equal "light wor", decode "bGlnaHQgd29y"
				assert.equal "light wo", decode "bGlnaHQgd28="
				assert.equal "light w", decode "bGlnaHQgdw=="
