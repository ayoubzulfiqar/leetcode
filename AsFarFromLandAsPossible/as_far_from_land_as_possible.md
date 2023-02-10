# 🔥 2 Approaches 🔥 || Simple Fast and Easy || with Explanation

## Approach

Here's the algorithm:

1. - It is a two-pass dynamic programming approach. The idea behind this approach is to find the minimum distance from each ocean cell to the nearest land cell and then find the maximum distance in the grid.

2. - In the first pass, the algorithm iterates through the grid from left to right and top to bottom. For each ocean cell `(grid[i][j] = 0)`, it calculates the minimum distance from the nearest land cell by taking the minimum value between the distance from the top cell and the distance from the left cell. This minimum value is then added by 1, as the distance to the current cell is also counted. The calculated distance is then stored in the grid.

3. - In the second pass, the algorithm iterates through the grid from right to left and bottom to top. For each ocean cell, it calculates the minimum distance from the nearest land cell by taking the minimum value between the distance from the current cell, the distance from the bottom cell, and the distance from the right cell. This minimum value is then stored in the grid.

4. - The final step is to find the maximum distance in the grid by iterating through the grid from left to right and top to bottom. If the maximum distance is equal to n + m + 1 (the maximum possible distance in the grid) or 0 (no land cells are found), the algorithm returns -1, as there is no ocean cell that is distant from all land cells. If not, the algorithm returns the maximum distance minus 1, as the distance from each cell to itself is not counted.

## Complexity

- ### Time complexity: O(m * n)

where m is the number of rows and n is the number of columns in the input grid. This is because the algorithm performs two nested loops over all the elements of the grid, visiting each element exactly once.

- ###  Space complexity: O(1)

In this algorithm we use only a few integer variables for tracking the maximum distance, and updates the values in the original input grid in place, without using any additional data structures.

## Code -1

```dart
class Solution {
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
    int count = 0;
    for (int i = 0; i < m; i++) {
      for (int j = 0; j < n; j++) {
        count = max(count, grid[i][j]);
      }
    }
    return count - 1 == n + m + 1 || count - 1 == 0 ? -1 : count - 1;
  }
}
```

## Code -2 USING QUEUE

```dart
class Solution {
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
```
