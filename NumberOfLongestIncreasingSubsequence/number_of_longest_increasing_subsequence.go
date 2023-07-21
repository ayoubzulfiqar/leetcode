package main


/*

Really Slow - I don't like Slow

func findNumberOfLIS(nums []int) int {
	cache := make([][]int, len(nums))
	for i := range cache {
		cache[i] = make([]int, 2)
	}

	max := 0
	num := 0
	for i := 0; i < len(nums); i++ {
		pair := findSequence(nums, cache, i)
		if pair[0]+1 > max {
			max = pair[0] + 1
			num = pair[1]
		} else if pair[0]+1 == max {
			num += pair[1]
		}
	}
	return num
}

func findSequence(nums []int, cache [][]int, index int) []int {
	if index == len(nums) {
		return []int{0, 0}
	}

	if cache[index][0] != 0 {
		return cache[index]
	}

	max := 1
	numLIS := 1
	var pair []int

	for i := index + 1; i < len(nums); i++ {
		if nums[i] > nums[index] {
			pair = findSequence(nums, cache, i)

			if pair[0]+1 > max {
				max = pair[0] + 1
				numLIS = pair[1]
			} else if pair[0]+1 == max {
				numLIS += pair[1]
			}
		}
	}

	cache[index] = []int{max, numLIS}
	return cache[index]
}

*/



type Pair struct {
	first  int
	second int
}

func findNumberOfLIS(nums []int) int {
	n := len(nums)
	lisFQ := make([]Pair, n)
	lisFQ[0] = Pair{1, 1}
	lo := 1

	for i := 1; i < n; i++ {
		mx := 0
		c := 1

		for j := 0; j < i; j++ {
			if nums[j] < nums[i] {
				if lisFQ[j].first > mx {
					mx = lisFQ[j].first
					c = lisFQ[j].second
				} else if lisFQ[j].first == mx {
					c += lisFQ[j].second
				}
			}
		}

		lisFQ[i] = Pair{mx + 1, c}

		if lo < lisFQ[i].first {
			lo = lisFQ[i].first
		}
	}

	count := 0
	for i := 0; i < n; i++ {
		if lisFQ[i].first == lo {
			count += lisFQ[i].second
		}
	}

	return count
}

