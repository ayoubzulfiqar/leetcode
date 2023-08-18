# 🔥 Greedy Matrix 🔥 || Simple Fast and Easy || with Explanation 😈

## Intuition

The intuition behind this solution is to iteratively update each cell in the matrix with the shortest distance to a 0 cell. This is done in multiple passes, first from the top-left to the bottom-right, then from the bottom-right to the top-left. During each pass, the algorithm checks neighboring cells and calculates the minimum distance based on their values.

## Approach

1. Initialize constants `n` and `m` representing the number of rows and columns in the matrix.
2. Check the top-left cell `(0, 0)` in the matrix:
   - If it is not 0, set its value to `m + n` (maximum distance).
3. Perform a top-down pass along the top row (`j`) and left column (`i`) of the matrix:
   - For each cell `(i, 0)` and `(0, j)` that is not 0, update its value to be the previous cell's value plus 1.
4. Perform a double loop iteration for the rest of the matrix:
   - For each cell `(i, j)` that is not 0, calculate its value as the minimum of the cell above it `(i-1, j)` and the cell to the left of it `(i, j-1)` plus 1.
5. Perform a bottom-up pass along the bottom row (`n-1`) and right column (`m-1`):
   - For each cell `(n-1, j)` and `(i, m-1)` that is not 0, update its value to be the minimum of its current value and the value of the adjacent cell plus 1.
6. Perform another double loop iteration for the matrix, this time from the bottom-right to the top-left:
   - Calculate the value of each cell `(i, j)` as the minimum of its current value and the minimum of the cell below it `(i+1, j)` and the cell to the right of it `(i, j+1)` plus 1.
7. Return the updated matrix.

## Time Complexity

- The matrix is traversed four times: two times for top-down and left-right updates, and two times for bottom-up and right-left updates. Each traversal takes O(n *m), where `n` is the number of rows and `m` is the number of columns. Therefore, the total time complexity is O(4* n *m), which simplifies to O(n* m).

## Space Complexity

- The algorithm uses a constant amount of extra space for storing indices and values, so the space complexity is O(1).

```dart
import 'dart:math';

class Solution {
  List<List<int>> updateMatrix(List<List<int>> mat) {
    final int n = mat.length;
    final int m = mat[0].length;
    if (mat[0][0] != 0) mat[0][0] = m + n;
    //Travel top down
    for (int j = 1; j < m; j++) {
      if (mat[0][j] != 0) mat[0][j] = mat[0][j - 1] + 1;
    }
    for (int i = 1; i < n; i++) {
      if (mat[i][0] != 0) mat[i][0] = mat[i - 1][0] + 1;
    }
    for (int i = 1; i < n; i++) {
      for (int j = 1; j < m; j++) {
        if (mat[i][j] != 0) mat[i][j] = min(mat[i - 1][j], mat[i][j - 1]) + 1;
      }
    }
    //Travel up
    for (int j = m - 2; j >= 0; j--) {
      if (mat[n - 1][j] != 0)
        mat[n - 1][j] = min(mat[n - 1][j], mat[n - 1][j + 1] + 1);
    }
    for (int i = n - 2; i >= 0; i--) {
      if (mat[i][m - 1] != 0)
        mat[i][m - 1] = min(mat[i][m - 1], mat[i + 1][m - 1] + 1);
    }
    for (int i = n - 2; i >= 0; i--) {
      for (int j = m - 2; j >= 0; j--) {
        if (mat[i][j] != 0)
          mat[i][j] = min(mat[i][j], min(mat[i + 1][j], mat[i][j + 1]) + 1);
      }
    }
    return mat;
  }
}
```

## [GitHub](https://github.com/ayoubzulfiqar/leetcode)
