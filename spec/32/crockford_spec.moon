import encode, decode from require 'based.32.crockford'

describe 'base32', ->
	describe "Crockford's", ->
		describe 'Encoder', ->
			it 'Encodes simple strings', ->
				assert.equal "00000", encode("\0\0\0")
				assert.equal "ZZZZY", encode("\xff\xff\xff")
			it 'Encodes complex strings', ->
				assert.equal "DHMPET3M41VPYWKB5R", encode "light work."
				assert.equal "DHMPET3M41VPYWKB",   encode "light work"
				assert.equal "DHMPET3M41VPYWG",    encode "light wor"
				assert.equal "DHMPET3M41VPY",      encode "light wo"
				assert.equal "DHMPET3M41VG",       encode "light w"
		describe 'Decoder', ->
			it 'Decodes simple strings', ->
				assert.equal "\0\0\0", decode("00000")
				assert.equal "\xff\xff\xff", decode("ZZZZY")
			it 'Decodes complex strings', ->
				assert.equal "light work.", decode "DHMPET3M41VPYWKB5R"
				assert.equal "light work", decode "DHMPET3M41VPYWKB"
				assert.equal "light wor", decode "DHMPET3M41VPYWG"
				assert.equal "light wo", decode "DHMPET3M41VPY"
				assert.equal "light w", decode "DHMPET3M41VG"
