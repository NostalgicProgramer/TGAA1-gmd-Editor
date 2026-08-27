class_name GMDCrypto

# Llaves para TGAA1 (Dual Destinies / The Great Ace Attorney 1)
const KEY0_A: String = "fjfajfahajra;tira9tgujagjjgajgoa"
const KEY0_B: String = "mva;eignhpe/dfkfjgp295jtugkpejfu"

# Llaves para TGAA2 (Spirit of Justice / The Great Ace Attorney 2)
const KEY1_A: String = "e43bcc7fcab+a6c4ed22fcd433/9d2e6cb053fa462-463f3a446b19"
const KEY1_B: String = "861f1dca05a0;9ddd5261e5dcc@6b438e6c.8ba7d71c*4fd11f3af1"

static func de_xor(input_data: PackedByteArray) -> PackedByteArray:
	if input_data.size() == 0:
		return input_data
		
	var last_byte = input_data[input_data.size() - 1]
	
	# Si el último byte de los datos en bruto es 0, significa que el archivo
	# es texto plano y no está encriptado (un archivo encriptado nunca termina en 0 con estas llaves).
	if last_byte == 0:
		return input_data
	
	# 1. Probamos con las llaves de TGAA1 (Par 0)
	var k0_a = KEY0_A.to_ascii_buffer()
	var k0_b = KEY0_B.to_ascii_buffer()
	var test_byte_0 = last_byte ^ k0_a[(input_data.size() - 1) % k0_a.size()] ^ k0_b[(input_data.size() - 1) % k0_b.size()]
	
	if test_byte_0 == 0:
		var output = PackedByteArray()
		output.resize(input_data.size())
		for i in range(input_data.size()):
			output[i] = input_data[i] ^ k0_a[i % k0_a.size()] ^ k0_b[i % k0_b.size()]
		return output

	# 2. Si falla, probamos con las llaves de TGAA2 (Par 1)
	var k1_a = KEY1_A.to_ascii_buffer()
	var k1_b = KEY1_B.to_ascii_buffer()
	var test_byte_1 = last_byte ^ k1_a[(input_data.size() - 1) % k1_a.size()] ^ k1_b[(input_data.size() - 1) % k1_b.size()]
	
	if test_byte_1 == 0:
		var output = PackedByteArray()
		output.resize(input_data.size())
		for i in range(input_data.size()):
			output[i] = input_data[i] ^ k1_a[i % k1_a.size()] ^ k1_b[i % k1_b.size()]
		return output
		
	# Si ninguna prueba funciona, devolvemos los datos originales.
	return input_data

static func re_xor(input_data: PackedByteArray) -> PackedByteArray:
	# Para TGAA1 en 3DS, el texto se inyecta directamente sin encriptar.
	return input_data
