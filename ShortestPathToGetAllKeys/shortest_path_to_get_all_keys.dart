/*

-* 864. Shortest Path to Get All Keys *-


You are given an m x n grid grid where:

'.' is an empty cell.
'#' is a wall.
'@' is the starting point.
Lowercase letters represent keys.
Uppercase letters represent locks.
You start at the starting point and one move consists of walking one space in one of the four cardinal directions. You cannot walk outside the grid, or walk into a wall.

If you walk over a key, you can pick it up and you cannot walk over a lock unless you have its corresponding key.

For some 1 <= k <= 6, there is exactly one lowercase and one uppercase letter of the first k letters of the English alphabet in the grid. This means that there is exactly one key for each lock, and one lock for each key; and also that the letters used to represent the keys and locks were chosen in the same order as the English alphabet.

Return the lowest number of moves to acquire all keys. If it is impossible, return -1.

 

Example 1:


Input: grid = ["@.a..","###.#","b.A.B"]
Output: 8
Explanation: Note that the goal is to obtain all the keys not to open all the locks.
Example 2:


Input: grid = ["@..aA","..B#.","....b"]
Output: 6
Example 3:


Input: grid = ["@Aa"]
Output: -1
 

Constraints:

m == grid.length
n == grid[i].length
1 <= m, n <= 30
grid[i][j] is either an English letter, '.', '#', or '@'.
The number of keys in the grid is in the range [1, 6].
Each key in the grid is unique.
Each key in the grid has a matching lock.


*/

import 'dart:collection';

class A {
  int shortestPathAllKeys(List<String> grid) {
    int m = grid.length;
    int n = grid[0].length;

    Map<int, int> keyBit = {};
    int bitStart = 0;

    for (int i = 0; i < m; i++) {
      for (int j = 0; j < n; j++) {
        if (isLowerCase(grid[i][j])) {
          keyBit[grid[i][j].codeUnitAt(0)] = bitStart;
          bitStart++;
        }
      }
    }

    int maskEnd = (1 << bitStart) - 1;
    int maskSize = 1 << bitStart;

    List<List<List<bool>>> memo = List.generate(
        m, (_) => List.generate(n, (_) => List.filled(maskSize, false)));

    List<int> start = [];

    for (int i = 0; i < m; i++) {
      for (int j = 0; j < n; j++) {
        if (grid[i][j] == '@') {
          start = [i, j, 0];
        }
      }
    }

    List<List<int>> queue = [start];
    int step = 0;

    while (queue.isNotEmpty) {
      int sz = queue.length;

      for (int k = 0; k < sz; k++) {
        List<int> current = queue[0];
        queue = queue.sublist(1);
        int row = current[0];
        int col = current[1];
        int mask = current[2];

        if (row < 0 || row >= m || col < 0 || col >= n) {
          continue;
        }

        if (grid[row][col] == '#') {
          continue;
        }

        if (isUpperCase(grid[row][col])) {
          String lowerKey = toLowerCase(grid[row][col]);
          if ((mask & (1 << keyBit[lowerKey.codeUnitAt(0)]!)) == 0) {
            continue;
          }
        }

        if (isLowerCase(grid[row][col])) {
          mask |= 1 << keyBit[grid[row][col].codeUnitAt(0)]!;
        }

        if (mask == maskEnd) {
          return step;
        }

        if (memo[row][col][mask]) {
          continue;
        }

        memo[row][col][mask] = true;

        queue.add([row + 1, col, mask]);
        queue.add([row - 1, col, mask]);
        queue.add([row, col + 1, mask]);
        queue.add([row, col - 1, mask]);
      }

      step++;
    }

    return -1;
  }

  bool isLowerCase(String ch) {
    return ch.codeUnitAt(0) >= 97 && ch.codeUnitAt(0) <= 122;
  }

  bool isUpperCase(String ch) {
    return ch.codeUnitAt(0) >= 65 && ch.codeUnitAt(0) <= 90;
  }

  String toLowerCase(String ch) {
    return String.fromCharCode(ch.codeUnitAt(0) + 32);
  }
}

//---
class State {
  final int x;
  final int y;
  final int steps;
  int keys;

  State(this.x, this.y, this.steps, this.keys);
}

class Solution {
  final List<dynamic> directions = [
    [0, -1],
    [0, 1],
    [1, 0],
    [-1, 0]
  ];

  int shortestPathAllKeys(List<String> grid) {
    final Queue<State> queue = Queue<State>();
    final int n = grid.length;
    final int m = grid[0].length;

    List<int> start = [0, 0];
    final keys = Set<String>();
    final locks = Set<String>();
    var allKeys = 0;

    for (int i = 0; i < n; i++) {
      for (int j = 0; j < m; j++) {
        switch (grid[i][j]) {
          case '@':
            start = [i, j];
            break;
          case 'a':
          case 'b':
          case 'c':
          case 'd':
          case 'e':
          case 'f':
            keys.add(grid[i][j]);
            allKeys += 1 << (grid[i][j].codeUnitAt(0) - 'a'.codeUnitAt(0));
            break;
          case 'A':
          case 'B':
          case 'C':
          case 'D':
          case 'E':
          case 'F':
            locks.add(grid[i][j]);
            break;
        }
      }
    }

    queue.add(State(start[0], start[1], 0, 0));

    return traverse(grid, queue, allKeys, keys, locks);
  }

  int traverse(List<String> grid, Queue<State> queue, int allKeys,
      Set<String> keys, Set<String> locks) {
    final int n = grid.length;
    final int m = grid[0].length;
    final List<List<List<int>>> visited = List.generate(n, (_) {
      return List.generate(m, (_) {
        return List.generate(allKeys + 1, (_) => -1);
      });
    });

    while (queue.isNotEmpty) {
      final State node = queue.removeFirst();
      visited[node.x][node.y][node.keys] = node.steps;

      for (final List<int> dir in directions) {
        final int newX = (node.x + dir[0]);
        final int newY = node.y + dir[1];
        if (newX >= 0 &&
            newX < n &&
            newY >= 0 &&
            newY < m &&
            grid[newX][newY] != '#') {
          final step = State(newX, newY, node.steps + 1, node.keys);

          final s = grid[newX][newY];
          if (keys.contains(s)) {
            final decoded = 1 << (s.codeUnitAt(0) - 'a'.codeUnitAt(0));
            step.keys |= decoded;
          } else if (locks.contains(s)) {
            final decoded = 1 << (s.codeUnitAt(0) - 'A'.codeUnitAt(0));
            if ((step.keys & decoded) == 0) continue;
          }

          if (step.keys == allKeys) return step.steps;

          if (visited[newX][newY][step.keys] == -1) {
            visited[newX][newY][step.keys] = step.steps;
            queue.add(step);
          }
        }
      }
    }
    return -1;
  }
}
