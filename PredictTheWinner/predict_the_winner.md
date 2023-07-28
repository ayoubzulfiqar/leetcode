# 🔥 Recursion + Memoization & DP & Bit-Mask & Iterative🔥 || Simple Fast and Easy || with Explanation 😈


## Recursion + Memoization

### Intuition and Approach:
The given code is an implementation of the "Predict the Winner" problem, which is a variation of the classic "Minimax" algorithm for games. The goal is to predict whether the first player (Player 1) can win the game by selecting elements from the given array `nums` in such a way that the sum of the selected elements is greater than or equal to the sum of the elements chosen by the second player (Player 2).

The function `maxPosAmount` is a recursive function that calculates the maximum possible sum of elements Player 1 can obtain from a given range of elements `nums[i:j+1]`. To achieve this, the function simulates both Player 1 and Player 2 making optimal moves in the game, and then returns the maximum sum that Player 1 can obtain.

The main function `PredictTheWinner` uses the `maxPosAmount` function to find the maximum sum that Player 1 can obtain by selecting elements from the entire array. It then calculates the sum of all elements in the array (`rangeSum`) and calculates the maximum sum Player 2 can obtain (`max2`) by subtracting Player 1's maximum sum from `rangeSum`. Finally, it returns `true` if Player 1's maximum sum is greater than or equal to Player 2's maximum sum, indicating that Player 1 can win or achieve a draw (in case of equal sums).

### Time Complexity:
Let `n` be the number of elements in the `nums` array.

1. The function `maxPosAmount` is a recursive function, and it has overlapping subproblems. To avoid redundant calculations, it uses memoization with the `t` matrix to store the results of previously computed subproblems.
2. For each unique pair `(i, j)`, where `0 <= i <= j < n`, the function computes the maximum sum of elements that Player 1 can obtain from the subarray `nums[i:j+1]`.
3. The function has at most `O(n^2)` unique subproblems (combinations of `i` and `j`), and each subproblem's solution takes constant time to compute if it is not already memoized.
4. Therefore, the overall time complexity is `O(n^2)`.

### Space Complexity:
1. The space complexity of the `maxPosAmount` function is `O(n^2)` due to the memoization matrix `t`.
2. The space complexity of the `PredictTheWinner` function is `O(n)` for the `t` matrix (since it has dimensions `n+1` x `n+1`) and `O(1)` for other variables (`rangeSum`, `max1`, `max2`).
3. Overall, the space complexity is dominated by `O(n^2)`.

### Note:
The code implements a dynamic programming approach to solve the problem efficiently. By storing the results of overlapping subproblems in the `t` matrix, the algorithm avoids redundant calculations and achieves better time complexity compared to a pure recursive approach.

```go
func max(a, b int) int {
	if a > b {
		return a
	}
	return b
}
```
```go

func min(a, b int) int {
	if a < b {
		return a
	}
	return b
}
```
```go
func PredictTheWinner(nums []int) bool {
	n := len(nums)
	t := make([][]int, n+1)
	for i := 0; i <= n; i++ {
		t[i] = make([]int, n+1)
		for j := 0; j <= n; j++ {
			t[i][j] = -1
		}
	}
	rangeSum := 0
	for _, n := range nums {
		rangeSum += n
	}

	max1 := maxPosAmount(nums, 0, n-1, t)
	max2 := rangeSum - max1
	return max1 >= max2
}

func maxPosAmount(nums []int, i, j int, t [][]int) int {
	if i > j || i < 0 || j >= len(nums) || i >= len(nums) || j < 0 {
		return 0
	}
	if t[i][j] != -1 {
		return t[i][j]
	}
	f1 := nums[i] + min(maxPosAmount(nums, i+1, j-1, t), maxPosAmount(nums, i+2, j, t))
	f2 := nums[j] + min(maxPosAmount(nums, i, j-2, t), maxPosAmount(nums, i+1, j-1, t))
	t[i][j] = max(f1, f2)
	return t[i][j]
}
```

## Itrative

### Intuition and Approach:
The provided code is an alternative implementation of the "Predict the Winner" problem using dynamic programming. The approach follows a similar concept as the previous implementation but uses a different approach to store and compute the results of overlapping subproblems.

In this implementation, the `dp` matrix is used to store the results of subproblems. The entry `dp[i][j]` represents the maximum score difference that the first player (Player 1) can achieve when playing optimally in the subarray `nums[i:j+1]` against the second player (Player 2).

The `PredictTheWinner` function calculates the `dp` matrix in a bottom-up manner, starting from the smallest subarray (length 1) and gradually building up to the entire array. It then checks whether Player 1 can achieve a non-negative score difference when playing optimally against Player 2. A non-negative score difference implies that Player 1 can win or achieve a draw.

### Time Complexity:
Let `n` be the number of elements in the `nums` array.

1. The function `PredictTheWinner` uses a nested loop to fill the `dp` matrix.
2. For each unique pair `(i, j)`, where `0 <= i <= j < n`, the function computes the maximum score difference that Player 1 can achieve in the subarray `nums[i:j+1]`.
3. The total number of unique subproblems is `O(n^2)`, and each subproblem's solution takes constant time to compute.
4. Therefore, the overall time complexity is `O(n^2)`.

### Space Complexity:
1. The space complexity of the `PredictTheWinner` function is `O(n^2)` due to the `dp` matrix, which has dimensions `n` x `n`.
2. The function uses additional variables like `n` (length of the `nums` array).
3. Therefore, the overall space complexity is `O(n^2)`.

### Note:
The key difference between this implementation and the previous one lies in the way the results of subproblems are stored and computed. Instead of using memoization with a 2D matrix `t`, this implementation uses bottom-up dynamic programming with a 2D matrix `dp`. Both approaches achieve the same goal of efficiently solving the "Predict the Winner" problem and have similar time and space complexities.

```go
func max(a, b int) int {
	if a > b {
		return a
	}
	return b
}

func PredictTheWinner(nums []int) bool {
	n := len(nums)
	dp := make([][]int, n)
	for i := 0; i < n; i++ {
		dp[i] = make([]int, n)
	}

	for i := n - 1; i >= 0; i-- {
		for j := i; j < n; j++ {
			if i == j {
				dp[i][j] = nums[i]
			} else {
				dp[i][j] = max(nums[i]-dp[i+1][j], nums[j]-dp[i][j-1])
			}
		}
	}

	return dp[0][n-1] >= 0
}
```

## Bit-Mask

```go
func PredictTheWinner(arr []int) bool {
	if len(arr) <= 1 {
		return true
	}
	dp := make([]int, 1<<len(arr))
	tar := 0
	for i := 0; i < len(arr); i++ {
		tar += 1 << i
	}
	val := solve(arr, 0, dp, tar)
	return val >= 0
}

func solve(arr []int, current int, dp []int, tar int) int {
	if current == tar {
		return 0 // all integers have been picked
	}
	if dp[current] != 0 {
		return dp[current] // cache
	}
	// max := math.MinInt32
	max := -2147483648

	for i := 0; i < len(arr); i++ {
		// finding first unpicked integer
		if current&(1<<i) == 0 {
			max = _max(max, arr[i]-solve(arr, (current|(1<<i)), dp, tar))
			break
		}
	}

	for i := len(arr) - 1; i >= 0; i-- {
		// finding last unpicked integer
		if current&(1<<i) == 0 {
			max = _max(max, arr[i]-solve(arr, (current|(1<<i)), dp, tar))
			break
		}
	}
	dp[current] = max
	return max
}

func _max(a, b int) int {
	if a > b {
		return a
	}
	return b
}
```

## [GitHub](https://github.com/ayoubzulfiqar/leetcode)