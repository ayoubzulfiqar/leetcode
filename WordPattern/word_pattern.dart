/*


-* Word Pattern *-

Given a pattern and a string s, find if s follows the same pattern.

Here follow means a full match, such that there is a bijection between a letter in pattern and a non-empty word in s.



Example 1:

Input: pattern = "abba", s = "dog cat cat dog"
Output: true
Example 2:

Input: pattern = "abba", s = "dog cat cat fish"
Output: false
Example 3:

Input: pattern = "aaaa", s = "dog cat cat dog"
Output: false


Constraints:

1 <= pattern.length <= 300
pattern contains only lower-case English letters.
1 <= s.length <= 3000
s contains only lowercase English letters and spaces ' '.
s does not contain any leading or trailing spaces.
All the words in s are separated by a single space.

*/

import 'dart:collection';

void main() {
  String pattern = "abba";
  String s = "dog cat cat cat";

  Solution sol = Solution();
  print(sol.wordPattern(pattern, s));
}

class Solution {
  bool wordPattern(String pattern, String s) {
    // s is the sentence so we breaking it into each and  every single word
    List<String> words = s.split("");
    // Two HashMap
    if (words.length != pattern.length) return false;

    HashMap<int, String> firstHashMap = HashMap();
    HashMap<String, bool> secondHashMap = HashMap();

    // looping through each and every character
    for (int i = 0; i < pattern.length; i++) {
      // getting the char code of every pattern
      int char = pattern.codeUnitAt(i);
      // because it has sentence so we taking the each character and making into a a single word
      // to compare with the char
      if (firstHashMap.containsKey(char) == false) {
        if (secondHashMap.containsKey(words[i]) == true) {
          return false;
        } else {
          secondHashMap[words[i]] = true;
          firstHashMap[char] = words[i];
        }
      } else {
        String mWith = firstHashMap[char]!;
        if (mWith.allMatches(words[i]) == false) {
          return false;
        }
      }
    }
    return true;
  }
}

class B {
  bool wordPattern(String pattern, String s) {
    // initializing HashMap because it's fast
    final HashMap<String, String> map = HashMap();
    // splitting the sentence into each individual character
    final List<String> words = s.split(' ');
    final List<String> patternWords = pattern.split('');
    // if the length is not same
    if (words.length != patternWords.length) return false;
    // looping through each and every individual pattern word
    for (int i = 0; i < patternWords.length; i++) {
      // if the key is null or empty
      if (map[patternWords[i]] == null) {
        // but value contain it
        if (map.containsValue(words[i])) {
          return false;
        }
        // assign each and every character and word
        map[patternWords[i]] = words[i];
      } else {
        // if they are nt assign than false
        if (map[patternWords[i]] != words[i]) {
          return false;
        }
      }
    }
    return true;
  }
}
