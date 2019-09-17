module Algorithm::IntBase64
	BASE = ["0", "1", "2", "3", "4", "5", "6", "7", 
			"8", "9", "A", "B", "C", "D", "E", "F", 
			"G", "H", "I", "J", "K", "L", "M", "N", 
			"O", "P", "Q", "R", "S", "T", "U", "V", 
			"W", "X", "Y", "Z", "a", "b", "c", "d", 
			"e", "f", "g", "h", "i", "j", "k", "l", 
			"m", "n", "o", "p", "q", "r", "s", "t", 
			"u", "v", "w", "x", "y", "z", "+", "/"]

	def encode64 number
		return "0" if number == 0
		return recurse_encode64 number
	end

	private 

	def recurse_encode64 number
		return "" if number == 0
		return recurse_encode64(number/64) + BASE[number%64]
	end

end