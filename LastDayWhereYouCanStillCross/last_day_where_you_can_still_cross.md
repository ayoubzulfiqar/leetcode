# 🔥 3 Solutions 🔥 || Simple Fast and Easy || with Explanation 😈

## Solution - 1 Breath First Search + Binary Search

## Explanation of the Code

The provided code solves the problem of finding the latest possible day to cross a grid. It consists of two functions:

### `isPossible` Function

1. Initialize a 2D grid representation of the matrix with dimensions `(m + 1)` rows and `(n + 1)` columns.
2. Define the four possible directions to explore neighboring cells: up, down, left, and right.
3. Mark the cells specified in the `cells` input as blocked in the grid.
4. Create a queue to perform a breadth-first search (BFS) traversal of the grid.
5. Start the BFS from the top row by adding all unblocked cells in the first row to the queue and marking them as visited.
6. While the queue is not empty:
   1. Dequeue a cell from the front of the queue.
   2. Get the coordinates of the current cell (`r` and `c`).
   3. Iterate through the four directions:
      1. Calculate the coordinates of the neighbor cell (`nr` and `nc`).
      2. If the neighbor cell is within the grid boundaries, unvisited, and not blocked:
         1. Mark the neighbor cell as visited.
         2. If the neighbor cell is in the bottom row, return `true` as a path to the bottom row is found.
         3. Enqueue the neighbor cell for further exploration.
7. If the BFS completes without finding a path to the bottom row, return `false`.

### `latestDayToCross` Function

1. Initialize the search range by setting `left` as the minimum day (0) and `right` as the maximum day (`row * col`).
2. While `left` is less than (`right - 1`):
   1. Calculate the mid-day (`mid`) as the average of `left` and `right`.
   2. Check if it is possible to cross the grid within `mid` days using the `isPossible` function:
      - If possible:
         - Update `left` to `mid` to search in the upper half.
         - Update `latestPossibleDay` with the current `mid` value.
      - If not possible:
         - Update `right` to `mid` to search in the lower half.
3. Return `latestPossibleDay` as the latest possible day to cross the grid.

## Space and Time Complexity

The space complexity of this code is O(m * n), where `m` represents the number of rows and `n` represents the number of columns in the grid. This is due to the grid representation created with dimensions `(m + 1) x (n + 1)`.

The time complexity of the `isPossible` function is O(m * n) in the worst case since it needs to visit all the cells in the grid.

The `latestDayToCross` function performs binary search, which requires O(log(r *c)) iterations, where `r` is the number of rows and `c` is the number of columns in the grid. For each iteration, it calls the `isPossible` function, which has a time complexity of O(m* n). Therefore, the overall time complexity of the `latestDayToCross` function is O(log(r *c)* m * n).

```dart
import 'dart:collection';

class Solution {
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
```

## Solution - 2 Depth First Search + Binary Search

Because Recursive Approach sucks so deeply in DART so this one is Iterative

```dart
class Solution {
late  int n, m;
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
        if (nr >= 0 && nc >= 0 && nr < n && nc < m && vis[nr][nc] == 0 && v[nr][nc] == 0) {
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
```

## Solution - 3 Union Find

### Intuition

To find the last day that it is possible to walk from the top to the bottom by only walking on land cells, we need to track the connectivity of land cells as the flooded cells change over time. We can use a disjoint-set data structure to efficiently merge and find connected components in the grid.

### Approach

1. Initialize a disjoint-set data structure ds with a size of totalCells + 2, where totalCells represents the total number of cells in the grid (row * col), and the additional two cells represent virtual cells for the top and bottom rows.

2. Create a 2D grid of size row x col and populate it based on the input cells, marking flooded cells with a value of 1 and land cells with 0.

3. Iterate over the grid and establish initial connections between adjacent land cells using the merge method of the DisjointSet object ds.

4. Iterate over the flooded cells in reverse order and:

5. Set the corresponding grid cell back to land with value 0, now this cell is unfolded as we iterating cells in reverse order.

6. Update the connections with neighboring land cells using the merge method of ds.

7. If the cell is in the top row, merge it with the virtual cell rowStart.

8. If the cell is in the bottom row, merge it with the virtual cell rowEnd.

9. Check if the virtual cells rowStart and rowEnd are connected using the connected method of ds.

10. If they are connected, return the current day c, since there is a path from the top to the bottom row.

11. If no path is found, return first day 0.

### Complexity

- Time complexity: O(row∗col)O(row * col)O(row∗col)
- Space complexity: O(row∗col)O(row * col)O(row∗col)

```dart
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

```
