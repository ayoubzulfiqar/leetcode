/*


-* 1143. Longest Common Subsequence *-



Given two strings text1 and text2, return the length of their longest common subsequence. If there is no common subsequence, return 0.

A subsequence of a string is a new string generated from the original string with some characters (can be none) deleted without changing the relative order of the remaining characters.

For example, "ace" is a subsequence of "abcde".
A common subsequence of two strings is a subsequence that is common to both strings.

 

Example 1:

Input: text1 = "abcde", text2 = "ace" 
Output: 3  
Explanation: The longest common subsequence is "ace" and its length is 3.
Example 2:

Input: text1 = "abc", text2 = "abc"
Output: 3
Explanation: The longest common subsequence is "abc" and its length is 3.
Example 3:

Input: text1 = "abc", text2 = "def"
Output: 0
Explanation: There is no such common subsequence, so the result is 0.
 

Constraints:

1 <= text1.length, text2.length <= 1000
text1 and text2 consist of only lowercase English characters.


*/

import 'dart:math';

class A {
  // Complexity:
  // Time: O(mn), m is length of text1, n is length of text2
  // Space: O(mn) --> can be optimized to O(min(m, n)) since only accessing previous row
  int longestCommonSubsequence(String text1, String text2) {
    if (text1.length < text2.length) {
      return LCS(text1, text2);
    }
    return LCS(text2, text1);
  }

  int LCS(String s1, String s2) {
    List<List<int>> M =
        List.filled(2, 0).map((e) => List.filled(s1.length + 1, 0)).toList();
    //row represents the length of s2, col represents the length of s1

    for (int i = 1; i <= s2.length; i++) {
      //base case
      M[i % 2][0] = 0;
      for (int j = 1; j <= s1.length; j++) {
        if (s1[j - 1] == s2[i - 1]) {
          M[i % 2][j] = M[(i - 1) % 2][j - 1] + 1;
        } else {
          M[i % 2][j] = max(
              M[(i - 1) % 2][j - 1], max(M[(i - 1) % 2][j], M[i % 2][j - 1]));
        }
      }
    }
    return M[s2.length % 2][s1.length];
  }
}

class B {
  // m*n time O(n) space
  int longestCommonSubsequence(String text1, String text2) {
    if (text1.length == 0 || text2.length == 0) return 0;
    int m = text1.length, n = text2.length;
    List<List<int>> dp =
        List.filled(2, 0).map((e) => List.filled(n + 1, 0)).toList();
    for (int i = 1; i <= m; i++) {
      for (int j = 1; j <= n; j++) {
        if (text1[i - 1] == text2[j - 1]) {
          dp[i % 2][j] = dp[(i - 1) % 2][j - 1] + 1;
        } else {
          dp[i % 2][j] = max(dp[i % 2][j - 1], dp[(i - 1) % 2][j]);
        }
      }
    }
    return dp[m % 2][n];
  }
}

class C {
  // s = text1
  // t = text2
  int longestCommonSubsequence(String text1, String text2) {
    int n = text1.length;
    int m = text2.length;

    List<List<int>> dp =
        List.filled(n + 1, 0).map((e) => List.filled(m + 1, 0)).toList();
    if (text1[0] == text2[0]) {
      dp[0][0] = 1;
    } else {
      dp[0][0] = 0;
    }
    for (int i = 1; i < n; i++) {
      if (text1[i] == text2[0]) {
        dp[i][0] = 1;
      } else {
        dp[i][0] = dp[i - 1][0];
      }
    }
    for (int i = 1; i < m; i++) {
      if (text1[0] == text2[i]) {
        dp[0][i] = 1;
      } else {
        dp[0][i] = dp[0][i - 1];
      }
    }
    for (int i = 1; i < n; i++) {
      for (int j = 1; j < m; j++) {
        if (text1[i] == text2[j]) {
          dp[i][j] = 1 + dp[i - 1][j - 1];
        } else {
          dp[i][j] = max(dp[i - 1][j], dp[i][j - 1]);
        }
      }
    }
    return dp[n - 1][m - 1];
  }
}
