# 🔥 Longest Common Subsequence 🔥 || 3 Approaches || Simple Fast and Easy || with Explanation

## Explanation

The general DP algorithm is to consider a grid of width len(text1) and height len(text2).

```dart
  t   e   n   s
t +---+---+---+---+
  | \ | \ | \ | \ |
h +---+---+---+---+
  | \ | \ | \ | \ |
e +---+---+---+---+
  | \ | \ | \ | \ |
  +---+---+---+---+
```

Each column is associated to a letter in text1.
Each row is associated to a letter in text2.
Here, you can see an example with "tens" and "the".

The goal is to find the longest path from the top-left corner the the bottom right corner by going always down or right or diagonally.
Going right means "not taking a letter from text1". So, it counts as an edge of length 0 in the paths.
Going down means "not taking a letter from text2". So, it counts as an edge of length 0 in the paths.
Going diagonally (down-right) is only possible for two identical letters. It means "taking a letter in both texts". So, it counts as an edge of length 1 in the paths.

Here's the solution for the previous example.

```dart
  t   e   n   s
t +
    \
h     +
      |
e     +
        \
          +---+---+
```

This corresponds to "te" (diagonal links), the LCS of size 2.

My solution uses only O(n) memory. It relies on the fact that each value on a line can be computed with the current and previous line.
If we wanted the whole subsequence, we would need to keep the whole grid. for backtracking. But since we are only interested in the length of the LCS, two lines is all we need.

## Solution - 1

### Complexity

- Time: O(mn), m is length of text1, n is length of text2
- Space: O(mn) --> can be optimized to O(min(m, n)) since only accessing previous row

```dart
class Solution {
  int longestCommonSubsequence(String text1, String text2) {
    if (text1.length < text2.length) {
      return LCS(text1, text2);
    }
    return LCS(text2, text1);
  }

  int LCS(String s1, String s2) {
    List<List<int>> M =
        List.filled(2, 0).map((e) => List.filled(s1.length + 1, 0)).toList();
    //row represents the length of s2, col represents the length of s1

    for (int i = 1; i <= s2.length; i++) {
      //base case
      M[i % 2][0] = 0;
      for (int j = 1; j <= s1.length; j++) {
        if (s1[j - 1] == s2[i - 1]) {
          M[i % 2][j] = M[(i - 1) % 2][j - 1] + 1;
        } else {
          M[i % 2][j] = max(
              M[(i - 1) % 2][j - 1], max(M[(i - 1) % 2][j], M[i % 2][j - 1]));
        }
      }
    }
    return M[s2.length % 2][s1.length];
  }
}
```

## Solution - 2

### Complexity

- Time: O(m*n),
- Space: O(n)

```dart
class Solution {
  int longestCommonSubsequence(String text1, String text2) {
    if (text1.length == 0 || text2.length == 0) return 0;
    int m = text1.length, n = text2.length;
    List<List<int>> dp =
        List.filled(2, 0).map((e) => List.filled(n + 1, 0)).toList();
    for (int i = 1; i <= m; i++) {
      for (int j = 1; j <= n; j++) {
        if (text1[i - 1] == text2[j - 1]) {
          dp[i % 2][j] = dp[(i - 1) % 2][j - 1] + 1;
        } else {
          dp[i % 2][j] = max(dp[i % 2][j - 1], dp[(i - 1) % 2][j]);
        }
      }
    }
    return dp[m % 2][n];
  }
}
```

## Solution - 3 - Optimized with One more LOOP

```dart
class Solution {
  int longestCommonSubsequence(String text1, String text2) {
    int n = text1.length;
    int m = text2.length;

    List<List<int>> dp =
        List.filled(n + 1, 0).map((e) => List.filled(m + 1, 0)).toList();
    if (text1[0] == text2[0]) {
      dp[0][0] = 1;
    } else {
      dp[0][0] = 0;
    }
    for (int i = 1; i < n; i++) {
      if (text1[i] == text2[0]) {
        dp[i][0] = 1;
      } else {
        dp[i][0] = dp[i - 1][0];
      }
    }
    for (int i = 1; i < m; i++) {
      if (text1[0] == text2[i]) {
        dp[0][i] = 1;
      } else {
        dp[0][i] = dp[0][i - 1];
      }
    }
    for (int i = 1; i < n; i++) {
      for (int j = 1; j < m; j++) {
        if (text1[i] == text2[j]) {
          dp[i][j] = 1 + dp[i - 1][j - 1];
        } else {
          dp[i][j] = max(dp[i - 1][j], dp[i][j - 1]);
        }
      }
    }
    return dp[n - 1][m - 1];
  }
}
```
