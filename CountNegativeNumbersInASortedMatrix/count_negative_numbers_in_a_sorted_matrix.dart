/*


-* 1351. Count Negative Numbers in a Sorted Matrix *-

Given a m x n matrix grid which is sorted in non-increasing order both row-wise and column-wise, return the number of negative numbers in grid.

 

Example 1:

Input: grid = [[4,3,2,-1],[3,2,1,-1],[1,1,-1,-2],[-1,-1,-2,-3]]
Output: 8
Explanation: There are 8 negatives number in the matrix.
Example 2:

Input: grid = [[3,2],[1,0]]
Output: 0
 

Constraints:

m == grid.length
n == grid[i].length
1 <= m, n <= 100
-100 <= grid[i][j] <= 100
 

Follow up: Could you find an O(n + m) solution?





*/

class A {
  int countNegatives(List<List<int>> grid) {
    int count = 0;
    final int rows = grid.length;
    final int columns = grid[0].length;
    int row = 0;
    int column = columns - 1;
    while (row < rows && column >= 0) {
      if (grid[row][column] < 0) {
        count += (column + 1);
        row += 1;
      } else {
        column -= 1;
      }
    }
    return count;
  }
}

class B {
  int countNegatives(List<List<int>> grid) {
    int count = 0;
    final int rows = grid.length;
    final int cols = grid[0].length;
    int row = rows - 1;
    int col = 0;

    while (col < cols && row >= 0) {
      if (grid[row][col] < 0) {
        count += cols - col;
        row--;
      } else {
        col++;
      }
    }

    return count;
  }
}

class C {
  int countNegatives(List<List<int>> grid) {
    final int gridRowsLength = grid.length;
    int count = 0;

    for (int i = 0; i < gridRowsLength; i++) {
      grid[i].sort();
      final int upperBoundCalculation = binarySearch(grid[i], -1);
      count += grid[i].length - upperBoundCalculation;
    }

    return count;
  }

  int binarySearch(List<int> list, int target) {
    int start = 0;
    int end = list.length;

    while (start < end) {
      final int mid = start + ((end - start) ~/ 2);
      if (list[mid] > target) {
        start = mid + 1;
      } else {
        end = mid;
      }
    }

    return start;
  }
}

class Solution {
  int countNegatives(List<List<int>> grid) {
    int count = 0;

    for (List<int> row in grid) {
      int ub = row.reversed.toList().lastIndexWhere((element) => element < 0);
      count += ub + 1;
    }

    return count;
  }
}
