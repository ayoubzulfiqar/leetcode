# 🔥 Valid Sudoku 🔥 || 3 Approaches || Simple Fast and Easy || with Explanation

## Solution - 1 HashSet

```dart
import 'dart:collection';

class Solution {
  bool isValidSudoku(List<List<String>> board) {
    HashSet<String> hashSet = HashSet();
    for (int row = 0; row < 9; row++) {
      for (int column = 0; column < 9; column++) {
        String number = board[row][column];
        if (number != '.') {
          if (!hashSet.add(number + " in row " + String.fromCharCode(row)) ||
              !hashSet
                  .add(number + " in column " + String.fromCharCode(column)) ||
              !hashSet.add(
                number +
                    " in block " +
                    String.fromCharCode(row ~/ 3) +
                    "," +
                    String.fromCharCode(column ~/ 3),
              )) return false;
        }
      }
    }
    return true;
  }
}
```

## Solution - 2

```dart
class Solution {
  bool isValidSudoku(List<List<String>> board) {
    for (int row = 0; row < 9; row++) {
      for (int column = 0; column < 9; column++) {
        if (board[row][column] != '.' &&
            !isValidPlacement(board, board[row][column], row, column))
          return false;
      }
    }
    return true;
  }

  bool isNumberInRow(
      List<List<String>> board, String number, int row, int column) {
    for (int i = 0; i < 9; i++) {
      if (column != i && board[row][i] == number) return true;
    }
    return false;
  }

  bool isNumberInColumn(
      List<List<String>> board, String number, int row, int column) {
    for (int i = 0; i < 9; i++) {
      if (row != i && board[i][column] == number) return true;
    }
    return false;
  }

  bool isNumberInBox(
      List<List<String>> board, String number, int row, int column) {
    int boxRow = row - row % 3;
    int boxColumn = column - column % 3;
    for (int i = boxRow; i < boxRow + 3; i++) {
      for (int j = boxColumn; j < boxColumn + 3; j++) {
        if (row != i && column != j && board[i][j] == number) return true;
      }
    }
    return false;
  }

  bool isValidPlacement(
      List<List<String>> board, String number, int row, int column) {
    return !isNumberInRow(board, number, row, column) &&
        !isNumberInColumn(board, number, row, column) &&
        !isNumberInBox(board, number, row, column);
  }
}
```

## Solution - 3 Bit-Manipulation

```dart
class Solution {
  int getBit(int x, int k) {
    return (x >> k) & 1;
  }

  bool isValidSudoku(List<List<String>> board) {
    int n = 9;
    List<int> rows = List.filled(n, 0);
    List<int> cols = List.filled(n, 0);
    List<int> squares = List.filled(n, 0);
    for (int r = 0; r < n; r++) {
      for (int c = 0; c < n; c++) {
        if (board[r][c] == '.') continue;
        int val = board[r][c].codeUnitAt(0) - '0'.codeUnitAt(0);
        int sPos = (r ~/ 3) * 3 + (c ~/ 3);
        if (getBit(rows[r], val) == 1 ||
            getBit(cols[c], val) == 1 ||
            getBit(squares[sPos], val) == 1) return false;
        rows[r] |= 1 << val;
        cols[c] |= 1 << val;
        squares[sPos] |= 1 << val;
      }
    }
    return true;
  }
}
```
