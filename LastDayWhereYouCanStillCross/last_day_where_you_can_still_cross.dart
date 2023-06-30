/*


-* 1970. Last Day Where You Can Still Cross *-



There is a 1-based binary matrix where 0 represents land and 1 represents water. You are given integers row and col representing the number of rows and columns in the matrix, respectively.

Initially on day 0, the entire matrix is land. However, each day a new cell becomes flooded with water. You are given a 1-based 2D array cells, where cells[i] = [ri, ci] represents that on the ith day, the cell on the rith row and cith column (1-based coordinates) will be covered with water (i.e., changed to 1).

You want to find the last day that it is possible to walk from the top to the bottom by only walking on land cells. You can start from any cell in the top row and end at any cell in the bottom row. You can only travel in the four cardinal directions (left, right, up, and down).

Return the last day where it is possible to walk from the top to the bottom by only walking on land cells.

 

Example 1:


Input: row = 2, col = 2, cells = [[1,1],[2,1],[1,2],[2,2]]
Output: 2
Explanation: The above image depicts how the matrix changes each day starting from day 0.
The last day where it is possible to cross from top to bottom is on day 2.
Example 2:


Input: row = 2, col = 2, cells = [[1,1],[1,2],[2,1],[2,2]]
Output: 1
Explanation: The above image depicts how the matrix changes each day starting from day 0.
The last day where it is possible to cross from top to bottom is on day 1.
Example 3:


Input: row = 3, col = 3, cells = [[1,2],[2,1],[3,3],[2,2],[1,1],[1,3],[2,3],[3,2],[3,1]]
Output: 3
Explanation: The above image depicts how the matrix changes each day starting from day 0.
The last day where it is possible to cross from top to bottom is on day 3.
 

Constraints:

2 <= row, col <= 2 * 104
4 <= row * col <= 2 * 104
cells.length == row * col
1 <= ri <= row
1 <= ci <= col
All the values of cells are unique.


*/

// class Solution {
//   int latestDayToCross(int row, int col, List<List<int>> cells) {

//   }
// }

import 'dart:collection';

class A {
  bool isPossible(int m, int n, int t, List<List<int>> cells) {
    List<List<int>> grid = List.generate(
        m + 1, (_) => List.filled(n + 1, 0)); // Grid representation
    List<List<int>> directions = [
      [1, 0],
      [-1, 0],
      [0, 1],
      [0, -1]
    ]; // Possible directions

    for (int i = 0; i < t; i++) {
      grid[cells[i][0]][cells[i][1]] =
          1; // Mark cells from the given list as blocked
    }

    Queue<List<int>> queue = Queue<List<int>>();

    for (int i = 1; i <= n; i++) {
      if (grid[1][i] == 0) {
        queue.add([1, i]); // Start BFS from the top row
        grid[1][i] = 1; // Mark the cell as visited
      }
    }

    while (queue.isNotEmpty) {
      List<int> cell = queue.removeFirst();
      int r = cell[0], c = cell[1]; // Current cell coordinates

      for (List<int> dir in directions) {
        int nr = r + dir[0], nc = c + dir[1]; // Neighbor cell coordinates

        if (nr > 0 && nc > 0 && nr <= m && nc <= n && grid[nr][nc] == 0) {
          grid[nr][nc] = 1; // Mark the neighbor cell as visited

          if (nr == m) {
            return true; // Found a path to the bottom row
          }

          queue.add([
            nr,
            nc
          ]); // Add the neighbor cell to the queue for further exploration
        }
      }
    }

    return false; // Unable to find a path to the bottom row
  }

  int latestDayToCross(int row, int col, List<List<int>> cells) {
    int left = 0, right = row * col, latestPossibleDay = 0;

    while (left < right - 1) {
      int mid = left + ((right - left) ~/ 2); // Calculate the mid-day

      if (isPossible(row, col, mid, cells)) {
        left = mid; // Update the left pointer to search in the upper half
        latestPossibleDay = mid; // Update the latest possible day
      } else {
        right = mid; // Update the right pointer to search in the lower half
      }
    }

    return latestPossibleDay;
  }
}

//-----------

/*
This is Recursive - STACK OVER FLOW

class Solution {
  late int n, m;
  final List<int> d = [0, 1, 0, -1, 0];

  bool dfs(List<List<int>> vis, List<List<int>> v, int i, int j) {
    vis[i][j] = 1;
    if (i == n - 1) return true;
    bool ans = false;
    for (int k = 0; k < 4; k++) {
      int ni = i + d[k];
      int nj = j + d[k + 1];
      if (ni >= 0 &&
          nj >= 0 &&
          ni < n &&
          nj < m &&
          vis[ni][nj] == 0 &&
          v[ni][nj] == 0) {
        ans |= dfs(vis, v, ni, nj);
      }
    }
    return ans;
  }

  int latestDayToCross(int row, int col, List<List<int>> cell) {
    int l = 0, r = cell.length - 1;
    n = row;
    m = col;
    int day = 0;
    while (l <= r) {
      int mid = (l + r) ~/ 2;
      List<List<int>> v = List.generate(row, (_) => List<int>.filled(col, 0));
      for (int i = 0; i <= mid; i++) {
        v[cell[i][0] - 1][cell[i][1] - 1] = 1;
      }
      List<List<int>> vis = List.generate(row, (_) => List<int>.filled(col, 0));
      bool ans = false;
      for (int i = 0; i < col; i++) {
        if (vis[0][i] == 0 && v[0][i] == 0) {
          ans |= dfs(vis, v, 0, i);
        }
      }
      if (ans) {
        day = mid;
        l = mid + 1;
      } else {
        r = mid - 1;
      }
    }
    return day + 1;
  }
}
*/

//----------------- Iterative
class B {
  late int n, m;
  List<int> d = [0, 1, 0, -1, 0];

  bool dfs(List<List<int>> vis, List<List<int>> v, int i, int j) {
    vis[i][j] = 1;
    List<dynamic> stack = [];
    stack.add([i, j]);
    bool ans = false;

    while (stack.isNotEmpty) {
      var cell = stack.removeLast();
      int r = cell[0], c = cell[1];

      if (r == n - 1) {
        ans = true;
        break;
      }

      for (int k = 0; k < 4; k++) {
        int nr = r + d[k];
        int nc = c + d[k + 1];
        if (nr >= 0 &&
            nc >= 0 &&
            nr < n &&
            nc < m &&
            vis[nr][nc] == 0 &&
            v[nr][nc] == 0) {
          vis[nr][nc] = 1;
          stack.add([nr, nc]);
        }
      }
    }
    return ans;
  }

  int latestDayToCross(int row, int col, List<List<int>> cell) {
    int l = 0, r = cell.length - 1;
    n = row;
    m = col;
    int day = 0;
    while (l <= r) {
      int mid = (l + r) ~/ 2;
      List<List<int>> v = List.generate(row, (_) => List<int>.filled(col, 0));
      for (int i = 0; i <= mid; i++) {
        v[cell[i][0] - 1][cell[i][1] - 1] = 1;
      }
      List<List<int>> vis = List.generate(row, (_) => List<int>.filled(col, 0));
      bool ans = false;
      for (int i = 0; i < col; i++) {
        if (vis[0][i] == 0 && v[0][i] == 0) {
          ans |= dfs(vis, v, 0, i);
        }
      }
      if (ans) {
        day = mid;
        l = mid + 1;
      } else {
        r = mid - 1;
      }
    }
    return day + 1;
  }
}

//----------- Union Find

class Solution {
  late List<int> p; // Union-Find data structure

  int find(int x) {
    return p[x] < 0 ? x : p[x] = find(p[x]);
  }

  void uni(int x, int y) {
    x = find(x);
    y = find(y);
    if (x == y) return;
    p[y] = x;
  }

  final List<List<int>> dir = [
    [-1, 0],
    [1, 0],
    [0, 1],
    [0, -1]
  ];

  int latestDayToCross(int row, int col, List<List<int>> cells) {
    List<List<int>> grid = List.generate(row, (_) => List<int>.filled(col, 1));
    p = List<int>.filled(row * col + 3, -1);

    int startG = row * col + 1, endG = row * col + 2;
    for (int j = 0; j < col; j++) {
      uni(j, startG);
      uni((row - 1) * col + j, endG);
    }

    for (int i = row * col - 1; i >= 0; --i) {
      int r = cells[i][0] - 1, c = cells[i][1] - 1;
      grid[r][c] = 0;
      int key = r * col + c;
      for (int k = 0; k < 4; ++k) {
        int nr = r + dir[k][0], nc = c + dir[k][1];
        if (nr >= 0 && nr < row && nc >= 0 && nc < col && grid[nr][nc] == 0) {
          int nKey = nr * col + nc;
          uni(key, nKey);
        }
        if (find(startG) == find(endG)) {
          return i;
        }
      }
    }

    return row * col - 1;
  }
}
