/*

-* Toeplitz Matrix *-

Given an m x n matrix, return true if the matrix is Toeplitz. Otherwise, return false.

A matrix is Toeplitz if every diagonal from top-left to bottom-right has the same elements.



Example 1:


Input: matrix = [[1,2,3,4],[5,1,2,3],[9,5,1,2]]
Output: true
Explanation:
In the above grid, the diagonals are:
"[9]", "[5, 5]", "[1, 1, 1]", "[2, 2, 2]", "[3, 3]", "[4]".
In each diagonal all elements are the same, so the answer is True.
Example 2:


Input: matrix = [[1,2],[2,2]]
Output: false
Explanation:
The diagonal "[1, 2]" has different elements.


Constraints:

m == matrix.length
n == matrix[i].length
1 <= m, n <= 20
0 <= matrix[i][j] <= 99


Follow up:

What if the matrix is stored on disk, and the memory is limited such that you can only load at most one row of the matrix into the memory at once?
What if the matrix is so large that you can only load up a partial row into the memory at once?


*/

import 'dart:collection';

class A {
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

// Solution when Only Load Data One Row at a Time
class B {
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

// Solution when Only Load Data One Column at a Time
class C {
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

//
class D {
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

// Load a partial row/column each time, the length of "piece" is defined as variable 'step'
class E {
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
