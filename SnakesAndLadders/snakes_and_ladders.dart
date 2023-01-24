/*



-* 909. Snakes and Ladders *-



You are given an n x n integer matrix board where the cells are labeled from 1 to n2 in a Boustrophedon style starting from the bottom left of the board (i.e. board[n - 1][0]) and alternating direction each row.

You start on square 1 of the board. In each move, starting from square curr, do the following:

Choose a destination square next with a label in the range [curr + 1, min(curr + 6, n2)].
This choice simulates the result of a standard 6-sided die roll: i.e., there are always at most 6 destinations, regardless of the size of the board.
If next has a snake or ladder, you must move to the destination of that snake or ladder. Otherwise, you move to next.
The game ends when you reach the square n2.
A board square on row r and column c has a snake or ladder if board[r][c] != -1. The destination of that snake or ladder is board[r][c]. Squares 1 and n2 do not have a snake or ladder.

Note that you only take a snake or ladder at most once per move. If the destination to a snake or ladder is the start of another snake or ladder, you do not follow the subsequent snake or ladder.

For example, suppose the board is [[-1,4],[-1,3]], and on the first move, your destination square is 2. You follow the ladder to square 3, but do not follow the subsequent ladder to 4.
Return the least number of moves required to reach the square n2. If it is not possible to reach the square, return -1.

 

Example 1:


Input: board = [[-1,-1,-1,-1,-1,-1],[-1,-1,-1,-1,-1,-1],[-1,-1,-1,-1,-1,-1],[-1,35,-1,-1,13,-1],[-1,-1,-1,-1,-1,-1],[-1,15,-1,-1,-1,-1]]
Output: 4
Explanation: 
In the beginning, you start at square 1 (at row 5, column 0).
You decide to move to square 2 and must take the ladder to square 15.
You then decide to move to square 17 and must take the snake to square 13.
You then decide to move to square 14 and must take the ladder to square 35.
You then decide to move to square 36, ending the game.
This is the lowest possible number of moves to reach the last square, so return 4.
Example 2:

Input: board = [[-1,-1],[-1,3]]
Output: 1
 

Constraints:

n == board.length == board[i].length
2 <= n <= 20
grid[i][j] is either -1 or in the range [1, n2].
The squares labeled 1 and n2 do not have any ladders or snakes.

*/
import 'dart:collection';

class A {
  int length = 1;
  int snakesAndLadders(List<List<int>> board) {
    length = board.length;
    HashMap<int, int> visited = new HashMap();
    visited[1] = 0;
    List<int> arr = [];
    arr.add(1);
    while (arr.isNotEmpty) {
      int n = arr[0];
      arr.remove(0);
      for (int i = n + 1; i <= n + 6; i++) {
        int next = i;
        List<int> nextPos = getPosition(i);
        if (next > length * length) return -1;
        if (board[nextPos[0]][nextPos[1]] != -1) {
          next = board[nextPos[0]][nextPos[1]];
        }
        if (next == length * length) return (visited[n] ?? 0) + 1;
        if (!visited.containsKey(next)) {
          visited[next] = (visited[n] ?? 0) + 1;
          arr.add(next);
        }
      }
    }
    return -1;
  }

  List<int> getPosition(int n) {
    int row = (n - 1) ~/ length;
    int column = (n - 1) % length;
    if (row % 2 != 0) {
      column = (column - length + 1) * -1;
    }
    row = (row - length + 1) * -1;

    List<int> result = [row, column];
    return result;
  }
}

class B {
  int snakesAndLadders(List<List<int>> board) {
    int n = board.length;
    int moves = 0;
    Queue<int> q = Queue();
    List<List<bool>> visited =
        List.filled(n, false).map((e) => List.filled(n, false)).toList();
    q.add(1);
    visited[n - 1][0] = true;
    while (q.isNotEmpty) {
      int size = q.length;
      for (int i = 0; i < size; i++) {
        // poll = removeLast()
        int currBoardVal = q.removeFirst();
        if (currBoardVal == n * n) return moves;
        for (int diceVal = 1; diceVal <= 6; diceVal++) {
          if (currBoardVal + diceVal > n * n) break;
          List<int> pos = findCoordinates(currBoardVal + diceVal, n);
          int row = pos[0];
          int col = pos[1];
          if (visited[row][col] == false) {
            visited[row][col] = true;
            if (board[row][col] == -1) {
              q.add(currBoardVal + diceVal);
            } else {
              q.add(board[row][col]);
            }
          }
        }
      }
      moves++;
    }
    return -1;
  }

  List<int> findCoordinates(int curr, int n) {
    int r = n - (curr - 1) ~/ n - 1;
    int c = (curr - 1) % n;
    if (r % 2 == n % 2) {
      return [r, n - 1 - c];
    } else {
      return [r, c];
    }
  }
}
