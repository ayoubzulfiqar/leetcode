/*

-* 79. Word Search *-

Given an m x n grid of characters board and a string word, return true if word exists in the grid.

The word can be constructed from letters of sequentially adjacent cells, where adjacent cells are horizontally or vertically neighboring. The same letter cell may not be used more than once.



Example 1:


Input: board = [["A","B","C","E"],["S","F","C","S"],["A","D","E","E"]], word = "ABCCED"
Output: true
Example 2:


Input: board = [["A","B","C","E"],["S","F","C","S"],["A","D","E","E"]], word = "SEE"
Output: true
Example 3:


Input: board = [["A","B","C","E"],["S","F","C","S"],["A","D","E","E"]], word = "ABCB"
Output: false


Constraints:

m == board.length
n = board[i].length
1 <= m, n <= 6
1 <= word.length <= 15
board and word consists of only lowercase and uppercase English letters.


Follow up: Could you use search pruning to make your solution faster with a larger board?


*/

class A {
  late List<List<bool>> visited;
  late int n;
  late int m;

  bool exist(List<List<String>> board, String word) {
    n = board.length;
    m = board[0].length;
    visited = List.filled(n, false).map((e) => List.filled(m, false)).toList();

    for (int i = 0; i < n; i++) {
      for (int j = 0; j < m; j++) {
        if (board[i][j] == word[0]) {
          if (valid(i, j, 0, board, word)) {
            return true;
          }
        }
      }
    }
    return false;
  }

  bool valid(int i, int j, int count, List<List<String>> board, String word) {
    /*-------------base conditions-------------*/
    //out of bound
    if (i < 0 || i >= n || j < 0 || j >= m) {
      return false;
    }

    //if already visited
    if (visited[i][j]) {
      return false;
    }

    //mismatch
    if (word[count] != board[i][j]) {
      return false;
    }

    //if word is found
    if (count == word.length - 1) {
      return true;
    }

    /*----------------calculation and recursive calls----------*/

    //mark current visited
    visited[i][j] = true;

    //inc count
    count++;

    //down,right,up,left search
    if (valid(i + 1, j, count, board, word) ||
        valid(i, j + 1, count, board, word) ||
        valid(i - 1, j, count, board, word) ||
        valid(i, j - 1, count, board, word)) {
      return true;
    }

    //mark current cell unvisited
    visited[i][j] = false;

    return false;
  }
}
