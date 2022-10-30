/*



-* Shortest Path in a Grid with Obstacles Elimination *-




You are given an m x n integer matrix grid where each cell is either 0 (empty) or 1 (obstacle). You can move up, down, left, or right from and to an empty cell in one step.

Return the minimum number of steps to walk from the upper left corner (0, 0) to the lower right corner (m - 1, n - 1) given that you can eliminate at most k obstacles. If it is not possible to find such walk return -1.



Example 1:


Input: grid = [[0,0,0],[1,1,0],[0,0,0],[0,1,1],[0,0,0]], k = 1
Output: 6
Explanation:
The shortest path without eliminating any obstacle is 10.
The shortest path with one obstacle elimination at position (3,2) is 6. Such path is (0,0) -> (0,1) -> (0,2) -> (1,2) -> (2,2) -> (3,2) -> (4,2).
Example 2:


Input: grid = [[0,1,1],[1,1,1],[1,0,0]], k = 1
Output: -1
Explanation: We need to eliminate at least two obstacles to find such a walk.


Constraints:

m == grid.length
n == grid[i].length
1 <= m, n <= 40
1 <= k <= m * n
grid[i][j] is either 0 or 1.
grid[0][0] == grid[m - 1][n - 1] == 0


*/

import 'dart:collection';
import 'dart:math';

class A {
// Runtime: 594 ms, faster than 100.00% of Dart online submissions for Shortest Path in a Grid with Obstacles Elimination.
// Memory Usage: 152.1 MB, less than 100.00% of Dart online submissions for Shortest Path in a Grid with Obstacles Elimination.
  int shortestPath(List<List<int>> grid, int k) {
    int m = grid.length;
    int n = grid[0].length;
    // This vector stores the number of obstacles that we can still remove after walking through that cell
    // List<List<int>> visited = (m, List<int>(n, -1));
    List<List<int>> visited =
        List.filled(m, 0).map((e) => List.filled(n, -1)).toList();
    // List<List<int>> visited = List.filled(m, List.filled(n, -1));
    Queue<List<int>> q = Queue();
    // x, y, currentLength, remaining k
    q.add([0, 0, 0, k]);
    while (q.isNotEmpty) {
      List<int> t = q.first;
      q.removeFirst();

      int x = t[0], y = t[1];

      // Invalid cases being dealt here since it's easier to write one condition instead of 4 while pushing.
      if (x < 0 || x >= m || y < 0 || y >= n) continue;

      // If you've reached the end, great, return the currentLength!
      if (x == m - 1 && y == n - 1) return t[2]; //currentLength of the path

      // If we hit an obstacle & we don't have any Ks remaining, continue
      // If we still have Ks to spend, we spend 1.
      if (grid[x][y] == 1) {
        if (t[3] > 0)
          t[3]--;
        else
          continue;
      }

      // If this cell is already visited with a K value lesser than this one, we would want to save Ks for future use, so we continue
      // This is the most important condition and part of the solution!
      if (visited[x][y] != -1 && visited[x][y] >= t[3]) {
        continue;
      }

      // We store the currentRemaining K after spending K (if required) into the visited matrix.
      visited[x][y] = t[3];

      // Push the adjacent nodes in the queue.
      q.add([x + 1, y, t[2] + 1, t[3]]);
      q.add([x - 1, y, t[2] + 1, t[3]]);
      q.add([x, y + 1, t[2] + 1, t[3]]);
      q.add([x, y - 1, t[2] + 1, t[3]]);
    }

    return -1;
  }
}

class B {
  late int m;
  late int n;
  late List<List<int>> grid;
  List<List<int>> direction = [
    [1, 0],
    [0, 1],
    [-1, 0],
    [0, -1]
  ];
  late List<List<List<int>>> mem;

  late List<List<bool>> visited;
  int dfs(int x, int y, int k) {
    if (mem[x][y][k] != 0) {
      return mem[x][y][k];
    }
    if (x == m - 1 && y == n - 1) {
      return 0;
    }
    visited[x][y] = true;
    int step = double.maxFinite ~/ 2;
    for (List<int> d in direction) {
      int newX = x + d[0];
      int newY = y + d[1];
      if (newX < 0 ||
          newX > m - 1 ||
          newY < 0 ||
          newY > n - 1 ||
          visited[newX][newY]) {
        continue;
      }
      if (grid[newX][newY] == 1 && k == 0) {
        continue;
      }
      if (grid[newX][newY] == 1) {
        step = min(step, dfs(newX, newY, k - 1));
      } else if (grid[newX][newY] == 0) {
        step = min(step, dfs(newX, newY, k));
      }
    }
    visited[x][y] = false;
    mem[x][y][k] =
        step == double.maxFinite ~/ 2 ? double.maxFinite ~/ 2 : step + 1;

    return mem[x][y][k];
  }

  int shortestPath(List<List<int>> grid, int k) {
    m = grid.length;
    n = grid[0].length;
    this.grid = grid;
    // mem = [m][n][k + 1];
    mem = List<List<List<int>>>.generate(
      m,
      (_) => List<List<int>>.generate(
        n,
        (_) => List<int>.filled(k + 1, 0, growable: false),
      ),
    );

    // visited = [m][n];
    visited = List.filled(m, 0).map((e) => List.filled(n, false)).toList();
    if (grid[0][0] == 1) {
      if (k == 0) {
        return -1;
      }
      k -= 1;
    }
    int ans = dfs(0, 0, k);
    return ans == double.maxFinite ~/ 2 ? -1 : ans;
  }
}

class C {
  List<List<List<int>>> dp = List<List<List<int>>>.generate(
    42,
    (_) => List<List<int>>.generate(
      42,
      (_) => List<int>.filled(1609, 0, growable: false),
    ),
  );
  // List<List<List<int>>> dp = [42][42][1609];

  int MAX = 1e7.toInt();
  int help(List<List<int>> grid, int x, int y, int z, int k) {
    //Reached destination
    if (x == 0 && y == 0) return 0;

    //Already visited/calculated
    if (dp[x][y][z] != 0) return dp[x][y][z];

    //Cant remove any more obstacles
    if (grid[x][y] == 1 && z == 0) return MAX;

    //Manhattan optimization
    if (z >= x + y) return dp[x][y][z] = x + y;

    //Make sure to take direction left and up before right and top
    List<List<int>> dirs = [
      [-1, 0],
      [0, -1],
      [1, 0],
      [0, 1]
    ];

    //Setting dp[x][y][z] to MAX so that it does not gets calculated again
    dp[x][y][z] = MAX;

    for (List<int> dir in dirs) {
      //DFS valid condition
      if (x + dir[0] >= 0 &&
          x + dir[0] < grid.length &&
          y + dir[1] >= 0 &&
          y + dir[1] < grid[0].length) {
        dp[x][y][z] = min(dp[x][y][z],
            help(grid, x + dir[0], y + dir[1], z - grid[x][y], k) + 1);
      }
    }
    //If not possible
    if (z == k &&
        x == grid.length - 1 &&
        y == grid[0].length - 1 &&
        dp[x][y][z] == MAX) return -1;
    return dp[x][y][z];
  }

  int shortestPath(List<List<int>> grid, int k) {
    return help(grid, grid.length - 1, grid[0].length - 1, k, k);
  }
}

// class D {
//   List<List<int>> DIRECTIONS = [
//     [1, 0],
//     [-1, 0],
//     [0, -1],
//     [0, 1]
//   ];
//   int shortestPath(List<List<int>> grid, int k) {
//       int m = grid.length, n = grid[0].length;

//         // int[][][] dists = new int[m][n][k+1];
//         List<List<List<int>>> dists =List<List<List<int>>>.generate(
//     m,
//     (_) => List<List<int>>.generate(
//       n,
//       (_) => List<int>.filled(k + 1, 0, growable: false),
//     ),
//   );
//         for (List<List<int>> dist in dists)
//             for (List<int> d in dist)
//                 // Arrays.fill(d, Integer.MAX_VALUE);
//                 List.filled(d, double.maxFinite.toInt());

//         Arrays.fill(dists[0][0], 0);

//         // min-heap storing {i, j, # obstacles eliminated, dist}, sorted by distance to (0,0)
//         Queue<List<int>> heap = Queue((a,b) => a[3] - b[3]);
//         heap.offer(new int[]{0, 0, 0, 0});

//         while (heap.isNotEmpty) {
//             List<int> curr = heap.poll();
//             if (curr[0] == m-1 && curr[1] == n-1) continue;

//             for (List<int> dir in DIRECTIONS) {
//                 int newX = curr[0] + dir[0];
//                 int newY = curr[1] + dir[1];

//                 // 1). continue if out of bound
//                 if (newX < 0 || newY < 0 || newX >= m || newY >= n) continue;

//                 // 2). continue if out of elimation
//                 int newK = curr[2] + grid[newX][newY];
//                 if (newK > k) continue;

//                 // 3). continue if we have more optimal result
//                 int newDist = curr[3] + 1;
//                 if (dists[newX][newY][newK] <= newDist) continue;

//                 dists[newX][newY][newK] = newDist;
//                 heap.offer([newX, newY, newK, newDist]);
//             }
//         }

//         int res = dists[m-1][n-1][0];
//         for (int i = 1; i <= k; i++) res = Math.min(res, dists[m-1][n-1][i]);
//         return (res == Integer.MAX_VALUE) ? -1 : res;
//   }
// }
