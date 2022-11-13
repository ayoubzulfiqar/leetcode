/*


-* 151. Reverse Words in a String*-


Given an input string s, reverse the order of the words.

A word is defined as a sequence of non-space characters. The words in s will be separated by at least one space.

Return a string of the words in reverse order concatenated by a single space.

Note that s may contain leading or trailing spaces or multiple spaces between two words. The returned string should only have a single space separating the words. Do not include any extra spaces.



Example 1:

Input: s = "the sky is blue"
Output: "blue is sky the"
Example 2:

Input: s = "  hello world  "
Output: "world hello"
Explanation: Your reversed string should not contain leading or trailing spaces.
Example 3:

Input: s = "a good   example"
Output: "example good a"
Explanation: You need to reduce multiple spaces between two words to a single space in the reversed string.


Constraints:

1 <= s.length <= 104
s contains English letters (upper-case and lower-case), digits, and spaces ' '.
There is at least one word in s.


Follow-up: If the string data type is mutable in your language, can you solve it in-place with O(1) extra space?

*/

class Solution {
  String reverseWords(String s) {
    List<String> words = s.split("\\s+").reversed.toList();
    // List<String> words = s.split("").reversed.toList();
    StringBuffer str = StringBuffer();

    for (int i = words.length - 1; i >= 0; i--) {
      str.writeAll([words[i] + " "]);
    }

    return str.toString().trim();
  }
}

class B {
  String reverseWords(String s) {
    List<String> v = [];
    String s1 = "", s2 = "";
    int ok = 0;
    for (int i = 0; i < s.length; i++) {
      if (s[i] != ' ') {
        s1 += s[i];
        ok = 1;
      } else {
        if (ok == 1) {
          v.add(s1);
          ok = 0;
        }
        s1 = "";
      }
    }
    if (ok == 1) v.add(s1);
    //  reverse(v.begin(),v.end());
    v.reversed;
    for (int i = 0; i < v.length - 1; i++) {
      s2 += v[i];
      s2 += ' ';
    }
    s2 += v[v.length - 1];
    return s2;
  }
}
