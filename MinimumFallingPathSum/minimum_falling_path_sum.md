# 🔥 Minimum Falling Path Sum 🔥 || 3 Approaches || Simple Fast and Easy || with Explanation

## Solution - 1

### Time - O(n2)

### Space - O(1)

```dart
class Solution {
  int minFallingPathSum(List<List<int>> matrix) {
    int n = matrix.length;
    if (n == 1) return matrix[0][0];
    int mini = double.maxFinite.toInt();
    for (int i = 1; i < n; i++) {
      for (int j = 0; j < n; j++) {
        if (j == 0)
          matrix[i][j] += min(matrix[i - 1][j], matrix[i - 1][j + 1]);
        else if (j == n - 1)
          matrix[i][j] += min(matrix[i - 1][j], matrix[i - 1][j - 1]);
        else
          matrix[i][j] += min(matrix[i - 1][j],
              min(matrix[i - 1][j - 1], matrix[i - 1][j + 1]));
        if (i == n - 1) mini = min(mini, matrix[i][j]);
      }
    }
    return mini;
  }
}
```

## Solution - 2 Top Down

### Time - O(n2)

### Space - O(n2)

```dart
class Solution {
  int minFallingPathSum(List<List<int>> matrix) {
    int rows = matrix.length;
    int columns = matrix[0].length;
    List<List<int>> dp =
        List.filled(rows, 0).map((e) => List.filled(columns, 0)).toList();
    int ans = double.maxFinite.toInt();
    for (int column = 0; column < columns; column += 1) {
      ans = min(ans, minPathSum(rows - 1, column, matrix, dp));
    }
    return ans;
  }

  int minPathSum(
      int row, int column, List<List<int>> matrix, List<List<int>> dp) {
    if (row < 0) {
      return 0;
    }
    if (column < 0 || column >= matrix[0].length) {
      return 100000000;
    }
    if (dp[row][column] != 0) {
      return dp[row][column];
    }
    int ans = matrix[row][column] +
        min(
          minPathSum(row - 1, column - 1, matrix, dp),
          min(
            minPathSum(row - 1, column, matrix, dp),
            minPathSum(row - 1, column + 1, matrix, dp),
          ),
        );
    return dp[row][column] = ans;
  }
}
```

## Solution - 3

```dart
class Solution {
  // Bottom UP O(n2)
  int minFallingPathSum(List<List<int>> matrix) {
    //  BASE CASE:- if the matrix is empty
    if (matrix.length == 0) return 0;
    // 2D :- Matrix with fixed length
    // COLUMN :- matrix.length
    // ROW :- matrix[0].length
    List<List<int>> dp = List.filled(matrix.length, 0)
        .map((e) => List.filled(matrix[0].length, 0))
        .toList();
    // Height matrix
    int m = matrix.length;
    // width of the matrix
    int n = matrix[0].length;
    for (int i = 0; i < n; i++) {
      dp[m - 1][i] = matrix[m - 1][i];
    }

    for (int i = m - 2; i >= 0; i--) {
      for (int j = 0; j < n; j++) {
        int mini = double.maxFinite.toInt();
        if (j < n - 1) mini = min(dp[i + 1][j + 1], mini);
        if (j > 0) mini = min(dp[i + 1][j - 1], mini);
        mini = min(dp[i + 1][j], mini);

        dp[i][j] = matrix[i][j] + mini;
      }
    }
    int mini = double.maxFinite.toInt();
    for (int i = 0; i < n; i++) mini = min(dp[0][i], mini);

    return mini;
  }
}
```
