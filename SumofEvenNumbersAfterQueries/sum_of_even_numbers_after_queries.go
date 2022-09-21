package main

// the idea is we don't calculate the even sum from scratch for each query
// instead, we calculate it at the beginning
// since each query only updates one value,
// so we can adjust the even sum base on the original value and new value
func sumEvenAfterQueries(nums []int, queries [][]int) []int {
	evenSum := 0
	// calculate the sum of all even numbers
	for _, val := range nums {
		if val%2 == 0 {
			evenSum += val
		}
	}
	ans := make([]int, len(queries))
	for i, q := range queries {
		val, idx := q[0], q[1]
		// if original nums[idx] is even, then we deduct it from evenSum
		if nums[idx]%2 == 0 {
			evenSum -= nums[idx]
		}
		// in-place update nums
		nums[idx] += val
		// check if we need to update evenSum for the new value
		if nums[idx]%2 == 0 {
			evenSum += nums[idx]
		}
		// then we have evenSum after this query, push it to ans
		ans[i] = evenSum
	}
	return ans
}
