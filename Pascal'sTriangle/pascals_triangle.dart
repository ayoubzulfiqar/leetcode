/*

 -* Pascal's Triangle *-

Given an integer numRows, return the first numRows of Pascal's triangle.

In Pascal's triangle, each number is the sum of the two numbers directly above it as shown:




Example 1:

Input: numRows = 5
Output: [[1],[1,1],[1,2,1],[1,3,3,1],[1,4,6,4,1]]
Example 2:

Input: numRows = 1
Output: [[1]]


Constraints:

1 <= numRows <= 30

*/

/*
if I initialise pascal like:
let pascal = Array(numRows).fill([])
before the for loop and remove the first line from the for-loop. I should get the same result but not.

After lot of fussing, I got to know that if I initialise pascal as:
let pascal = Array(numRows).fill([]).map(() => [])
Then I'm getting the same result. Even though they print the same result.
*/
class A {
// Runtime: 375 ms, faster than 68.57% of Dart online submissions for Pascal's Triangle.
// Memory Usage: 140.6 MB, less than 45.71% of Dart online submissions for Pascal's Triangle.
  List<List<int>> generate(int numRows) {
    List<List<int>> pascal =
        List.filled(numRows, 0).map((e) => List.filled(numRows, 0)).toList();
    for (var i = 0; i < numRows; i++) {
      pascal[i] = List.filled(i + 1, 1);
      for (var j = 1; j < i; j++) {
        pascal[i][j] = pascal[i - 1][j - 1] + pascal[i - 1][j];
      }
      pascal[i][i] = 1;
    }
    return pascal;
  }
}

// List<List<int>> ans =
//     List.filled(numRows, 0).map((e) => List.filled(numRows, 0)).toList();

class E {
//   Runtime: 347 ms, faster than 80.00% of Dart online submissions for Pascal's Triangle.
// Memory Usage: 157.9 MB, less than 8.57% of Dart online submissions for Pascal's Triangle.
  List<List<int>> generate(int numRows) {
    List<List<int>> ans =
        List.filled(numRows, 0).map((e) => List.filled(numRows, 0)).toList();
    for (int i = 0; i < numRows; i++) {
      List<int> row = List.filled(i + 1, 1);
      int mid = i >> 1;
      for (int j = 1; j <= mid; j++) {
        int val = ans[i - 1][j - 1] + ans[i - 1][j];
        row[j] = val;
        row[row.length - j - 1] = val;
      }
      ans[i] = row;
    }
    return ans;
  }
}
