# BFS/DFS 100% Fast || 2 Solutions || Simple Fast and Easy || with Explanation

## Solution - 1 - Breadth First Search

```dart
class Solution {
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
```

## Solution - 2 Depth First Search

```dart
class Solution {
  List<List<List<int>>> dp = List<List<List<int>>>.generate(
    42,
    (_) => List<List<int>>.generate(
      42,
      (_) => List<int>.filled(1609, 0, growable: false),
    ),
  );

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
```
