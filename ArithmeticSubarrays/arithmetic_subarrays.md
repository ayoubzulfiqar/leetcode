# ✅ 🔥 Arithmetic Subarrays 🔥 || Simple Fast and Easy || with Explanation 😈

### Intuition

The code aims to determine whether each subarray specified by the ranges in arrays `l` and `r` forms an arithmetic sequence. An arithmetic sequence is a sequence of numbers in which the difference between consecutive elements is constant.

### Approach

1. **isArithmetic Function:**
    - Find the minimum and maximum values in the given subarray (`ll` to `rr` inclusive).
    - Calculate the difference (`diff`) between the maximum and minimum values.
    - If `diff` is zero, all elements in the subarray are the same, and it's considered an arithmetic sequence.
    - Calculate the common difference `d` and check if it evenly divides the difference between max and min.
    - Create a boolean array (`term`) to keep track of whether each potential element in the arithmetic sequence has been encountered.
    - Iterate through the subarray, calculate the position of each element relative to the minimum, and check if it forms a valid position in the arithmetic sequence. If not, return false.
    - If the loop completes, return true, indicating the subarray is an arithmetic sequence.

2. **checkArithmeticSubarrays Function:**
    - Iterate through the ranges specified by arrays `l` and `r`.
    - For each range, call the `isArithmetic` function to determine if the corresponding subarray is an arithmetic sequence.
    - Store the result in the `ans` array.

### Time Complexity

- The time complexity of the `isArithmetic` function is O(n), where n is the length of the subarray (`rr - ll + 1`).
- The `checkArithmeticSubarrays` function iterates through m ranges, and for each range, it calls `isArithmetic`, resulting in a total time complexity of O(m * n), where m is the number of ranges.

### Space Complexity

- The space complexity is O(n) for the `term` array in the `isArithmetic` function, where n is the length of the subarray.

### Note

- The given code assumes that the input arrays `l` and `r` are valid ranges (0 <= ll <= rr < len(nums)). If this assumption doesn't hold, additional boundary checks may be needed.

## Code

```go
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
```

## Solution - 2

### Intuition

The code still aims to determine whether each subarray specified by the ranges in arrays `l` and `r` forms an arithmetic sequence.

### Approach

1. **checkArithmeticSubarrays Function:**
    - Iterate through the ranges specified by arrays `l` and `r`.
    - For each range, find the minimum and maximum values in the subarray.
    - If the minimum and maximum are equal, the subarray is considered an arithmetic sequence.
    - If the difference between the maximum and minimum is not divisible evenly by the length of the subarray minus one, it's not an arithmetic sequence.
    - Otherwise, iterate through the subarray, calculate the step size, and check if each element fits into a valid position in the arithmetic sequence. If yes, the subarray is considered an arithmetic sequence.

### Time Complexity

- The time complexity of this implementation is O(m * n), where m is the number of ranges, and n is the length of the subarray (`r[i] - l[i] + 1`).

### Space Complexity

- The space complexity is O(n) for the `diff` array, where n is the length of the subarray.

### Note

- This implementation uses a similar logic to the previous one but with some modifications in the details of implementation. The choice between the two implementations may depend on factors such as readability and personal coding style.

## Code

```go
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
```

## [GitHub](https://github.com/ayoubzulfiqar/leetcode)
