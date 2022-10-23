package main

// func findErrorNums(nums []int) []int {

// 	var ans []int = make([]int, 0)
// 	for i  := 0; i < len(nums); i++ {
// 		val := math.Abs(nums[i])
// 		ans[1] ^= (i + 1) ^ int(val)
// 		if nums[val - 1] < 0 {

// 		}

// 	}
// }

func findErrorNums(nums []int) (res []int) {
	var a int
	for i, n := range nums {
		a ^= n     // XOR once per number in nums
		a ^= i + 1 // XOR once per expected number
	}

	// find lowest bit, it belongs either to the missing or double value
	lowbit := a & -a
	b := a
	for i, n := range nums {
		// filter by low bit
		// this will skip either the missing or double value
		if n&lowbit > 0 {
			b ^= n
		}
		if (i+1)&lowbit > 0 {
			b ^= i + 1
		}
	}

	// XOR a with b to remove b from a
	a ^= b

	// At this stage, a and b are the double and missing values, but we don't
	// know which one is which! Do a final loop to figure out the return order.
	for _, n := range nums {
		if n == a {
			return []int{a, b}
		}
		if n == b {
			return []int{b, a}
		}
	}
	return nil
}
