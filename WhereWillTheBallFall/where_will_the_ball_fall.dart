/*


-* Where Will the Ball Fall *-

You have a 2-D grid of size m x n representing a box, and you have n balls. The box is open on the top and bottom sides.

Each cell in the box has a diagonal board spanning two corners of the cell that can redirect a ball to the right or to the left.

A board that redirects the ball to the right spans the top-left corner to the bottom-right corner and is represented in the grid as 1.
A board that redirects the ball to the left spans the top-right corner to the bottom-left corner and is represented in the grid as -1.
We drop one ball at the top of each column of the box. Each ball can get stuck in the box or fall out of the bottom. A ball gets stuck if it hits a "V" shaped pattern between two boards or if a board redirects the ball into either wall of the box.

Return an array answer of size n where answer[i] is the column that the ball falls out of at the bottom after dropping the ball from the ith column at the top, or -1 if the ball gets stuck in the box.



Example 1:



Input: grid = [[1,1,1,-1,-1],[1,1,1,-1,-1],[-1,-1,-1,1,1],[1,1,1,1,-1],[-1,-1,-1,-1,-1]]
Output: [1,-1,-1,-1,-1]
Explanation: This example is shown in the photo.
Ball b0 is dropped at column 0 and falls out of the box at column 1.
Ball b1 is dropped at column 1 and will get stuck in the box between column 2 and 3 and row 1.
Ball b2 is dropped at column 2 and will get stuck on the box between column 2 and 3 and row 0.
Ball b3 is dropped at column 3 and will get stuck on the box between column 2 and 3 and row 0.
Ball b4 is dropped at column 4 and will get stuck on the box between column 2 and 3 and row 1.
Example 2:

Input: grid = [[-1]]
Output: [-1]
Explanation: The ball gets stuck against the left wall.
Example 3:

Input: grid = [[1,1,1,1,1,1],[-1,-1,-1,-1,-1,-1],[1,1,1,1,1,1],[-1,-1,-1,-1,-1,-1]]
Output: [0,1,2,3,4,-1]


Constraints:

m == grid.length
n == grid[i].length
1 <= m, n <= 100
grid[i][j] is 1 or -1.


*/

class A {
  List<int> findBall(List<List<int>> grid) {
    int rows = grid.length;
    int cols = grid[0].length;
    List<int> ans = List.filled(cols, 0);

    for (int c = 0; c < cols; c++) {
      int cPos = c;
      int nPos = -1;
      for (int r = 0; r < rows; r++) {
        nPos = cPos + grid[r][cPos];

        if (nPos < 0 || nPos >= cols || grid[r][cPos] != grid[r][nPos]) {
          cPos = -1;
          break;
        }
        cPos = nPos;
      }
      ans[c] = cPos;
    }
    return ans;
  }
}

class B {
  bool isBlocked(List<List<int>> grid, int cy, int cx) {
    int n = grid[0].length;
    return (grid[cy][cx] == 1 && cx == n - 1) // will hit right wall
        ||
        (grid[cy][cx] == -1 && cx == 0) // will hit left wall
        ||
        (grid[cy][cx] == 1 && grid[cy][cx + 1] == -1) // V shape with next
        ||
        (grid[cy][cx] == -1 && grid[cy][cx - 1] == 1); // V shape with previous
  }

  List<int> findBall(List<List<int>> grid) {
    int m = grid.length;
    int n = grid[0].length;

    List<int> result = List.filled(n, 0);
    for (int i = 0; i < n; ++i) {
      int cy = 0;
      int cx = i;
      while (cy < m && !isBlocked(grid, cy, cx)) {
        cx += grid[cy][cx];
        cy += 1;
      }

      result[i] = cy == m ? cx : -1;
    }

    return result;
  }
}

class C {
  int findDoor(List<List<int>> grid, int curCol, int curRow) {
    if (curRow >= grid.length) return curCol;

    if (curCol == 0 && grid[curRow][curCol] == -1) return -1;

    if (curCol == grid[0].length - 1 && grid[curRow][curCol] == 1) return -1;

    if (grid[curRow][curCol] == 1) {
      //look for it's right block
      if (grid[curRow][curCol + 1] == 1) {
        return findDoor(grid, curCol + 1, curRow + 1);
      } else {
        return -1;
      }
    } else {
      //look for it's left block
      if (grid[curRow][curCol - 1] == 1) {
        return -1;
      } else {
        return findDoor(grid, curCol - 1, curRow + 1);
      }
    }
  }

  List<int> findBall(List<List<int>> grid) {
    int n = grid[0].length;
    List<int> answer = List.filled(n, 0);

    for (int i = 0; i < n; i++) {
      answer[i] = findDoor(grid, i, 0);
    }

    return answer;
  }
}

class D {
  List<int> findBall(List<List<int>> grid) {
    int row = grid.length;
    int col = grid[0].length;
    List<int> ans = List.filled(col, -1);
    for (int j = 0; j < col; j++) {
      int ballPosition = j;
      int i = 0;
      while (i < row) {
        if (grid[i][ballPosition] == 1) {
          if (ballPosition + 1 == col) // WALL BLOCK CONDITION  Case IV
          {
            break;
          } else if (grid[i][ballPosition + 1] ==
              -1) // ADJACENT COLUMN CONDITION  Case I
          {
            break;
          }
          ballPosition++; // ball moves to right
        } else {
          if (ballPosition - 1 < 0) // WALL BLOCK CONDITION  Case III
          {
            break;
          } else if (grid[i][ballPosition - 1] ==
              1) // ADJACENT COLUMN CONDITION  Case II
          {
            break;
          }
          ballPosition--; // ball moves to left
        }
        i++;
      }
      if (i == row) {
        ans[j] = ballPosition;
      }
    }
    return ans;
  }
}
