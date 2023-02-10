/*

-* 1162. As Far from Land as Possible *-



Given an n x n grid containing only values 0 and 1, where 0 represents water and 1 represents land, find a water cell such that its distance to the nearest land cell is maximized, and return the distance. If no land or water exists in the grid, return -1.

The distance used in this problem is the Manhattan distance: the distance between two cells (x0, y0) and (x1, y1) is |x0 - x1| + |y0 - y1|.

 

Example 1:


Input: grid = [[1,0,1],[0,0,0],[1,0,1]]
Output: 2
Explanation: The cell (1, 1) is as far as possible from all the land with distance 2.
Example 2:


Input: grid = [[1,0,0],[0,0,0],[0,0,0]]
Output: 4
Explanation: The cell (2, 2) is as far as possible from all the land with distance 4.
 

Constraints:

n == grid.length
n == grid[i].length
1 <= n <= 100
grid[i][j] is 0 or 1


*/
import 'dart:collection';
import 'dart:math';

// TLE
class A {
  int maxDistance(List<List<int>> grid) {
    int n = grid.length;
    Queue<List<int>> q = Queue();
    for (int i = 0; i < n; i++) {
      for (int j = 0; j < n; j++) {
        if (grid[i][j] == 1) q.add([i, j]);
      }
    }
    if (q.isEmpty || q.length == n * n) return -1;
    int res = -1;
    List<List<int>> dirs = [
      [0, 1],
      [0, -1],
      [1, 0],
      [-1, 0]
    ];
    while (q.isNotEmpty) {
      int size = q.length;
      res++;
      while (size-- > 0) {
        // poll == first
        List<int> cell = q.first;
        int x = cell[0], y = cell[1];
        for (List<int> dir in dirs) {
          int i = x + dir[0], j = y + dir[1];
          if (i >= 0 && i < n && j >= 0 && j < n && grid[i][j] == 0) {
            grid[i][j] = 1;
            q.add([i, j]);
          }
        }
      }
    }
    return res;
  }
}

class B {
  int maxDistance(List<List<int>> grid) {
    int m = grid.length;
    int n = grid[0].length;
    int x = n + m;
    for (int i = 0; i < m; i++) {
      for (int j = 0; j < n; j++) {
        if (grid[i][j] == 1) {
          continue;
        }
        int top = x;
        int left = x;
        if (i - 1 >= 0) top = grid[i - 1][j];
        if (j - 1 >= 0) left = grid[i][j - 1];
        grid[i][j] = min(top, left) + 1;
      }
    }
    for (int i = m - 1; i >= 0; i--) {
      for (int j = n - 1; j >= 0; j--) {
        if (grid[i][j] == 1) {
          continue;
        }
        int bottom = x;
        int right = x;
        if (i + 1 < m) bottom = grid[i + 1][j];
        if (j + 1 < n) right = grid[i][j + 1];
        grid[i][j] = min(grid[i][j], min(bottom, right) + 1);
      }
    }
    // int.MinValue
    int count = 0;
    for (int i = 0; i < m; i++) {
      for (int j = 0; j < n; j++) {
        count = max(count, grid[i][j]);
      }
    }
    return count - 1 == n + m + 1 || count - 1 == 0 ? -1 : count - 1;
  }
}
