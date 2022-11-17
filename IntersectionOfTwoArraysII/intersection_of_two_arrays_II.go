package main

import "sort"

func intersect(nums1 []int, nums2 []int) []int {
	sort.Ints(nums1)
	sort.Ints(nums2)
	var result []int
	var left int = 0
	var right int = 0
	for left < len(nums1) && right < len(nums2) {
		if nums1[left] == nums2[right] {
			result = append(result, nums1[left])
			left++
			right++
		} else if nums1[left] < nums2[right] {
			left++
		} else {
			right++
		}
	}
	return result
}
