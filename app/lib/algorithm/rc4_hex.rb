module Algorithm::RC4Hex

	require 'rc4'

	def encrypt key:, payload:
		RC4.new(key).encrypt(payload).split("").map{ |c| format("%02X", c.ord) }.join
	end

end