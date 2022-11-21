/*


 -* 1926. Nearest Exit from Entrance in Maze *-

 You are given an m x n matrix maze (0-indexed) with empty cells (represented as '.') and walls (represented as '+'). You are also given the entrance of the maze, where entrance = [entranceRow, entranceCol] denotes the row and column of the cell you are initially standing at.

In one step, you can move one cell up, down, left, or right. You cannot step into a cell with a wall, and you cannot step outside the maze. Your goal is to find the nearest exit from the entrance. An exit is defined as an empty cell that is at the border of the maze. The entrance does not count as an exit.

Return the number of steps in the shortest path from the entrance to the nearest exit, or -1 if no such path exists.



Example 1:


Input: maze = [["+","+",".","+"],[".",".",".","+"],["+","+","+","."]], entrance = [1,2]
Output: 1
Explanation: There are 3 exits in this maze at [1,0], [0,2], and [2,3].
Initially, you are at the entrance cell [1,2].
- You can reach [1,0] by moving 2 steps left.
- You can reach [0,2] by moving 1 step up.
It is impossible to reach [2,3] from the entrance.
Thus, the nearest exit is [0,2], which is 1 step away.
Example 2:


Input: maze = [["+","+","+"],[".",".","."],["+","+","+"]], entrance = [1,0]
Output: 2
Explanation: There is 1 exit in this maze at [1,2].
[1,0] does not count as an exit since it is the entrance cell.
Initially, you are at the entrance cell [1,0].
- You can reach [1,2] by moving 2 steps right.
Thus, the nearest exit is [1,2], which is 2 steps away.
Example 3:


Input: maze = [[".","+"]], entrance = [0,0]
Output: -1
Explanation: There are no exits in this maze.


Constraints:

maze.length == m
maze[i].length == n
1 <= m, n <= 100
maze[i][j] is either '.' or '+'.
entrance.length == 2
0 <= entranceRow < m
0 <= entranceCol < n
entrance will always be an empty cell.


*/

import 'dart:collection';
import 'dart:math';

class A {
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

class B {
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

class C {
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
