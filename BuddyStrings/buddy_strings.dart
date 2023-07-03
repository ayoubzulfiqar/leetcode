/*


-* 859. Buddy Strings *-



Given two strings s and goal, return true if you can swap two letters in s so the result is equal to goal, otherwise, return false.

Swapping letters is defined as taking two indices i and j (0-indexed) such that i != j and swapping the characters at s[i] and s[j].

For example, swapping at indices 0 and 2 in "abcd" results in "cbad".
 

Example 1:

Input: s = "ab", goal = "ba"
Output: true
Explanation: You can swap s[0] = 'a' and s[1] = 'b' to get "ba", which is equal to goal.
Example 2:

Input: s = "ab", goal = "ab"
Output: false
Explanation: The only letters you can swap are s[0] = 'a' and s[1] = 'b', which results in "ba" != goal.
Example 3:

Input: s = "aa", goal = "aa"
Output: true
Explanation: You can swap s[0] = 'a' and s[1] = 'a' to get "aa", which is equal to goal.
 

Constraints:

1 <= s.length, goal.length <= 2 * 104
s and goal consist of lowercase letters.



*/

import 'dart:collection';

class A {
  bool buddyStrings(String s, String goal) {
    if (s.length != goal.length) return false;

    if (s == goal) {
      List<int> count = List.filled(26, 0);

      for (int i = 0; i < s.length; i++) {
        int c = s.codeUnitAt(i) - 'a'.codeUnitAt(0);
        count[c]++;
        if (count[c] == 2) return true;
      }

      return false;
    }

    int index1 = -1;
    int index2 = -1;

    for (int i = 0; i < s.length; i++) {
      if (s[i] != goal[i]) {
        if (index1 == -1)
          index1 = i;
        else if (index2 == -1)
          index2 = i;
        else
          return false;
      }
    }

    if (index2 == -1) return false;

    return (s[index1] == goal[index2] && s[index2] == goal[index1]);
  }
}

class B {
  bool buddyStrings(String s, String goal) {
    final int n = s.length;

    if (s == goal) {
      final HashSet<String> temp = HashSet<String>();
      for (int i = 0; i < s.length; i++) {
        temp.add(s[i]);
      }
      return temp.length < goal.length; // Swapping same characters
    }

    int i = 0;
    int j = n - 1;

    while (i < j && s[i] == goal[i]) {
      i++;
    }

    while (j >= 0 && s[j] == goal[j]) {
      j--;
    }

    if (i < j) {
      final List<String> sArr = s.split('');
      String temp = sArr[i];
      sArr[i] = sArr[j];
      sArr[j] = temp;
      s = sArr.join('');
    }

    return s == goal;
  }
}
