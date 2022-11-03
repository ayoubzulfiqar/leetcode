/*


-* Longest Palindrome by Concatenating Two Letter Words *-

You are given an array of strings words. Each element of words consists of two lowercase English letters.

Create the longest possible palindrome by selecting some elements from words and concatenating them in any order. Each element can be selected at most once.

Return the length of the longest palindrome that you can create. If it is impossible to create any palindrome, return 0.

A palindrome is a string that reads the same forward and backward.



Example 1:

Input: words = ["lc","cl","gg"]
Output: 6
Explanation: One longest palindrome is "lc" + "gg" + "cl" = "lcggcl", of length 6.
Note that "clgglc" is another longest palindrome that can be created.
Example 2:

Input: words = ["ab","ty","yt","lc","cl","ab"]
Output: 8
Explanation: One longest palindrome is "ty" + "lc" + "cl" + "yt" = "tylcclyt", of length 8.
Note that "lcyttycl" is another longest palindrome that can be created.
Example 3:

Input: words = ["cc","ll","xx"]
Output: 2
Explanation: One longest palindrome is "cc", of length 2.
Note that "ll" is another longest palindrome that can be created, and so is "xx".


Constraints:

1 <= words.length <= 105
words[i].length == 2
words[i] consists of lowercase English letters.


*/

import 'dart:collection';

class A {
  int longestPalindrome(List<String> words) {
    List<List<int>> counter =
        List.filled(26, 0).map((e) => List.filled(26, 0)).toList();
    int ans = 0;
    // for different letters in the word
    for (String s in words) {
      int a = s[0].codeUnitAt(0) - 'a'.codeUnitAt(0); // first letter
      int b = s[1].codeUnitAt(0) - 'a'.codeUnitAt(0); // second letter
      // if the reverse of the word exists i.e like for "lc" if "cl" exists
      if (counter[b][a] != 0) {
        ans += 4; // count increase by 2+2 = 4
        counter[b][a]--; // remove the occurrence of the word from counter
      } else
        counter[a][
            b]++; // if original doesn't exits in counter array then increase in counter
    }
    // for same letters in the word
    for (int i = 0; i < 26; i++) {
      if (counter[i][i] != 0) {
        // if both the letters are same
        ans += 2; // increase by 2 i.e like for "gg"
        break;
      }
    }
    return ans;
  }
}

class B {
  int longestPalindrome(List<String> words) {
    int result = 0;
    List<List<int>> letterArr =
        List.filled(26, 0).map((e) => List.filled(26, 0)).toList();
    for (int i = 0; i < words.length; i++) {
      int index1 = words[i].codeUnitAt(0) - 'a'.codeUnitAt(0);
      int index2 = words[i].codeUnitAt(1) - 'a'.codeUnitAt(0);
      if (letterArr[index2][index1] > 0) {
        --letterArr[index2][index1];
        result += 4;
      } else
        ++letterArr[index1][index2];
    }
    for (int i = 0; i < 26; i++) {
      if (letterArr[i][i] > 0) return result + 2;
    }
    return result;
  }
}

class C {
  int longestPalindrome(List<String> words) {
    HashMap<String, int> map = HashMap();
    int max = 0;
    for (String word in words) {
      String flipped = "" + word[1] + word[0];
      if (map.containsKey(flipped)) {
        max += 4;
        map.addEntries(
          [MapEntry(flipped, map[flipped]! - 1)],
        );
        if (map[flipped] == 0) map.remove(flipped);
      } else {
        map.addEntries([MapEntry(word, map.putIfAbsent(word, () => 0) + 1)]);
      }
    }
    for (int i = 0; i < 26; i++) {
      String current = ('a' + i.toString());
      if (map.putIfAbsent("" + current + current, () => 0) > 0) {
        max += 2;
        break;
      }
    }
    return max;
  }
}
