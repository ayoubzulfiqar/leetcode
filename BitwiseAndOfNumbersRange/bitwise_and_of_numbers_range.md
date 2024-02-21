# 🔥 Bitwise AND of Numbers Range 🔥 || Simple Fast and Easy || with Explanation

### Intuition and Approach

This code aims to find the bitwise AND of all numbers within the given range [left, right], inclusive. The approach used in this code is to iteratively reduce the `right` number by unsetting its least significant bit until `left` becomes equal to or greater than `right`. Since the range is contiguous, unsetting the least significant bit eventually leads to the common prefix of `left` and `right`, which represents the bitwise AND of all numbers in the range.

### Time Complexity

The time complexity of this approach depends on the number of bits in the input numbers. In the worst case, the loop iterates until `left` becomes equal to or greater than `right`. Each iteration of the loop involves unsetting the least significant bit of `right` using the operation `right &= (right - 1)`, which takes O(1) time. Therefore, the overall time complexity is O(log n), where n is the maximum of `left` and `right`.

### Space Complexity

The space complexity of this code is O(1), as it only uses a constant amount of extra space for storing temporary variables and does not depend on the input size.

This code offers a more efficient approach compared to directly iterating through the range of numbers, making it suitable for finding the bitwise AND of large ranges. However, both approaches aim to achieve the same result.

## Code

```go
func rangeBitwiseAnd(left int, right int) int {
    for left < right {
        right &= (right - 1)
    }
    return right
}

// Another Implementation
func rangeBitwiseAnd(left int, right int) int {
	var shift_count int = 0
	for left < right {
		left >>= 1
		right >>= 1
		shift_count += 1
	}
	return left << shift_count
}
```

## [GitHub](https://github.com/ayoubzulfiqar/leetcode)
