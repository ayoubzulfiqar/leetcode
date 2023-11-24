# 🔥 Sum of Absolute Differences in a Sorted Array 🔥 || Simple Fast and Easy || with Explanation 😈

## Intuition

The goal is to find the sum of absolute differences between each element and all other elements in the array. The code uses a prefix and suffix sum approach to efficiently calculate these absolute differences.

### Approach

1. **Suffix Sum Calculation (Initialization):**
   - Calculate the total sum of the array and store it in the variable `y`. This is done using a loop that iterates through each element of the array.

2. **Absolute Difference Calculation:**
   - Iterate through the array again.
   - For each element, calculate the sum of absolute differences using the prefix sum (`x`) and the suffix sum (`y`). Update the element in the array with this calculated value.
   - Update the prefix sum (`x`) and suffix sum (`y`) accordingly for the next iteration.

### Time Complexity

- The time complexity of this algorithm is O(n), where n is the length of the input array. This is because the code iterates through the array twice, and each iteration takes O(n) time.

### Space Complexity

- The space complexity is O(1) since the algorithm uses a constant amount of additional space, regardless of the size of the input array. The input array is modified in place.

This approach efficiently calculates the sum of absolute differences without the need for nested loops, resulting in a linear time complexity solution.

## Code

```go
func getSumAbsoluteDifferences(nums []int) []int {
	// Initialize variables
	var x, y int = 0, 0
	var len int = len(nums)

	// Calculate the total sum of the array (suffix sum)
	for i := 0; i < len; i++ {
		y += nums[i]
	}

	// Iterate through the array to calculate the absolute differences
	for i := 0; i < len; i++ {
		// Calculate the sum of absolute differences using prefix and suffix sums
		x += nums[i]
		tmp := (nums[i]*(i+1) - x) + (y - nums[i]*(len-i))

		// Update the suffix sum for the next iteration
		y -= nums[i]

		// Update the array with the calculated absolute difference
		nums[i] = tmp
	}

	// Return the array with updated absolute differences
	return nums
}
```

## [GitHub](https://github.com/ayoubzulfiqar/leetcode)
