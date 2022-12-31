/*

-* 980. Unique Paths III *-

You are given an m x n integer array grid where grid[i][j] could be:

1 representing the starting square. There is exactly one starting square.
2 representing the ending square. There is exactly one ending square.
0 representing empty squares we can walk over.
-1 representing obstacles that we cannot walk over.
Return the number of 4-directional walks from the starting square to the ending square, that walk over every non-obstacle square exactly once.

 

Example 1:


Input: grid = [[1,0,0,0],[0,0,0,0],[0,0,2,-1]]
Output: 2
Explanation: We have the following two paths: 
1. (0,0),(0,1),(0,2),(0,3),(1,3),(1,2),(1,1),(1,0),(2,0),(2,1),(2,2)
2. (0,0),(1,0),(2,0),(2,1),(1,1),(0,1),(0,2),(0,3),(1,3),(1,2),(2,2)
Example 2:


Input: grid = [[1,0,0,0],[0,0,0,0],[0,0,0,2]]
Output: 4
Explanation: We have the following four paths: 
1. (0,0),(0,1),(0,2),(0,3),(1,3),(1,2),(1,1),(1,0),(2,0),(2,1),(2,2),(2,3)
2. (0,0),(0,1),(1,1),(1,0),(2,0),(2,1),(2,2),(1,2),(0,2),(0,3),(1,3),(2,3)
3. (0,0),(1,0),(2,0),(2,1),(2,2),(1,2),(1,1),(0,1),(0,2),(0,3),(1,3),(2,3)
4. (0,0),(1,0),(2,0),(2,1),(1,1),(0,1),(0,2),(0,3),(1,3),(1,2),(2,2),(2,3)
Example 3:


Input: grid = [[0,1],[2,0]]
Output: 0
Explanation: There is no path that walks over every empty square exactly once.
Note that the starting and ending square can be anywhere in the grid.
 

Constraints:

m == grid.length
n == grid[i].length
1 <= m, n <= 20
1 <= m * n <= 20
-1 <= grid[i][j] <= 2
There is exactly one starting cell and one ending cell.


*/

class A {
  int walks = 0;
  int res = 0;
  static final List<List<int>> values = [
    [0, 1],
    [0, -1],
    [-1, 0],
    [1, 0],
  ];
  int uniquePathsIII(List<List<int>> grid) {
    res = 0;
    walks = 0;
    int row = 0, col = 0;
    for (int i = 0; i < grid.length; i++) {
      for (int j = 0; j < grid[i].length; j++) {
        if (grid[i][j] == 0) {
          walks++;
        } else if (grid[i][j] == 1) {
          row = i;
          col = j;
        }
      }
    }
    dfs(grid, row, col, 0);
    return res;
  }

  void dfs(List<List<int>> grid, int row, int col, int walked) {
    if (row < 0 ||
        row >= grid.length ||
        col < 0 ||
        col >= grid[row].length ||
        grid[row][col] < 0) {
      return;
    }
    if (grid[row][col] == 2 && walked == walks + 1) {
      res++;
      return;
    }
    final int val = grid[row][col];
    grid[row][col] = -2;
    for (List<int> next in values) {
      dfs(grid, row + next[0], col + next[1], walked + 1);
    }
    grid[row][col] = val;
  }
}

class B {
  int path = 0;
  int sx = 0;
  int sy = 0;
  int m = 0;
  int n = 0;
  int zeros = 0;
  int uniquePathsIII(List<List<int>> grid) {
    m = grid.length;
    n = grid[0].length;
    List<List<bool>> used =
        List.filled(m, false).map((e) => List.filled(n, false)).toList();

    for (int i = 0; i < m; i++)
      for (int j = 0; j < n; j++) {
        if (grid[i][j] == 1) {
          sx = i;
          sy = j;
        } else if (grid[i][j] == 0) zeros++;
      }

    solve(grid, used, sx, sy, 0);

    return path;
  }

  void solve(
      List<List<int>> grid, List<List<bool>> used, int x, int y, int cnt) {
    if (grid[x][y] == -1) {
      return;
    }
    if (grid[x][y] == 2) {
      if (cnt - 1 == zeros) {
        path++;
      }
      return;
    }
    used[x][y] = true;

    if (y + 1 < n && grid[x][y + 1] != -1 && !used[x][y + 1]) {
      solve(grid, used, x, y + 1, cnt + 1);
      used[x][y + 1] = false;
    }
    if (x + 1 < m && grid[x + 1][y] != -1 && !used[x + 1][y]) {
      solve(grid, used, x + 1, y, cnt + 1);
      used[x + 1][y] = false;
    }
    if (y - 1 >= 0 && grid[x][y - 1] != -1 && !used[x][y - 1]) {
      solve(grid, used, x, y - 1, cnt + 1);
      used[x][y - 1] = false;
    }
    if (x - 1 >= 0 && grid[x - 1][y] != -1 && !used[x - 1][y]) {
      solve(grid, used, x - 1, y, cnt + 1);
      used[x - 1][y] = false;
    }
  }
}
