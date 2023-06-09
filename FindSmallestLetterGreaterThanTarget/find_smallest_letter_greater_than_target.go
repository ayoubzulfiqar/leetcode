package main

func nextGreatestLetter(letters []byte, target byte) byte {
	left := 0
	right := len(letters) - 1

	for left <= right {
		mid := left + (right-left)/2

		if letters[mid] > target {
			right = mid - 1
		} else {
			left = mid + 1
		}
	}

	return letters[left%len(letters)]
}
