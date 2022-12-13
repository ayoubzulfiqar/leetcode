/*

-* 931. Minimum Falling Path Sum *-


Given an n x n array of integers matrix, return the minimum sum of any falling path through matrix.

A falling path starts at any element in the first row and chooses the element in the next row that is either directly below or diagonally left/right. Specifically, the next element from position (row, col) will be (row + 1, col - 1), (row + 1, col), or (row + 1, col + 1).

 

Example 1:


Input: matrix = [[2,1,3],[6,5,4],[7,8,9]]
Output: 13
Explanation: There are two falling paths with a minimum sum as shown.
Example 2:


Input: matrix = [[-19,57],[-40,-5]]
Output: -59
Explanation: The falling path with a minimum sum is shown.
 

Constraints:

n == matrix.length == matrix[i].length
1 <= n <= 100
-100 <= matrix[i][j] <= 100



*/

import 'dart:math';

/*

Approach: This problem has an optimal substructure, meaning that the solutions to sub-problems can be used to solve larger instances of this problem. This makes dynamic programming came into existence.

Let dp[R][C] be the minimum total weight of a falling path starting at [R, C] in first row and reaching to the bottom row of A.
Then, dp[R][C] = A[R][C] + min(dp[R+1, C-1], dp[R+1, C], dp[R+1, C+1])          , and the answer is minimum value of first row i:e \underset{C}{min}\; dp(0, C)          .
We would make an auxiliary array dp to cache intermediate values dp[R][C]. However, we will use A to cache these values. Our goal is to transform the values of A into the values of dp.
We begins processing each row, starting with the second last row. We set A[R][C] = min(A[R+1, C-1], A[R+1, C], A[R+1, C+1])          , handling boundary conditions gracefully.
*/
class A {
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

class B {
  // Top Down O(n2)
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

class C {
  // int n = 3;
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
