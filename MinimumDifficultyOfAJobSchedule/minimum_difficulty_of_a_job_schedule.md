# 🔥 Minimum Difficulty of a Job Schedule 🔥 || Simple Fast and Easy || with Explanation

## Solution - 1 Dp Bottom UP

### Bottom-up DP

State f(i,j):= minimized sum of sub-array maximum when splitting A[0..j] into i sub-arrays. (Use a shorter name A for jobDifficulty)
Function f(i,j) = min{f(i-1,k) + max(A[k+1..j]), i - 2 <= k < j
Initialization f(1,j) = max(A[0..j]), f(i,j) = -1 if i > j + 1
Answer is f(d,n-1)

```dart
class Solution {
// Runtime: 1382 ms, faster than 100.00% of Dart online submissions for Minimum Difficulty of a Job Schedule.
// Memory Usage: 152.5 MB, less than 100.00% of Dart online submissions for Minimum Difficulty of a Job Schedule.

  int minDifficulty(List<int> jobDifficulty, int d) {
    if (jobDifficulty.length < d || d <= 0) {
      return -1;
    }
    int n = jobDifficulty.length;
    List<int> dp = List.filled(n, 0);

    // initialization for d = 1
    dp[0] = jobDifficulty[0];
    for (int i = 1; i < n; i++) {
      dp[i] = max(dp[i - 1], jobDifficulty[i]);
    }

    for (int i = 2; i <= d; i++) {
      for (int j = n - 1; j >= i - 1; j--) {
        // space optimization requires this
        dp[j] = double.maxFinite.toInt();

        int lastMax = jobDifficulty[j]; // last sub-array's max difficulty
        for (int k = j - 1; k >= i - 2; k--) {
          // assume second last sub-array ends at A[k]
          lastMax = max(lastMax, jobDifficulty[k + 1]); // max(A[k+1..j])
          dp[j] = min(dp[j], lastMax + dp[k]);
        }
      }
    }
    return dp[n - 1];
  }
}
```

### Disclaimer - DART

There are many solution that i implemented Like Recursion, DP Top to Bottom and one and two others but most of them are end up with `TIME LIMIT EXCEED` error. Maybe the things are not very optimized. Only one solution work in my case Bottom Up DP.

## Solution - 2 - Golang

```go
var mem [][]int

func max(x, y int) int {
	if x > y {
		return x
	}
	return y
}

func min(x, y int) int {
	if x < y {
		return x
	}
	return y
}

func minDifficulty(jd []int, d int) int {
	if d > len(jd) {
		return -1
	}

	mem = make([][]int, len(jd))
	for i := 0; i < len(mem); i++ {
		mem[i] = make([]int, d+1)
		for j := range mem[i] {
			mem[i][j] = -1
		}
	}

	return dp(jd, 0, d)
}

func dp(jd []int, start, day int) (ans int) {
	if mem[start][day] != -1 {
		return mem[start][day]
	}
	defer func() { mem[start][day] = ans }()

	if day == 1 {
		ans = jd[start]
		for i := start; i < len(jd); i++ {
			ans = max(jd[i], ans)
		}
		return
	}

	curMax := -1
	ans = math.MaxInt32
	for i := start; len(jd)-i > day-1; i++ {
		curMax = max(curMax, jd[i])
		result := curMax + dp(jd, i+1, day-1)
		ans = min(ans, result)
	}
	return ans
}

```
