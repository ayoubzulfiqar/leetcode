/*

 -* Excel Sheet Column Title *-

Given an integer columnNumber, return its corresponding
column title as it appears in an
Excel sheet.

For example:

A -> 1
B -> 2
C -> 3
...
Z -> 26
AA -> 27
AB -> 28
...


Example 1:

Input: columnNumber = 1
Output: "A"
Example 2:

Input: columnNumber = 28
Output: "AB"
Example 3:

Input: columnNumber = 701
Output: "ZY"


Constraints:

1 <= columnNumber <= 231 - 1

*/

class A {
  /**
   * Time Complexity: O(log26n), as we are using a loop and in each traversal, we decrement by floor division of 26.

Auxiliary Space: O(10000), as we are using extra space for the array.
  */
// Runtime: 512 ms, faster than 50.00% of Dart online submissions for Excel Sheet Column Title.
// Memory Usage: 141.5 MB, less than 50.00% of Dart online submissions for Excel Sheet Column Title.
  String convertToTitle(int columnNumber) {
    List<int> arr = List.filled(10000, 0);
    int i = 0;

    // Step 1: Converting to number assuming
    // 0 in number system
    while (columnNumber > 0) {
      arr[i] = columnNumber % 26;
      columnNumber = columnNumber ~/ 26;
      i++;
    }

    // Step 2: Getting rid of 0, as 0 is
    // not part of number system
    for (int j = 0; j < i - 1; j++) {
      if (arr[j] <= 0) {
        arr[j] += 26;
        arr[j + 1] = arr[j + 1] - 1;
      }
    }
    String ans = '';
    for (int j = i; j >= 0; j--) {
      if (arr[j] > 0) ans += String.fromCharCode(65 + arr[j] - 1);
    }

    return ans;
  }
}

class B {
// Runtime: 391 ms, faster than 50.00% of Dart online submissions for Excel Sheet Column Title.
// Memory Usage: 140.1 MB, less than 50.00% of Dart online submissions for Excel Sheet Column Title.

  String convertToTitle(int columnNumber) {
    String alpha = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
    if (columnNumber < 26)
      return alpha[columnNumber - 1];
    else {
      int q = (columnNumber ~/ 26), r = columnNumber % 26;
      if (r == 0) {
        if (q == 1)
          return alpha[(26 + r - 1)];
        else
          return convertToTitle(q - 1) + alpha[(26 + r - 1)];
      } else
        return convertToTitle(q) + alpha[r - 1];
    }
  }
}

class C {
// Runtime: 490 ms, faster than 50.00% of Dart online submissions for Excel Sheet Column Title.
// Memory Usage: 150.5 MB, less than 50.00% of Dart online submissions for Excel Sheet Column Title.
  String convertToTitle(int columnNumber) {
    if (columnNumber-- == 0) return "";
    return convertToTitle(columnNumber ~/ 26) +
        String.fromCharCode((columnNumber % 26) + 'A'.codeUnitAt(0));
  }
}

class D {
// Runtime: 305 ms, faster than 50.00% of Dart online submissions for Excel Sheet Column Title.
// Memory Usage: 157.9 MB, less than 50.00% of Dart online submissions for Excel Sheet Column Title.
  String convertToTitle(int columnNumber) {
    StringBuffer result = StringBuffer();

    while (columnNumber > 0) {
      columnNumber--;
      //result.write(0, ('A' + n % 26));
      result.writeCharCode(((columnNumber % 26) + 'A'.codeUnitAt(0)));
      columnNumber ~/= 26;
    }

    return result.toString().split("").reversed.join("");
  }
}

class E {
// Runtime: 324 ms, faster than 50.00% of Dart online submissions for Excel Sheet Column Title.
// Memory Usage: 140 MB, less than 50.00% of Dart online submissions for Excel Sheet Column Title.

  String convertToTitle(int columnNumber) {
    return columnNumber == 0
        ? ""
        : convertToTitle(--columnNumber ~/ 26) +
            String.fromCharCode((columnNumber % 26) + 'A'.codeUnitAt(0));
  }
}
