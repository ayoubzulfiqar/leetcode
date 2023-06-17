/*

-* 2352. Equal Row and Column Pairs *-

Given a 0-indexed n x n integer matrix grid, return the number of pairs (ri, cj) such that row ri and column cj are equal.

A row and column pair is considered equal if they contain the same elements in the same order (i.e., an equal array).

 

Example 1:


Input: grid = [[3,2,1],[1,7,6],[2,7,7]]
Output: 1
Explanation: There is 1 equal row and column pair:
- (Row 2, Column 1): [2,7,7]
Example 2:


Input: grid = [[3,1,2,2],[1,4,4,5],[2,4,2,2],[2,4,2,2]]
Output: 3
Explanation: There are 3 equal row and column pairs:
- (Row 0, Column 0): [3,1,2,2]
- (Row 2, Column 2): [2,4,2,2]
- (Row 3, Column 2): [2,4,2,2]
 

Constraints:

n == grid.length == grid[i].length
1 <= n <= 200
1 <= grid[i][j] <= 105


*/

class B {
  List<List<int>> transpose(List<List<int>> gr) {
    final List<List<int>> gc = [].map((e) => <int>[]).toList();
    int n = gr.length;

    for (int i = 0; i < n; i++) {
      final List<int> v = <int>[];
      for (int j = 0; j < n; j++) {
        v.add(gr[j][i]); // column-wise pushing
      }
      gc.add(v);
    }

    return gc;
  }

  bool isListEqual(List<int> listOne, List<int> listTwo) {
    if (listOne.length != listTwo.length) {
      return false;
    }

    for (int i = 0; i < listOne.length; i++) {
      if (listOne[i] != listTwo[i]) {
        return false;
      }
    }

    return true;
  }

  int equalPairs(List<List<int>> gr) {
    final List<List<int>> gc = transpose(gr);
    final int n = gr.length;

    int ans = 0;
    for (int i = 0; i < n; i++) {
      for (int j = 0; j < n; j++) {
        if (isListEqual(gr[i], gc[j])) {
          ans++;
        }
      }
    }

    return ans;
  }
}

class F {
  List<List<int>> transpose(List<List<int>> gr) {
    final List<List<int>> gc = [].map((e) => <int>[]).toList();
    int n = gr.length;

    for (int i = 0; i < n; i++) {
      final List<int> v = <int>[];
      for (int j = 0; j < n; j++) {
        v.add(gr[j][i]); // column-wise pushing
      }
      gc.add(v);
    }

    return gc;
  }

  bool isListEqual(List<int> listOne, List<int> listTwo) {
    if (listOne.length != listTwo.length) {
      return false;
    }

    for (int i = 0; i < listOne.length; i++) {
      if (listOne[i] != listTwo[i]) {
        return false;
      }
    }

    return true;
  }

  int equalPairs(List<List<int>> gr) {
    final List<List<int>> gc = transpose(gr);
    final int n = gr.length;

    int ans = 0;
    for (int i = 0; i < n; i++) {
      for (int j = 0; j < n; j++) {
        if (isListEqual(gr[i], gc[j])) {
          ans++;
        }
      }
    }

    return ans;
  }
}
