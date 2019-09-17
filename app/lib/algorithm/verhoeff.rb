module Algorithm::Verhoeff 

	#multiplication table
	D = [
	    [0, 1, 2, 3, 4, 5, 6, 7, 8, 9],
	    [1, 2, 3, 4, 0, 6, 7, 8, 9, 5], 
	    [2, 3, 4, 0, 1, 7, 8, 9, 5, 6], 
	    [3, 4, 0, 1, 2, 8, 9, 5, 6, 7], 
	    [4, 0, 1, 2, 3, 9, 5, 6, 7, 8], 
	    [5, 9, 8, 7, 6, 0, 4, 3, 2, 1], 
	    [6, 5, 9, 8, 7, 1, 0, 4, 3, 2], 
	    [7, 6, 5, 9, 8, 2, 1, 0, 4, 3], 
	    [8, 7, 6, 5, 9, 3, 2, 1, 0, 4], 
	    [9, 8, 7, 6, 5, 4, 3, 2, 1, 0]
	]

	# permutation table p
	P = [
	    [0, 1, 2, 3, 4, 5, 6, 7, 8, 9], 
	    [1, 5, 7, 6, 2, 8, 3, 0, 9, 4], 
	    [5, 8, 0, 3, 7, 9, 6, 1, 4, 2], 
	    [8, 9, 1, 6, 0, 4, 3, 5, 2, 7], 
	    [9, 4, 5, 3, 1, 2, 6, 8, 7, 0], 
	    [4, 2, 8, 6, 5, 7, 3, 9, 0, 1], 
	    [2, 7, 9, 3, 8, 0, 6, 4, 1, 5], 
	    [7, 0, 4, 6, 9, 1, 3, 2, 5, 8]
	]

	# inverse table inv
	INV = [0, 4, 3, 2, 1, 5, 6, 7, 8, 9]

	def checksum number
		number = "#{number}0"
		INV[iterate_through number.split("").reverse].to_s
	end

	def check number
		0 == iterate_through(number.digits)
	end

	private

	def iterate_through digits
		i = 0
		c = 0
		digits.each do |n_i|
			c = D[c][P[i % 8][n_i.to_i]]
			i += 1
		end
		c
	end

end