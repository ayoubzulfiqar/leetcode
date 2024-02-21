package main

func rangeBitwiseAnd(left int, right int) int {
	var shift_count int = 0
	for left < right {
		left >>= 1
		right >>= 1
		shift_count += 1
	}
	return left << shift_count

	for left < right {
		right &= (right - 1)

	}
	return right
}
