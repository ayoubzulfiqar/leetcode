/*


 -* Minimum Window Substring *-


Given two strings s and t of lengths m and n respectively, return the minimum window substring of s such that every character in t (including duplicates) is included in the window. If there is no such substring, return the empty string "".

The testcases will be generated such that the answer is unique.

A substring is a contiguous sequence of characters within the string.



Example 1:

Input: s = "ADOBECODEBANC", t = "ABC"
Output: "BANC"
Explanation: The minimum window substring "BANC" includes 'A', 'B', and 'C' from string t.
Example 2:

Input: s = "a", t = "a"
Output: "a"
Explanation: The entire string s is the minimum window.
Example 3:

Input: s = "a", t = "aa"
Output: ""
Explanation: Both 'a's from t must be included in the window.
Since the largest window of s only has one 'a', return empty string.


Constraints:

m == s.length
n == t.length
1 <= m, n <= 105
s and t consist of uppercase and lowercase English letters.


Follow up: Could you find an algorithm that runs in O(m + n) time?




*/

class A {
// Runtime: 529 ms, faster than 50.00% of Dart online submissions for Minimum Window Substring.
// Memory Usage: 149.5 MB, less than 100.00% of Dart online submissions for Minimum Window Substring.
  String minWindow(String s, String t) {
    List<int> ht = List.filled(100, 0);
    int i = 0, j = 0;
    List<int> cht = List.filled(100, 0);
    int m = s.length,
        n = t.length,
        cnt = 0,
        reqcnt = 0,
        min = double.maxFinite.toInt();
    String res = "";
    List<String> ss = s.split("");
    List<String> tt = t.split("");
    for (String ch in tt) cht[ch.codeUnitAt(0) - 'A'.codeUnitAt(0)]++;
    for (int num in cht) if (num > 0) reqcnt++;
    while (j <= m) {
      if (cnt == reqcnt) {
        if (min > (j - i + 1)) {
          min = j - i + 1;
          res = s.substring(i, j);
        }
        if (cht[ss[i].codeUnitAt(0) - 'A'.codeUnitAt(0)] > 0) {
          ht[ss[i].codeUnitAt(0) - 'A'.codeUnitAt(0)]--;
          if (ht[ss[i].codeUnitAt(0) - 'A'.codeUnitAt(0)] <
              cht[ss[i].codeUnitAt(0) - 'A'.codeUnitAt(0)]) cnt--;
        }
        i++;
      } else {
        if (j == m) break;
        if (cht[ss[j].codeUnitAt(0) - 'A'.codeUnitAt(0)] > 0) {
          ht[ss[j].codeUnitAt(0) - 'A'.codeUnitAt(0)]++;
          if (ht[ss[j].codeUnitAt(0) - 'A'.codeUnitAt(0)] ==
              cht[ss[j].codeUnitAt(0) - 'A'.codeUnitAt(0)]) cnt++;
        }
        j++;
      }
    }
    return res;
  }
}

class B {
// Runtime: 555 ms, faster than 50.00% of Dart online submissions for Minimum Window Substring.
// Memory Usage: 142.8 MB, less than 100.00% of Dart online submissions for Minimum Window Substring.
  String minWindow(String s, String t) {
    if (s == "" || t == "") return "";
    if (s.isEmpty || t.isEmpty) return "";

    int n = s.length;
    int m = t.length;

    List<int> freq = List.filled(128, 0);
    int characters = 0;

    for (int i = 0; i < m; i++) {
      freq[t.codeUnitAt(i)]++;
      characters++;
    }

    int start = 0, end = 0;
    int min_length = double.maxFinite.toInt();
    int start_index = 0;

    while (end < n) {
      if (freq[s.codeUnitAt(end)] > 0) characters--;
      freq[s.codeUnitAt(end)]--;
      end++;

      while (characters == 0) {
        if (min_length > end - start) {
          min_length = end - start;
          start_index = start;
        }
        freq[s.codeUnitAt(start)]++;
        if (freq[s.codeUnitAt(start)] > 0) {
          characters++;
        }
        start++;
      }
    }

    return min_length == double.maxFinite.toInt()
        ? ""
        : s.substring(start_index, start_index + min_length);
  }
}

class C {
// Runtime: 309 ms, faster than 100.00% of Dart online submissions for Minimum Window Substring.
// Memory Usage: 158.3 MB, less than 50.00% of Dart online submissions for Minimum Window Substring.
  String minWindow(String s, String t) {
    int m = s.length, n = t.length;
    List<int> map = List.filled(128, 0);
    for (int i = 0; i < n; i++) map[t.codeUnitAt(i)]++;

    int count = 0, i = 0, j = 0, min = double.maxFinite.toInt(), si = -1;
    while (j < m) {
      if (map[s.codeUnitAt(j++)]-- > 0) count++;
      while (count == n) {
        if (j - i < min) {
          min = j - i;
          si = i;
        }
        if (++map[s.codeUnitAt(i++)] > 0) count--;
      }
    }
    return si == -1 ? "" : s.substring(si, si + min);
  }
}
