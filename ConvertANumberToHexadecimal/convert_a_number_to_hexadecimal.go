package main

// Real Solution
//----------------------------------------

// func toHex(num int) string {
// 	if num == 0 {
// 		return "0"
// 	}

// 	const bitsPerDigit = 4
// 	const mask = (1 << bitsPerDigit) - 1

// 	hex := make([]byte, 8)
// 	i := 7

// 	// Convert negative numbers to their two's complement representation
// 	if num < 0 {
// 		num = (1 << 32) + num
// 	}

// 	for num != 0 {
// 		nib := num & mask
// 		hex[i] = getHexDigit(nib)
// 		num >>= bitsPerDigit
// 		i--
// 	}

// 	return string(hex[i+1:])
// }

// func getHexDigit(n int) byte {
// 	if n < 10 {
// 		return byte('0' + n)
// 	}
// 	return byte('a' + n - 10)
// }

//--------------------------

// Just for Fun

import (
	"fmt"
	"math"
)

func ToHex(n interface{}) (string, error) {
	switch v := n.(type) {
	case int:
		return toHexInt(int32(v)), nil
	case int32:
		return toHexInt(v), nil
	case int64:
		return toHexInt64(v), nil
	case float32:
		return toHexFloat(float64(v)), nil
	case float64:
		return toHexFloat(v), nil
	default:
		return "", fmt.Errorf("Unsupported type: %T", v)
	}
}

func toHexInt(n int32) string {
	if n == 0 {
		return "0"
	}

	ref := "0123456789abcdef"
	result := ""

	for n != 0 {
		result = string(ref[n&0xF]) + result
		n >>= 4
	}

	return result
}

func toHexInt64(n int64) string {
	if n == 0 {
		return "0"
	}

	ref := "0123456789abcdef"
	result := ""

	for n != 0 {
		result = string(ref[n&0xF]) + result
		n >>= 4
	}

	return result
}

func toHexFloat(n float64) string {
	bits := math.Float64bits(n)
	ref := "0123456789abcdef"
	result := ""

	for i := 60; i >= 0; i -= 4 {
		nibble := (bits >> i) & 0xF
		result += string(ref[nibble])
	}

	return result
}

func main() {
	num := 255
	hexStr, _ := ToHex(num)
	fmt.Println(hexStr) // Output: ff

	num32 := int32(65535)
	hexStr32, _ := ToHex(num32)
	fmt.Println(hexStr32) // Output: ffff

	num64 := int64(4294967295)
	hexStr64, _ := ToHex(num64)
	fmt.Println(hexStr64) // Output: ffffffff

	f := float32(3.14)
	hexFloat, _ := ToHex(f)
	fmt.Println(hexFloat) // Output: 4048f5c3

	d := 3.14159
	hexDouble, _ := ToHex(d)
	fmt.Println(hexDouble) // Output: 400921fb54442d18
}
