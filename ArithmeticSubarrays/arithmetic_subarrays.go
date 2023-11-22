package main

import "math"

func checkArithmeticSubarrays(nums []int, l []int, r []int) []bool {
	var ans []bool

	for i := 0; i < len(l); i++ {
		min := math.MaxInt32
		max := math.MinInt32
		length := r[i] - l[i] + 1

		for j := l[i]; j <= r[i]; j++ {
			min = int(math.Min(float64(min), float64(nums[j])))
			max = int(math.Max(float64(max), float64(nums[j])))
		}

		if min == max {
			ans = append(ans, true)
		} else if (max-min)%(length-1) != 0 {
			ans = append(ans, false)
		} else {
			diff := make([]bool, length)

			step := (max - min) / (length - 1)
			j := l[i]

			for j <= r[i] {
				if (nums[j]-min)%step != 0 || diff[(nums[j]-min)/step] {
					break
				}

				diff[(nums[j]-min)/step] = true
				j++
			}

			ans = append(ans, j > r[i])
		}
	}

	return ans
}


/*


func isArithmetic(nums []int, ll, rr int) bool {
	minN := nums[ll]
	maxN := nums[ll]
	for i := ll; i <= rr; i++ {
		if nums[i] < minN {
			minN = nums[i]
		}
		if nums[i] > maxN {
			maxN = nums[i]
		}
	}
	diff := maxN - minN
	if diff == 0 {
		return true
	}
	d := diff / (rr - ll)
	if diff%(rr-ll) != 0 {
		return false
	}
	term := make([]bool, rr-ll+1)
	for i := ll; i <= rr; i++ {
		x := nums[i] - minN
		if x%d != 0 {
			return false
		}
		j := x / d
		if term[j] {
			return false // exact once
		} else {
			term[j] = true
		}
	}
	return true
}

func checkArithmeticSubarrays(nums []int, l, r []int) []bool {
	m := len(l)
	ans := make([]bool, m)
	for i := 0; i < m; i++ {
		ans[i] = isArithmetic(nums, l[i], r[i])
	}
	return ans
}



*/