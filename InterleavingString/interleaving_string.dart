/*

-* 97. Interleaving String *-


Given strings s1, s2, and s3, find whether s3 is formed by an interleaving of s1 and s2.

An interleaving of two strings s and t is a configuration where s and t are divided into n and m 
substrings
 respectively, such that:

s = s1 + s2 + ... + sn
t = t1 + t2 + ... + tm
|n - m| <= 1
The interleaving is s1 + t1 + s2 + t2 + s3 + t3 + ... or t1 + s1 + t2 + s2 + t3 + s3 + ...
Note: a + b is the concatenation of strings a and b.

 

Example 1:


Input: s1 = "aabcc", s2 = "dbbca", s3 = "aadbbcbcac"
Output: true
Explanation: One way to obtain s3 is:
Split s1 into s1 = "aa" + "bc" + "c", and s2 into s2 = "dbbc" + "a".
Interleaving the two splits, we get "aa" + "dbbc" + "bc" + "a" + "c" = "aadbbcbcac".
Since s3 can be obtained by interleaving s1 and s2, we return true.
Example 2:

Input: s1 = "aabcc", s2 = "dbbca", s3 = "aadbbbaccc"
Output: false
Explanation: Notice how it is impossible to interleave s2 with any other string to obtain s3.
Example 3:

Input: s1 = "", s2 = "", s3 = ""
Output: true
 

Constraints:

0 <= s1.length, s2.length <= 100
0 <= s3.length <= 200
s1, s2, and s3 consist of lowercase English letters.
 

Follow up: Could you solve it using only O(s2.length) additional memory space?


*/

class A {
  bool isInterleave(String s1, String s2, String s3) {
    final int m = s1.length, n = s2.length, k = s3.length;
    if (m + n != k) {
      return false;
    }

    int dp1 = 1;
    for (int i = 1; i <= n; i++) {
      if (s2[i - 1] == s3[i - 1] && dp1 & 1 == 1) {
        dp1 = (dp1 << 1) + 1;
      } else {
        dp1 = dp1 << 1;
      }
    }

    for (int j = 1; j <= m; j++) {
      int dp2 = 0;
      if (s1[j - 1] == s3[j - 1] && dp1 & (1 << n) != 0) {
        dp2 = 1;
      }
      for (int i = 1; i <= n; i++) {
        if ((s1[j - 1] == s3[j + i - 1] && dp1 & (1 << (n - i)) != 0) ||
            (s2[i - 1] == s3[j + i - 1] && dp2 & 1 == 1)) {
          dp2 = (dp2 << 1) + 1;
        } else {
          dp2 = dp2 << 1;
        }
      }
      dp1 = dp2;
    }

    return dp1 & 1 == 1;
  }
}

class Solution {
  bool solve(
      String s1, String s2, String s3, int ind1, int ind2, List<List<int>> dp) {
    if (ind1 + ind2 == s3.length) return true;
    if (dp[ind1][ind2] != -1) return dp[ind1][ind2] == 1;
    bool ans = false;

    if (ind1 < s1.length && s1[ind1] == s3[ind1 + ind2]) {
      ans |= solve(s1, s2, s3, ind1 + 1, ind2, dp);
    }

    if (ind2 < s2.length && s2[ind2] == s3[ind1 + ind2]) {
      ans |= solve(s1, s2, s3, ind1, ind2 + 1, dp);
    }

    dp[ind1][ind2] = ans ? 1 : 0;
    return ans;
  }

  bool isInterleave(String s1, String s2, String s3) {
    if (s1.length + s2.length != s3.length) {
      return false;
    }

    // int[][] dp = new int[s1.length + 1][s2.length + 1];
    final List<List<int>> dp = List.filled(s1.length + 1, 0)
        .map((e) => List.filled(s2.length + 1, 0))
        .toList();
    for (int i = 0; i <= s1.length; i++) {
      // Arrays.fill(dp[i], -1);
      List.filled(dp[i].length, -1);
    }

    return solve(s1, s2, s3, 0, 0, dp);
  }
}
