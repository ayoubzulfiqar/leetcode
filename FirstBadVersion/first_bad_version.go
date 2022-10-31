package main

func isBadVersion(version int) bool

func firstBadVersion(n int) int {
	var start int = 1
	var end int = n
	for start <= end {
		var mid int = start + (end-start)/2

		if isBadVersion(mid) {
			end = mid - 1
		} else {
			start = mid + 1
		}

	}
	return start

}
