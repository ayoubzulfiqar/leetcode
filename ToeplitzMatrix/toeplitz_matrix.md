# 🔥 Toeplitz Matrix 🔥 || 5 Solutions || Simple Fast and Easy || with Explanation

## solution - 1 Brute Force

```dart
class Solution {
  bool isToeplitzMatrix(List<List<int>> matrix) {
    for (int i = 0; i < matrix.length - 1; i++) {
      for (int j = 0; j < matrix[0].length - 1; j++) {
        int ele = matrix[i][j];
        if (i < matrix.length - 1 &&
            j < matrix[0].length - 1 &&
            matrix[i + 1][j + 1] != ele) {
          return false;
        }
      }
    }
    return true;
  }
}
```

## Solution - 2 Row by Row

```dart
import 'dart:collection';

class Solution {
  bool isToeplitzMatrix(List<List<int>> matrix) {
    if (matrix.length <= 1 || matrix[0].length <= 1) return true;
    Queue<int> q = Queue();
    for (int i = matrix[0].length - 1; i >= 0; i--) {
      //set criteria
      q.add(matrix[0][i]);
    }
    for (int j = 1; j < matrix.length; j++) {
      q.removeFirst();
      for (int k = matrix[j].length - 1; k > 0; k--) {
        if (matrix[j][k] == q.removeFirst()) // compare
          q.add(matrix[j][k]);
        else
          return false;
      }
      q.add(matrix[j][0]);
    }
    return true;
  }
}
```

## Solution - 3 Column by Column

```dart
class Solution {
  bool isToeplitzMatrix(List<List<int>> matrix) {
    int totalRows = matrix.length;
    int totalColumns = matrix[0].length;

    // Initiate the linked list and add the first column to the linked list.
    List<int> linkedList = [];
    for (int i = 0; i < totalRows; i++) linkedList.add(matrix[i][0]);

    for (int column = 1; column < totalColumns; column++) {
      // Check the column to see if any is not identical to the linked list elements.
      for (int row = 1; row < totalRows; row++)
        if (matrix[row][column] != linkedList[row - 1]) return false;
      // Update the linked list for the next line.
      linkedList.remove(linkedList.length - 1);
      linkedList.insert(0, matrix[0][column]);
    }
    return true;
  }
}
```

## Solution - 4

For the follow-up 1, we are only able to load one row at one time, so we have to use a buffer (1D data structure) to store the row info. When next row comes as a streaming flow, we can compare each value (say, `matrix[i][j], i>=1, j>=1`) to the "upper-left" value in the buffer (buffer[j - 1]); meanwhile, we update the buffer by inserting the 1st element of the current row (`matrix[i][0]`) to buffer at position 0 (buffer[0]), and removing the last element in the buffer.

```dart
class Solution {
  bool isToeplitzMatrix(List<List<int>> matrix) {
    if (matrix.length == 0 || matrix[0].length == 0) {
      return true;
    }
    List<int> buffer = List.filled(matrix[0].length, 0);
    for (int j = 0; j < matrix[0].length; j++) {
      buffer[j] = matrix[0][j];
    }
    for (int i = 1; i < matrix.length; i++) {
      for (int j = matrix[0].length - 1; j >= 1; j--) {
        if (buffer[j - 1] != matrix[i][j]) {
          return false;
        }
        buffer[j] = matrix[i][j];
      }
      buffer[0] = matrix[i][0];
    }

    return true;
  }
}
```

## Solution - 5

```dart
class Solution {
  int min(int a, int b) {
    return ((a > b) ? b : a);
  }

  int max(int a, int b) {
    return ((a < b) ? b : a);
  }

  bool isToeplitzMatrix(List<List<int>> matrix) {
    int width = matrix[0].length;
    int height = matrix.length;
    // This step indicates the maximum length of 'piece' which can be loaded at one time.
    int step = 3;
    int size = 1;
    int index = width - 1;

    while (index >= 0) {
      size = min(index + 1, step);
      List<int> memory = List.filled(size, 0);
      for (int i = 0; i < size; i++) {
        memory[size - i - 1] = matrix[0][index - i]; //set memory
      }
      for (int j = 1; j < min(height, width); j++) {
        //check the related pieces of rows
        //set boundary
        int rightBound = min(index + j, width - 1);
        int leftBound = max(index - step + 1 + j, j);
        for (int m = 0, n = leftBound; m < size && n <= rightBound; m++, n++)
          if (matrix[j][n] != memory[m]) return false;
      }
      index -= step;
    }

    index = 0;
    while (index < height) {
      //for the purpose of completeness, the criteria should include two sides of the matrix
      size = min(height - 1 - index, step);
      List<int> memory = List.filled(size, 0);
      for (int i = 0; i < size; i++) {
        memory[size - 1 - i] = matrix[height - index - 1 - i][0];
      }
      for (int j = 1; j < min(height, width); j++) {
        int upperBound = max(height - index - step + j, j + 1);
        int lowerBound = min(height - index - 1 + j, height - 1);
        for (int m = 0, n = upperBound; m < size && n <= lowerBound; m++, n++)
          if (matrix[n][j] != memory[m]) return false;
      }
      index += step;
    }

    return true;
  }
}
```
