# 🔥 Where Will the Ball Fall 🔥 || 4 Approaches || Simple Fast and Easy || with Explanation

## Intuition

The problem becomes easy once I am able to understand it properly. The problem can be broken down into few cases when ball will get stuck and for other scenarios we need to consider the current position of the ball and next position of the ball. In this way, we can reach to the destination of each ball.

## Approach

The approach to solve this problem is :

We have to run a loop to consider each ball. The number of ball is equal to the number of columns.
For each ball, we will have a current position of the ball which will initially be equal to the column the ball is being dropped i.e. cPos = c;
Also, for each ball, we will also have a variable to store the next position i.e. nPos = -1;

Then we need to run a loop for each row since each ball will go through every row if it needs to come out of the box.

Now if the cell value is equal to 1 it means we need to go to the right from our current position (right column) and if the cell value is equal to -1 it means we need to go to the left from our current position (left column).
So, what we do is we determine the next position for each row the ball will go to, which will be equal to nPos = cPos + grid[r]`[cPos]`
The next position will be determined from current position and the value of that cell.
Now, we need to validate nPos. So certain scenarios where our ball will stuck is
nPos should be under column limits that is it should be greater than zero and less than number of columns.
Also, we will observe a "V" when the cPos and nPos value in grid for a row will have different values and that is the case where our ball will get stuck
So, for above two cases, we have our cPos=-1 and we will come out of the loop of rows.

The nPos will become our cPos and cPos value we will store in ans once our ball has gone through all rows.

## Complexity

### Time complexity

Since we are traversing through each column and each row time complexity will be
O(rows*cols);

### Space complexity

We have used array of ans whose size equals number of cols. Hence
Theta(cols).

## Solution - 1

```dart
class Solution {
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
```

## Solution - 2 Most Optimized

```dart
class Solution {
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
```

## Solution - 3

```dart
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
```

## Solution - 4

```dart
class Solution {
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
```
