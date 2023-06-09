/*


-* 744. Find Smallest Letter Greater Than Target *-

You are given an array of characters letters that is sorted in non-decreasing order, and a character target. There are at least two different characters in letters.

Return the smallest character in letters that is lexicographically greater than target. If such a character does not exist, return the first character in letters.

 

Example 1:

Input: letters = ["c","f","j"], target = "a"
Output: "c"
Explanation: The smallest character that is lexicographically greater than 'a' in letters is 'c'.
Example 2:

Input: letters = ["c","f","j"], target = "c"
Output: "f"
Explanation: The smallest character that is lexicographically greater than 'c' in letters is 'f'.
Example 3:

Input: letters = ["x","x","y","y"], target = "z"
Output: "x"
Explanation: There are no characters in letters that is lexicographically greater than 'z' so we return letters[0].
 

Constraints:

2 <= letters.length <= 104
letters[i] is a lowercase English letter.
letters is sorted in non-decreasing order.
letters contains at least two different characters.
target is a lowercase English letter.

*/
import 'dart:collection';

class A {
  String nextGreatestLetter(List<String> letters, String target) {
    for (String letter in letters) {
      if (letter.compareTo(target) > 0) {
        return letter;
      }
    }
    return letters[0];
  }
}

class B {
  String nextGreatestLetter(List<String> letters, String target) {
    SplayTreeSet<int> jat = SplayTreeSet<int>();

    if (letters[letters.length - 1].compareTo(target) <= 0) {
      return letters[0];
    }

    for (int i = 0; i < letters.length; i++) {
      if (letters[i].compareTo(target) > 0) {
        int temp = letters[i].codeUnitAt(0) - target.codeUnitAt(0);

        if (temp == 0) {
          return letters[i + 1];
        }

        jat.add(temp);
      }
    }

    return String.fromCharCode(target.codeUnitAt(0) + jat.first);
  }
}

class C {
  String nextGreatestLetter(List<String> letters, String target) {
    int left = 0;
    int right = letters.length - 1;

    while (left <= right) {
      int mid = left + ((right - left) ~/ 2);

      if (letters[mid].compareTo(target) > 0) {
        right = mid - 1;
      } else {
        left = mid + 1;
      }
    }

    return letters[left % letters.length];
  }
}
