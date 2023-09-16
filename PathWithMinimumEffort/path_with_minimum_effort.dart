/*

-* 1631. Path With Minimum Effort *-

You are a hiker preparing for an upcoming hike. You are given heights, a 2D array of size rows x columns, where heights[row][col] represents the height of cell (row, col). You are situated in the top-left cell, (0, 0), and you hope to travel to the bottom-right cell, (rows-1, columns-1) (i.e., 0-indexed). You can move up, down, left, or right, and you wish to find a route that requires the minimum effort.

A route's effort is the maximum absolute difference in heights between two consecutive cells of the route.

Return the minimum effort required to travel from the top-left cell to the bottom-right cell.

 

Example 1:



Input: heights = [[1,2,2],[3,8,2],[5,3,5]]
Output: 2
Explanation: The route of [1,3,5,3,5] has a maximum absolute difference of 2 in consecutive cells.
This is better than the route of [1,2,2,2,5], where the maximum absolute difference is 3.
Example 2:



Input: heights = [[1,2,3],[3,8,4],[5,3,5]]
Output: 1
Explanation: The route of [1,2,3,4,5] has a maximum absolute difference of 1 in consecutive cells, which is better than route [1,3,5,3,5].
Example 3:


Input: heights = [[1,2,1,1,1],[1,2,1,2,1],[1,2,1,2,1],[1,2,1,2,1],[1,1,1,2,1]]
Output: 0
Explanation: This route does not require any effort.
 

Constraints:

rows == heights.length
columns == heights[i].length
1 <= rows, columns <= 100
1 <= heights[i][j] <= 106


*/

import 'dart:math';

class Di {
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
