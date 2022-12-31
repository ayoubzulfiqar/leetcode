# 🔥 Unique Path - III 🔥 || 2 Solutions || Simple Fast and Easy || with Explanation

## Explanation

The Idea is pretty simple and institutive(in my opinion).

When we are at grid[i,j], we have 4 paths that can be traversed: Up(i-1,j), Down(i+1,j), Left(i,j-1) and Right(i,j+1), except for edges.

Now when I move right from lets say 0,0 to 0,1; at 0,1 i would again make a choice to go left to 0,0 this cannot be allowed, hence we use a boolean matrix to track the path of recursion.

Also, since the starting point could be anywhere, we need to iterate the matrix initially to find the starting i and j, I clubbed counting the number of nodes to visit calculation in this loop. This will help avoid a full boolean matrix scan when we reach "end" point to see if every node has been visited

## Solution - 1 Depth First Search

```dart
class Solution {
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
    depthFirstSearch(grid, row, col, 0);
    return res;
  }

  void depthFirstSearch(List<List<int>> grid, int row, int col, int walked) {
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
```

## Solution - 2 Recursion

```dart
class Solution {
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
```
