package main

/*--------------------- Bit Manipulation


func singleNumber(nums []int) int {
	var ans int = 0

	for i := 0; i < 32; i++ {
		var sum int = 0
		for _, number := range nums {
			sum += (number >> i) & 1
		}
		sum %= 3
		ans |= (sum << i)
	}

	// Handle negative numbers
	if (ans & (1 << 31)) != 0 {
		ans = -(1 << 31) | (ans & ((1 << 31) - 1))
	}

	return ans
}

*/

func singleNumber(nums []int) int {
	var ones int = 0
	var twos int = 0

	for i := 0; i < len(nums); i++ {
		var number int = nums[i]
		ones ^= (number & ^twos)
		twos ^= (number & ^ones)
	}

	return ones
}
