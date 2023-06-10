package main

import "sort"

func thirdMax(nums []int) int {
	// Create a HashSet using a map[int]bool
	unique := make(map[int]bool)

	// Add elements to the HashSet
	for _, num := range nums {
		unique[num] = true
	}

	// Create a slice to store unique numbers
	uniqueNums := make([]int, 0, len(unique))
	for num := range unique {
		uniqueNums = append(uniqueNums, num)
	}

	// Sort the unique numbers in ascending order
	sort.Ints(uniqueNums)

	// Check if the unique numbers have at least 3 elements
	if len(uniqueNums) < 3 {
		return uniqueNums[len(uniqueNums)-1]
	}

	return uniqueNums[len(uniqueNums)-3]
}
