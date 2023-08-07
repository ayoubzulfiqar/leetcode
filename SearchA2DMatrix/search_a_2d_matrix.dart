/*



-* 74. Search a 2D Matrix *-

You are given an m x n integer matrix matrix with the following two properties:

Each row is sorted in non-decreasing order.
The first integer of each row is greater than the last integer of the previous row.
Given an integer target, return true if target is in matrix or false otherwise.

You must write a solution in O(log(m * n)) time complexity.

 

Example 1:


Input: matrix = [[1,3,5,7],[10,11,16,20],[23,30,34,60]], target = 3
Output: true
Example 2:


Input: matrix = [[1,3,5,7],[10,11,16,20],[23,30,34,60]], target = 13
Output: false
 

Constraints:

m == matrix.length
n == matrix[i].length
1 <= m, n <= 100
-104 <= matrix[i][j], target <= 104


*/

class A {
  bool searchMatrix(List<List<int>> matrix, int target) {
    final List<int> innerList =
        matrix.expand((innerArray) => innerArray).toList();
    return innerList.contains(target);
  }
}

class Solution {
  int search(List<int> v, int target) {
    final int index = lowerBound(v, target);
    return index;
  }

  bool searchMatrix(List<List<int>> matrix, int target) {
    final int n = matrix.length;
    final int m = matrix[0].length;

    if (n == 1) {
      final int j = search(matrix[0], target);
      if (j == m) return false;
      return matrix[0][j] == target;
    }

    final List<int> col0 = List<int>.generate(n, (i) => matrix[i][0]);

    final int i0 = search(col0, target);

    if (i0 == n) {
      final int j = search(matrix[i0 - 1], target);
      if (j == m) return false;
      return matrix[i0 - 1][j] == target;
    } else if (col0[i0] == target) {
      return true;
    } else if (i0 == 0) {
      return false;
    } else {
      final int j = search(matrix[i0 - 1], target);
      if (j == m) return false;
      return matrix[i0 - 1][j] == target;
    }
  }

  int lowerBound(List<int> array, int target) {
    int left = 0;
    int right = array.length;
    while (left < right) {
      int mid = left + (right - left) ~/ 2;
      if (array[mid] < target) {
        left = mid + 1;
      } else {
        right = mid;
      }
    }
    return left;
  }
}
