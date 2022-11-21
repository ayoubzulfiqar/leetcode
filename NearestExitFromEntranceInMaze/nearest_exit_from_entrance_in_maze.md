# 🔥 Nearest Exit from Entrance in Maze 🔥 || 3 Approaches|| Simple Fast and Easy || with Explanation

## Solution - 1

```dart
import 'dart:collection';

class Solution {
  // Runtime: 765 ms, faster than 100.00% of Dart online submissions for Nearest Exit from Entrance in Maze.
// Memory Usage: 154.9 MB, less than 100.00% of Dart online submissions for Nearest Exit from Entrance in Maze.
  int nearestExit(List<List<String>> maze, List<int> entrance) {
    int rows = maze.length;
    int columns = maze[0].length;

    // For breadth first search, offer the first node ('entrance').
    // Note that we immediately mark the node as visited when putting into the queue as to
    // prevent other nodes from visiting it. Otherwise, we will be trapped in an infinite loop.
    Queue<List<int>> queue = Queue();
    queue.add(entrance);
    maze[entrance[0]][entrance[1]] = '+';

    // As simple 2D array to keep track of the directions to take.
    // We can use 4 separate operation, but it is more efficient to use a for-loop to go through the four directions.
    List<List<int>> directions = [
      [0, 1],
      [0, -1],
      [1, 0],
      [-1, 0]
    ];

    int steps = 0;
    int x, y;
    while (queue.isNotEmpty) {
      // We take a step before checking the directions for the nodes that we are at (in the queue).
      steps++;

      // Make sure to use a variable to keep track of the queue.size(),
      // because the queue size continuously changes as we check for the other nodes,
      // which can lead to infinite loops or undue termination of the for-loop.
      int n = queue.length;

      // Check every node at the current step.
      for (int i = 0; i < n; i++) {
        List<int> current = queue.removeFirst();
        // For each node, check every direction.
        for (List<int> direction in directions) {
          x = current[0] + direction[0];
          y = current[1] + direction[1];

          // Check if this direction out of bound.
          if (x < 0 || x >= rows || y < 0 || y >= columns) continue;
          // Check if this direction is the wall.
          if (maze[x][y] == '+') continue;

          // If this direction is empty, not visited and is at the boundary, we have arrived at the exit.
          if (x == 0 || x == rows - 1 || y == 0 || y == columns - 1)
            return steps;

          // Otherwise, we change this direction as visited and put into the queue to check at the next step.
          maze[x][y] = '+';
          queue.add([x, y]);
        }
      }
    }
    // If all the possible nodes and directions checked but no exits found, return -1.
    return -1;
  }
}
```

## Solution - 2

```dart
class Pair {
  late int row;
  late int col;
  late int dist;
  Pair(int row, int col, int dist) {
    this.row = row;
    this.col = col;
    this.dist = dist;
  }
}
```

```dart
import 'dart:collection';

class Solution {
  // Runtime: 613 ms, faster than 100.00% of Dart online submissions for Nearest Exit from Entrance in Maze.
// Memory Usage: 177.1 MB, less than 100.00% of Dart online submissions for Nearest Exit from Entrance in Maze.
  int nearestExit(List<List<String>> maze, List<int> entrance) {
    int m = maze.length;
    int n = maze[0].length;
    List<List<int>> vis =
        List.filled(m, 0).map((e) => List.filled(n, 0)).toList();
    maze[entrance[0]][entrance[1]] = '*';

    Queue<Pair> q = Queue();
    for (int i = 0; i < m; i++) {
      if (vis[i][0] == 0 && maze[i][0] == '.') {
        q.add(new Pair(i, 0, 0));
        vis[i][0] = 1;
      }

      if (vis[i][n - 1] == 0 && maze[i][n - 1] == '.') {
        q.add(new Pair(i, n - 1, 0));
        vis[i][n - 1] = 1;
      }
    }

    for (int i = 0; i < n; i++) {
      if (vis[0][i] == 0 && maze[0][i] == '.') {
        q.add(new Pair(0, i, 0));
        vis[0][i] = 1;
      }
      if (vis[m - 1][i] == 0 && maze[m - 1][i] == '.') {
        q.add(Pair(m - 1, i, 0));
        vis[m - 1][i] = 1;
      }
    }

    List<int> delRow = [-1, 1, 0, 0];
    List<int> delCol = [0, 0, -1, 1];

    while (q.isNotEmpty) {
      int row = q.first.row;
      int col = q.first.col;
      int dist = q.first.dist;
      q.removeFirst();
      for (int i = 0; i < 4; i++) {
        int nRow = row + delRow[i];
        int nCol = col + delCol[i];

        if (nRow >= 0 &&
            nRow < m &&
            nCol >= 0 &&
            nCol < n &&
            vis[nRow][nCol] == 0 &&
            maze[nRow][nCol] == '*') return dist + 1;

        if (nRow >= 0 &&
            nRow < m &&
            nCol >= 0 &&
            nCol < n &&
            vis[nRow][nCol] == 0 &&
            maze[nRow][nCol] == '.') {
          vis[nRow][nCol] = 1;
          q.add(new Pair(nRow, nCol, dist + 1));
        }
      }
    }
    return -1;
  }
}
```

## Solution - 3 Depth First Search - It's not working Some Edge Cases Fails

```dart
class Solution {
  List<List<int>> dp =
      List.filled(101, 0).map((e) => List.filled(101, 0)).toList();
  List<List<bool>> visited =
      List.filled(101, false).map((e) => List.filled(101, false)).toList();
  late int i;
  late int j;
  int nearestExit(List<List<String>> maze, List<int> entrance) {
    int m = maze.length;
    int n = maze[0].length;
    i = entrance[0];
    j = entrance[1];
    int res = dfs(maze, i, j, m, n);
    return res >= 10001 ? -1 : res;
  }

  int dfs(List<List<String>> maze, int row, int col, int m, int n) {
    if (row < 0 ||
        row >= m ||
        col < 0 ||
        col >= n ||
        maze[row][col] == '+' ||
        visited[row][col]) {
      return 10001;
    } else if (dp[row][col] != 0) {
      return dp[row][col];
    } else if (isExit(row, col, m, n) && !isEntrance(row, col)) {
      return dp[row][col] = 0;
    }

    visited[row][col] = true;
    // int down = dfs(maze, row + 1, col, m, n);
    // int up = dfs(maze, row - 1, col, m, n);
    // int right = dfs(maze, row, col + 1, m, n);
    // int left = dfs(maze, row, col - 1, m, n);
    int up = dfs(maze, row - 1, col, m, n);
    int right = dfs(maze, row, col + 1, m, n);
    int down = dfs(maze, row + 1, col, m, n);
    int left = dfs(maze, row, col - 1, m, n);
    visited[row][col] = false;

    return dp[row][col] = min(min(up, down), min(left, right)) + 1;
  }

  bool isExit(int row, int col, int m, int n) {
    if (row == 0 || row == m - 1 || col == 0 || col == n - 1) {
      return true;
    } else {
      return false;
    }
  }

  bool isEntrance(int row, int col) {
    if (row == i && col == j) {
      return true;
    } else {
      return false;
    }
  }
}
```
