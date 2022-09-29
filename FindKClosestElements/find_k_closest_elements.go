package main

import "math"

func findClosestElements(arr []int, k int, x int) []int {
	left := 0
	middle := 0
	right := len(arr) - 1
	for left < right {
		middle = (left + right) / 2
		if arr[middle] == x {
			break
		} else if arr[middle] < x {
			if middle == len(arr)-1 {
				break
			}
			if arr[middle+1] > x {
				if compare(arr[middle+1], arr[middle], x) {
					middle += 1
				}
				break
			}
			left = middle + 1
		} else if arr[middle] > x {
			if middle == 0 {
				break
			}
			if arr[middle-1] < x {
				if compare(arr[middle-1], arr[middle], x) {
					middle -= 1
				}
				break
			}
			right = middle - 1
		}

	}
	left_bound := middle
	right_bound := middle
	l := middle - 1
	r := middle + 1
	for right_bound-left_bound+1 < k {
		l_item := math.MaxInt
		if l >= 0 {
			l_item = arr[l]
		}
		r_item := math.MaxInt
		if r < len(arr) {
			r_item = arr[r]
		}
		if compare(l_item, r_item, x) {
			left_bound -= 1
			l -= 1
		} else {
			right_bound += 1
			r += 1
		}
	}
	return arr[left_bound : right_bound+1]
}

func compare(a, b, x int) bool {
	return math.Abs(float64(a-x)) < math.Abs(float64(b-x)) || math.Abs(float64(a-x)) == math.Abs(float64(b-x)) && (a < b)
}
