# 🔥 Dijkstra's Algorithm & DFS Binary Search🔥 || Simple Fast and Easy || with Explanation 😈

## Code - Dijkstra's Algorithm

### Intuition

The goal of this code is to find the minimum effort required to traverse from the top-left corner to the bottom-right corner of a grid. Effort is defined as the maximum absolute difference in heights between adjacent cells. The code utilizes Dijkstra's algorithm to explore possible paths and find the minimum effort.

### Approach

1. Initialize a 2D array `effort` to store the minimum effort required to reach each cell. Initialize `dx` and `dy` arrays to represent changes in x and y coordinates for four directions (up, down, left, right).

2. Implement the `dijkstra` function, which performs Dijkstra's algorithm:
   - Initialize the number of rows and columns in the grid.
   - Create a 2D array `pq` to simulate a priority queue. Initialize `effort` values for each cell to a large value (1000 represents infinity).
   - Set the starting cell's effort to 0 and add it to the priority queue.

3. While the priority queue is not empty, do the following:
   - Find the cell with the minimum `effort` value in the priority queue.
   - If the current cell is the bottom-right cell, return its `effort` value as the result.
   - Explore each of the four directions from the current cell:
     - Calculate the new `x` and `y` coordinates.
     - Check if the new coordinates are within bounds.
     - Calculate the new effort as the maximum of the current cell's effort and the absolute difference in heights between the current cell and the neighboring cell.
     - Update the `effort` for the neighboring cell if the new effort is smaller.
     - Mark the current cell as visited by setting its `effort` to a large value.

4. Implement the `minimumEffortPath` function, which initializes `effort` values, runs `dijkstra` to find the minimum effort, and returns the result.

### Space Complexity

- The space complexity is primarily determined by the 2D arrays `effort` and `pq`, both of size `rows` x `cols`.
- Therefore, the space complexity is O(`rows` * `cols`).

### Time Complexity

- The code uses Dijkstra's algorithm to explore cells in the grid.
- In the worst case, each cell is visited at most once.
- The time complexity of Dijkstra's algorithm is O(`rows` * `cols`) since all cells are visited.
- Overall, the time complexity of the code is dominated by the Dijkstra's algorithm and is O(`rows` * `cols`).

```dart
import 'dart:math';
class Solution {
  List<List<int>> effort = List.generate(105, (_) => List<int>.filled(105, 0));
  List<int> dx = [0, 1, -1, 0];
  List<int> dy = [1, 0, 0, -1];

  int dijkstra(List<List<int>> heights) {
    int rows = heights.length;
    int cols = heights[0].length;

    List<List<int>> pq = List.generate(rows, (_) => List<int>.filled(cols, 0));
    for (int i = 0; i < rows; i++) {
      for (int j = 0; j < cols; j++) {
        pq[i][j] = i * cols + j;
        effort[i][j] = 1000;
      }
    }

    effort[0][0] = 0;
    pq[0][0] = 0;

    while (true) {
      int minEffort = 1000;
      int minEffortX = -1;
      int minEffortY = -1;

      for (int i = 0; i < rows; i++) {
        for (int j = 0; j < cols; j++) {
          if (effort[i][j] < minEffort) {
            minEffort = effort[i][j];
            minEffortX = i;
            minEffortY = j;
          }
        }
      }

      if (minEffortX == rows - 1 && minEffortY == cols - 1) {
        return minEffort;
      }

      for (int i = 0; i < 4; i++) {
        int newX = minEffortX + dx[i];
        int newY = minEffortY + dy[i];

        if (newX >= 0 && newX < rows && newY >= 0 && newY < cols) {
          int newEffort = max(effort[minEffortX][minEffortY],
              (heights[minEffortX][minEffortY] - heights[newX][newY]).abs());

          if (newEffort < effort[newX][newY]) {
            effort[newX][newY] = newEffort;
          }
        }
      }

      // Mark this cell as visited by setting its effort to a very large value
      effort[minEffortX][minEffortY] = 1000;
    }
  }

  int minimumEffortPath(List<List<int>> heights) {
    return dijkstra(heights);
  }
}
```

## Code - DFS Binary Search

## Intuition

This code seeks to find the minimum effort required to traverse a grid from the top-left corner to the bottom-right corner, considering effort as the maximum absolute difference in heights between adjacent cells. It employs binary search combined with depth-first search (DFS) to determine the minimum effort.

## Approach

1. Initialize a 2D `visited` array to track visited cells and define `directionsX` and `directionsY` arrays for directional changes.
2. Implement the `dfs` function for DFS:
   - If the current cell is visited, return.
   - Mark the current cell as visited.
   - If the current cell is the bottom-right cell, return.
   - Explore neighboring cells, calculating new effort and recursively calling `dfs` if effort is within limit.
3. Implement `minimumEffortPath`:
   - Initialize grid dimensions, visited array, and binary search limits.
   - Perform binary search:
     - Calculate the mid-point effort.
     - Reset visited array and run `dfs` with the mid-point effort.
     - Adjust search range based on whether the bottom-right cell was reached.
   - Return the lower limit as the minimum effort.

## Space Complexity

- Space complexity: O(rows * cols) due to the 2D `visited` array.

## Time Complexity

- Time complexity: O(log(limit) *rows* cols), where `limit` is the upper bound on effort. DFS explores the grid once per binary search iteration.

```dart
class Solution {
  late List<List<bool>> visited;
  final directionsX = [0, 1, -1, 0];
  final directionsY = [1, 0, 0, -1];
  late int numRows, numCols;

  void dfs(int x, int y, int limitEffort, List<List<int>> heights) {
    if (visited[x][y]) return;
    visited[x][y] = true;

    if (x == numRows - 1 && y == numCols - 1) return;

    for (int i = 0; i < 4; i++) {
      int newX = x + directionsX[i];
      int newY = y + directionsY[i];

      if (newX < 0 || newX >= numRows || newY < 0 || newY >= numCols) continue;

      int newEffort = (heights[x][y] - heights[newX][newY]).abs();
      if (newEffort <= limitEffort) {
        dfs(newX, newY, limitEffort, heights);
      }
    }
  }

  int minimumEffortPath(List<List<int>> heights) {
    numRows = heights.length;
    numCols = heights[0].length;

    visited = List.generate(numRows, (i) => List<bool>.filled(numCols, false));

    int lowerLimit = 0;
    int upperLimit = 1000000;

    while (lowerLimit < upperLimit) {
      int mid = (upperLimit + lowerLimit) ~/ 2;
      for (var row in visited) {
        row.fillRange(0, numCols, false);
      }

      dfs(0, 0, mid, heights);

      if (visited[numRows - 1][numCols - 1]) {
        upperLimit = mid;
      } else {
        lowerLimit = mid + 1;
      }
    }

    return lowerLimit;
  }
}
```

### Disclaimer:-

This Solution is not available in DART Programming language with is a bummer.
Hurts my feeling. But as a man we should implement it no matter what.
We are not bunch of wussies who gonna skip it if it's not available in one language we love.
Instead we will conquer the sea and rivers and cross the mountains to see what's lies beyond our horizons.

## [GitHub](https://github.com/ayoubzulfiqar/leetcode)
