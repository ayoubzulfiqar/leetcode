package main

import "sort"

func findOriginalArray(changed []int) []int {
	//if the total len is odd, return empty array
	if len(changed)%2 != 0 {
		return []int{}
	}
	//sort the array
	sort.Ints(changed)

	//populate the frequency map
	freq := make(map[int]int)
	for _, val := range changed {
		freq[val]++
	}

	result := []int{}
	//iterate thru the original array
	for _, val := range changed {
		cnt := freq[val]
		//no need for check for existence ; element would be present
		if cnt > 0 {
			//if the count is greater than 0
			//reduce the count
			freq[val]--
			//check for double
			dbl := val * 2
			//if present and value is greater than 0
			//then it is candidate
			//however if not present or count is not greater
			//than zero then return empty array
			if v, ok := freq[dbl]; ok {
				if v > 0 {
					result = append(result, val)
					freq[dbl]--
				} else {
					return []int{}
				}
			} else {
				return []int{}
			}
		}
	}

	return result
}
