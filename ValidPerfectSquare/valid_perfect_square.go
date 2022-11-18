package main

func isPerfectSquare(num int) bool {
	var low int = 0
	var high int = num
	for low <= high {
		var mid int = low + (high-low)/2
		if mid*mid == num {
			return true
		} else if mid*mid < num {
			low = mid + 1
		} else {
			high = mid - 1
		}
	}
	return false
}
