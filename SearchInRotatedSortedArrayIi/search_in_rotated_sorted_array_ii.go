package main

import (
	"sort"
)

func search(nums []int, target int) bool {
	// Order the array in order to search
	ordered := append([]int{}, nums...)
	sort.Ints(ordered)

	init := 0
	end := len(ordered) - 1

	// To memoize the computed values
	memo := make(map[int]int)

	for {
		// Change the middle index based on the last init/end index value
		mid := (end + init) / 2

		// Memoize the computed indexes to avoid infinite loop
		// If they were computed before, it means the value does not exist in the array
		// If the value doesn't exist, break the loop and return false
		if _, ok := memo[mid]; ok {
			return false
		} else {
			memo[mid] = 0
		}

		// Regular binary search
		if ordered[mid] == target {
			return true
		} else if ordered[mid] < target {
			init = mid + 1
		} else {
			end = mid - 1
		}
	}
}


func searchONE(nums []int, target int) bool {
    for _, num := range nums {
        if num == target {
            return true
        }
    }
    return false
}
