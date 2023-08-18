/*

-* 542. 01 Matrix *-


Given an m x n binary matrix mat, return the distance of the nearest 0 for each cell.

The distance between two adjacent cells is 1.

 

Example 1:


Input: mat = [[0,0,0],[0,1,0],[0,0,0]]
Output: [[0,0,0],[0,1,0],[0,0,0]]
Example 2:


Input: mat = [[0,0,0],[0,1,0],[1,1,1]]
Output: [[0,0,0],[0,1,0],[1,2,1]]
 

Constraints:

m == mat.length
n == mat[i].length
1 <= m, n <= 104
1 <= m * n <= 104
mat[i][j] is either 0 or 1.
There is at least one 0 in mat.


*/
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
