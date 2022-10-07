package main

// Runtime: 0 ms, faster than 100.00% of Go online submissions for Power of Two.
// Memory Usage: 2.1 MB, less than 10.91% of Go online submissions for Power of Two.
func isPowerOfTwo(n int) bool {
	return n > 0 && ((n & (n - 1)) == 0)
}
