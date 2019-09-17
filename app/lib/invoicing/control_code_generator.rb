module Invoicing::ControlCodeGenerator

	def self.included klass
		klass.class_eval do
			include Algorithm::Verhoeff
			include Algorithm::IntBase64
			include Algorithm::RC4Hex			
		end
	end


	def control_code_for authorization:, number:, nit:, date:, amount:, key:
		
		# Round amount
		amount = amount.round.to_i

		# Step 1: Obtener 5 digitos verhoeff
		ex_number = add_verhoeff number, times: 2
		ex_nit = add_verhoeff nit, times: 2
		ex_date = add_verhoeff date, times: 2
		ex_amount = add_verhoeff amount, times: 2

		verhoeff_digits = format "%05d", add_verhoeff(ex_number.to_i+ex_nit.to_i+ex_date.to_i+ex_amount.to_i, times: 5).to_i % 100000

		# Step 2: obtener 5 cadenas
		sum = 0
		tails = verhoeff_digits.split("").map{ |c| key[sum..(sum = sum+c.to_i+1)-1] }
		ex_authorization = authorization.to_s + tails[0]
		ex_number = ex_number.to_s + tails[1]
		ex_nit = ex_nit.to_s + tails[2]
		ex_date = ex_date.to_s + tails[3]
		ex_amount = ex_amount.to_s + tails[4]

		# Step 3: get the RC4
		encryptedRC4 = encrypt key: key+verhoeff_digits, payload: ex_authorization+ex_number+ex_nit+ex_date+ex_amount
		encryptedRC4 = encryptedRC4.split("")

		# Step4: ASCII sum
		total_sum = encryptedRC4.inject(0){ |sum, x| sum + x.ord }
		sum1 = encryptedRC4.map.with_index{ |x, i| i % 5 == 0 ? x.ord : 0 }.reduce :+
		sum2 = encryptedRC4.map.with_index{ |x, i| (i+4) % 5 == 0 ? x.ord : 0 }.reduce :+
		sum3 = encryptedRC4.map.with_index{ |x, i| (i+3) % 5 == 0 ? x.ord : 0 }.reduce :+
		sum4 = encryptedRC4.map.with_index{ |x, i| (i+2) % 5 == 0 ? x.ord : 0 }.reduce :+
		sum5 = encryptedRC4.map.with_index{ |x, i| (i+1) % 5 == 0 ? x.ord : 0 }.reduce :+

		# Step 5: Multiplication and sum adn base 64

		vd = verhoeff_digits.split("").map{ |c| c.to_i + 1 }
		mul1 = (total_sum * sum1) / vd[0]
		mul2 = (total_sum * sum2) / vd[1]
		mul3 = (total_sum * sum3) / vd[2]
		mul4 = (total_sum * sum4) / vd[3]
		mul5 = (total_sum * sum5) / vd[4]

		base64 = encode64(mul1+mul2+mul3+mul4+mul5)

		# Step 6: apply RC4 and get control code

		encrypt(key: key+verhoeff_digits, payload: base64).scan(/.{2}/).join("-")


	end

	def add_verhoeff number, times: 0
		return number.to_s if times == 0
		return add_verhoeff number.to_s + checksum(number), times: times-1
	end

end