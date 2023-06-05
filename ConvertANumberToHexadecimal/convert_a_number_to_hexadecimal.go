package main

func toHex(num int) string {
	if num == 0 {
		return "0"
	}

	const bitsPerDigit = 4
	const mask = (1 << bitsPerDigit) - 1

	hex := make([]byte, 8)
	i := 7

	// Convert negative numbers to their two's complement representation
	if num < 0 {
		num = (1 << 32) + num
	}

	for num != 0 {
		nib := num & mask
		hex[i] = getHexDigit(nib)
		num >>= bitsPerDigit
		i--
	}

	return string(hex[i+1:])
}

func getHexDigit(n int) byte {
	if n < 10 {
		return byte('0' + n)
	}
	return byte('a' + n - 10)
}

//--------------------------

