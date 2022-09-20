/*

-* Longest Common Prefix *-



Write a function to find the longest common prefix string amongst an array of strings.

If there is no common prefix, return an empty string "".



Example 1:

Input: Strings = ["flower","flow","flight"]
Output: "fl"


Example 2:

Input: Strings = ["dog","raceCar","car"]
Output: ""
Explanation: There is no common prefix among the input strings.


Constraints:

1 <= Strings.length <= 200
0 <= Strings[i].length <= 200
Strings[i] consists of only lowercase English letters.

 */

import 'dart:math';

/**
 *
 *
 *
 * [] first i have to define a length of the list
 * than i have to loop on every string enter inside the list
 * if the string matched  with the  other prefix index of the
 * other strings than we will print that value which are matched  if not than empty list
 *
 *
 */

void main() {
  final strs = ["flower", "flow", "flight"];
  final c = B().longestCommonPrefix(strs);
  print(c);
}

class A {
  // Not Working - Horizontal Scan
  String longestCommonPrefix(List<String> strs) {
    // Checking if the list is empty
    if (strs.length == 0 || strs.isEmpty || strs.length == '') return "";

// Storing the first index value in a variable
    String prefix = strs[0];

// looping the whole length of list inside the list
// like how many strings are available
    for (var i = 0; i < strs.length; i++) {
      // storing the whole list in a variable
      String c = strs[i];
      if (c.length == 0 || prefix == "") return "";
      // setting the first index starting point in subString 0 is first string
      // AND  entire length of the remaining list
      prefix = prefix.substring(0, min(prefix.length, c.length));
      for (var j = 0; j < c.length && j < prefix.length; j++) {
        if (c[j] != prefix[j]) {
          prefix = prefix.substring(0, j);
          break;
        }
      }
    }
    return prefix;
  }
}

class B {
  // Vertical scan -Working
  String longestCommonPrefix(List<String> strs) {
    if (strs.length == 0 || strs.isEmpty || strs.length == '') return "";

    // looping through the length of list
    for (int i = 0; i < strs[0].length; i++) {
      // storing the value of first index and the other strings
      String c = strs[0][i];

      // looping again the entire length without index
      for (int j = 1; j < strs.length; j++) {
        // if the the length is same as  the length of the above loop
        //OR indexes of the list is not same as above
        if (i == strs[j].length || strs[j][i] != c)
          // returning the first index and subString starting
          // from first index and the remaining index
          return strs[0].substring(0, i);
      }
    }
    return strs[0];
  }
}
