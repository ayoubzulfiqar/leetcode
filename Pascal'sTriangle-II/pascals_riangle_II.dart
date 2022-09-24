/*

- * Pascal's Triangle II *-

Given an integer rowIndex, return the rowIndex'th (0-indexed) row of the Pascal's triangle.

In Pascal's triangle, each number is the sum of the two numbers directly above it as shown:




Example 1:

Input: rowIndex = 3
Output: [1,3,3,1]
Example 2:

Input: rowIndex = 0
Output: [1]
Example 3:

Input: rowIndex = 1
Output: [1,1]


Constraints:

0 <= rowIndex <= 33


*/

class A {
// Runtime: 417 ms, faster than 76.92% of Dart online submissions for Pascal's Triangle II.
// Memory Usage: 140.6 MB, less than 73.08% of Dart online submissions for Pascal's Triangle II.
  List<int> getRow(int rowIndex) {
    List<int> array = List.filled(rowIndex + 1, 0);
    array[0] = 1;
    for (int i = 1; i <= rowIndex; i++) {
      for (int j = i; j > 0; j--) {
        array[j] = array[j] + array[j - 1];
      }
    }
    return array;
  }

  List<int> getRowing(int rowIndex) {
// Runtime: 464 ms, faster than 50.00% of Dart online submissions for Pascal's Triangle II.
// Memory Usage: 140.1 MB, less than 96.15% of Dart online submissions for Pascal's Triangle II.
    List<int> anotherArray = List.filled(rowIndex + 1, 1);
    for (var i = 1; i <= rowIndex; i++) {
      for (var j = i - 1; j > 0; j--) {
        anotherArray[j] = anotherArray[j] + anotherArray[j - 1];
      }
    }
    return anotherArray;
  }
}

class B {
// Runtime: 460 ms, faster than 61.54% of Dart online submissions for Pascal's Triangle II.
// Memory Usage: 140.2 MB, less than 80.77% of Dart online submissions for Pascal's Triangle II.
  List<int> getRow(int rowIndex) {
    List<int> arr = List.filled(rowIndex + 1, 0);
    arr[0] = 1;

    for (int i = 1; i <= rowIndex; i++) {
      for (int j = i; j > 0; j--) {
        arr[j] += arr[j - 1];
      }
    }

    List<int> res = [];
    for (int a in arr) {
      res.add(a);
    }
    return res;
  }
}

class C {
// Runtime: 484 ms, faster than 38.46% of Dart online submissions for Pascal's Triangle II.
// Memory Usage: 140.1 MB, less than 96.15% of Dart online submissions for Pascal's Triangle II.
  List<int> getRow(int rowIndex) {
    List<int> ans = List.filled(rowIndex + 1, 0);
    ans[0] = ans[rowIndex] = 1;
    for (int i = 1, up = rowIndex; i < rowIndex; i++, up--)
      ans[i] = ans[i - 1] * up ~/ i;
    return ans;
  }
}

class D {
// Runtime: 432 ms, faster than 73.08% of Dart online submissions for Pascal's Triangle II.
// Memory Usage: 139.9 MB, less than 96.15% of Dart online submissions for Pascal's Triangle II.
  List<int> getRow(int rowIndex) {
    // recursive
    void buildRow(List<int> pascal, int rowIndex, int temp, int up, int down) {
      if (down > rowIndex) return;
      temp = temp * up ~/ down;
      pascal.add(temp);
      buildRow(pascal, rowIndex, temp, --up, ++down);
    }

    List<int> pascal = [];
    pascal.add(1);
    buildRow(pascal, rowIndex, 1, rowIndex, 1);
    return pascal;
  }
}

class E {
// Runtime: 458 ms, faster than 65.38% of Dart online submissions for Pascal's Triangle II.
// Memory Usage: 138.1 MB, less than 100.00% of Dart online submissions for Pascal's Triangle II.
  List<int> getRow(int rowIndex) {
    List<int> row = [];
    row.insert(0, 1);
    for (int i = 1; i <= rowIndex; i++) {
      row.insert(i, row.elementAt(i - 1) * (rowIndex - i + 1) ~/ i);
    }
    return row;
  }
}
