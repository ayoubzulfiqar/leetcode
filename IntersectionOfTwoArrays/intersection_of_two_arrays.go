package main

import "sort"

func intersection(nums1 []int, nums2 []int) []int {
	numSet := make([]int, 1001)

	for _, num := range nums1 {
		numSet[num]++
	}

	resultSet := make([]int, 1001)

	for _, num := range nums2 {
		if numSet[num] > 0 {
			resultSet[num]++
		}
	}

	var res []int

	for i := 0; i < 1001; i++ {
		if resultSet[i] > 0 {
			res = append(res, i)
		}
	}

	return res
}

// Solution - 2
func interSection(nums1 []int, nums2 []int) []int {
	var result []int
	if nums1 == nil || nums2 == nil {
		return result
	}
	sort.Ints(nums1)
	sort.Ints(nums2)
	for i, j := 0, 0; i < len(nums1) && j < len(nums2); {
		if nums1[i] == nums2[j] {
			var size int = len(result)
			i++
			j++
			if size != 0 && result[size-1] == nums1[i-1] {
				continue
			}
			result = append(result, nums1[i-1])
		} else if nums1[i] < nums2[j] {
			i++
		} else {
			j++
		}
	}
	return result
}
