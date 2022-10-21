package main

// Runtime: 0 ms, faster than 100.00% of Go online submissions for Ugly Number.
// Memory Usage: 2.1 MB, less than 5.43% of Go online submissions for Ugly Number.
func isUgly(n int) bool {
	if n == 1 {
		return true
	} else if n <= 0 {
		return false
	}

	if n%2 == 0 {
		return isUgly(n / 2)
	}
	if n%3 == 0 {
		return isUgly(n / 3)
	}
	if n%5 == 0 {
		return isUgly(n / 5)
	}
	return false
}

func isReallyUgly(n int) bool {
	var arr []int = []int{2, 3, 5}
	for i := 0; i < len(arr); i++ {
		for n >= arr[i] && n%arr[i] == 0 {
			n /= arr[i]
		}
	}
	return n == 1
}

func isReallyReallyUgly(n int) bool {
	if n <= 0 {
		return false
	}
	if n == 1 {
		return true
	}

	for n%3 == 0 && n >= 3 {
		n /= 3
	}
	for n%5 == 0 && n >= 5 {
		n /= 5
	}
	for n%2 == 0 && n >= 2 {
		n /= 2
	}

	// if(n==0 || n==1|| n==2 || n==3 || n==5) return true;
	if n == 1 {
		return true
	}
	return false

}
