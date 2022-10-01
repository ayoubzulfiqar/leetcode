package main

/*
Runtime: 0 ms, faster than 100.00% of Go online submissions for Happy Number.
Memory Usage: 2 MB, less than 93.92% of Go online submissions for Happy Number.
*/

func isHappy(n int) bool {
	i := 10
	for i > 0 {
		happy := sums(n)
		if happy == 1 {
			return true
		}
		n = happy
		i--
	}
	return false
}
func sums(n int) int {
	var sum int = 0
	for i := 0; n != 0; i++ {
		r := n % 10
		sum = sum + r*r
		n = n / 10
	}
	return sum
}
