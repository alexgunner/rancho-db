module Algorithm::Literalizer

	UNITS = ["cero", "uno", "dos", "tres", "cuatro", "cinco", "seis", "siete", "ocho", "nueve"]
	UTENS = ["diez", "once", "doce", "trece", "catorce", "quince", "dieciséis", "diecisiete", "dieciocho", "diecinueve"]
	TENS = ["", "", "veinti", "treinta", "cuarenta", "cincuenta", "sesenta", "setenta", "ochenta", "noventa"]
	HUNDREDS = ["", "ciento", "doscientos", "trescientos", "cuatrocientos", "quinientos", "seiscientos", "setecientos", "ochocientos", "novecientos"]

	def literate_es number
		number = number.to_i
		m = number / 1000000
		k = (number % 1000000) / 1000
		u = number % 1000
		fix21 "#{millions m} #{thousands k} #{hundreds u}".strip
	end

	def millions number
		case number
		when 0
			""
		when 1
			"un millón"
		when 2..999999
			mm = "#{thousands number/1000 } #{ hundreds number % 1000}"
			"#{strip_leading_o mm } millones".strip
		end
	end

	def thousands number
		case number
		when 0
			""
		when 1
			"mil"
		when 1..999
			
			"#{ strip_leading_o hundreds number } mil"
		end
	end

	def hundreds number
		case number
		when 0
			""
		when 100
			"cien"
		when 1..999
			"#{ HUNDREDS[number / 100] } #{ tens number % 100 }".strip
		end
	end

	def tens number
		case number
		when 0
			""
		when 1..9
			units number
		when 10..19
			UTENS[number % 10]
		when 20
			"veinte"
		when 21..22
			"veinti#{units number % 10}"
		when 23
			"veintitrés"
		when 24..25
			"veinti#{units number % 10}"
		when 26
			"veintiséis"
		when 27..29
			"veinti#{units number % 10}"
		when 30..99
			"#{ TENS[number / 10] }" + ((number % 10) > 0 ? " y #{ units number % 10}" : "" )
		end
	end

	def units number
		UNITS[number]		
	end

	private

	def strip_leading_o number
		number = number.last(3) == "uno" ? number[0..(number.size-2)] : number
	end

	def fix21 number
		return number if number["veintiun "].nil?
		number["veintiun "] = "veintiún "
		return fix21 number
	end
end