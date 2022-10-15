/*

 -* String Compression II *-


Run-length encoding is a string compression method that works by replacing consecutive identical characters (repeated 2 or more times) with the concatenation of the character and the number marking the count of the characters (length of the run). For example, to compress the string "aabccc" we replace "aa" by "a2" and replace "ccc" by "c3". Thus the compressed string becomes "a2bc3".

Notice that in this problem, we are not adding '1' after single characters.

Given a string s and an integer k. You need to delete at most k characters from s such that the run-length encoded version of s has minimum length.

Find the minimum length of the run-length encoded version of s after deleting at most k characters.



Example 1:

Input: s = "aaabcccd", k = 2
Output: 4
Explanation: Compressing s without deleting anything will give us "a3bc3d" of length 6. Deleting any of the characters 'a' or 'c' would at most decrease the length of the compressed string to 5, for instance delete 2 'a' then we will have s = "abcccd" which compressed is abc3d. Therefore, the optimal way is to delete 'b' and 'd', then the compressed version of s will be "a3c3" of length 4.
Example 2:

Input: s = "aabbaa", k = 2
Output: 2
Explanation: If we delete both 'b' characters, the resulting compressed string would be "a4" of length 2.
Example 3:

Input: s = "aaaaaaaaaaa", k = 0
Output: 3
Explanation: Since k is zero, we cannot delete anything. The compressed string is "a11" of length 3.


Constraints:

1 <= s.length <= 100
0 <= k <= s.length
s contains only lowercase English letters.

*/

import 'dart:collection';
import 'dart:math';

class A {
// Runtime: 345 ms, faster than 100.00% of Dart online submissions for String Compression II.
// Memory Usage: 161.4 MB, less than 100.00% of Dart online submissions for String Compression II.
  int getLengthOfOptimalCompression(String s, int k) {
    // dp[i][k]: the minimum length for s[:i] with at most k deletion.
    int n = s.length;
    List<List<int>> dp =
        List.filled(110, 0).map((e) => List.filled(110, 0)).toList();
    for (int i = 0; i <= n; i++) for (int j = 0; j <= n; j++) dp[i][j] = 9999;
    // for (int[] i : dp) Arrays.fill(i, n); // this is a bit slower (100ms)
    dp[0][0] = 0;
    for (int i = 1; i <= n; i++) {
      for (int j = 0; j <= k; j++) {
        int cnt = 0, del = 0;
        for (int l = i; l >= 1; l--) {
          // keep s[i], concate the same, remove the different
          // if (s.charAt(l - 1) == s.charAt(i - 1))
          if (s.codeUnitAt(l - 1) == s.codeUnitAt(i - 1))
            cnt++;
          else
            del++;
          if (j - del >= 0)
            dp[i][j] = min(
                dp[i][j],
                dp[l - 1][j - del] +
                    1 +
                    (cnt >= 100
                        ? 3
                        : cnt >= 10
                            ? 2
                            : cnt >= 2
                                ? 1
                                : 0));
        }
        if (j > 0) // delete s[i]
          dp[i][j] = min(dp[i][j], dp[i - 1][j - 1]);
      }
    }
    return dp[n][k];
  }
}

class C {
  int getLengthOfOptimalCompression(String s, int k) {
    int n = s.length;
    // List<List<int>> dp =  int[n + 1][k + 1];
    List<List<int>> dp =
        List.filled(n + 1, 0).map((e) => List.filled(k + 1, 0)).toList();
    for (int i = 0; i <= n; i++) {
      for (int j = 0; j <= k; j++) {
        dp[i][j] = 10000;
      }
    }

    dp[0][0] = 0;
    for (int i = 1; i <= n; i++) {
      for (int j = 0; j <= k; j++) {
        int count = 0;
        int delete = 0;
        for (int m = i; m >= 1; m--) {
          if (s.codeUnitAt(m - 1) == s.codeUnitAt(i - 1)) {
            count++;
          } else {
            delete++;
          }
          if (j - delete >= 0) {
            dp[i][j] = min(
                dp[i][j],
                dp[m - 1][j - delete] +
                    1 +
                    (count >= 100
                        ? 3
                        : count >= 10
                            ? 2
                            : count >= 2
                                ? 1
                                : 0));
          }
        }
        if (j > 0) {
          dp[i][j] = min(dp[i][j], dp[i - 1][j - 1]);
        }
      }
    }

    return dp[n][k];
  }
}

class Solution {
// Runtime: 534 ms, faster than 100.00% of Dart online submissions for String Compression II.
// Memory Usage: 161.9 MB, less than 100.00% of Dart online submissions for String Compression II.
  int n = 127;
  late List<List<int>> dp;
  int getLen(int x) {
    return x == 1
        ? 0
        : x < 10
            ? 1
            : x < 100
                ? 2
                : 3;
  }

  int helper(String str, int left, int k) {
    if (k < 0) return n;
    if (left >= str.length || str.length - left <= k) return 0;
    if (dp[left][k] != -1) return dp[left][k];

    int res = n;
    List<int> cnt = List.filled(26, 0);
    for (int j = left, freq = 0; j < str.length; j++) {
      freq = max(freq, ++cnt[str[j].codeUnitAt(0) - 'a'.codeUnitAt(0)]);
      res = min(
        res,
        1 +
            getLen(freq) +
            helper(
              str,
              j + 1,
              k - (j - left + 1 - freq),
            ),
      );
    }

    return dp[left][k] = res;
  }

  int getLengthOfOptimalCompression(String s, int k) {
    dp = List.filled(n, 0).map((e) => List.filled(n, -1)).toList();

    return helper(s, 0, k);
  }
}

class E {
  int getLength(int n) {
    if (n == 0) {
      return 0;
    } else if (n == 1) {
      return 1;
    } else if (n < 10) {
      return 2;
    } else if (n < 100) {
      return 3;
    } else {
      return 4;
    }
  }

  int recur(String s, String prevChar, int prevCharCount, int k, int index,
      Map<String, int> memo) {
    if (index == s.length) {
      return 0;
    }
    String key = prevChar +
        "," +
        String.fromCharCode(prevCharCount) +
        "," +
        String.fromCharCode(k) +
        "," +
        String.fromCharCode(index);
    int? keyVal = memo[key];

    if (keyVal != null) {
      return keyVal;
    }
    int ch = s.codeUnitAt(index);
    int count = 1;
    int nextIndex = index + 1;

    for (int i = index + 1; i < s.length; i++) {
      if (s.codeUnitAt(i) == ch) {
        count++;
        nextIndex = i + 1;
      } else {
        nextIndex = i;
        break;
      }
    }
    int totalCount = count;
    int prevCountRepresentation = 0;
    //if prev char is equal to current char that means we have removed middle element
    //So we have to subtract the previous representation length and add the new encoding
    //representation length
    if (ch == prevChar) {
      totalCount += prevCharCount;
      prevCountRepresentation = getLength(prevCharCount);
    }

    int representationLength = getLength(totalCount);
    int ans = representationLength +
        recur(s, String.fromCharCode(ch), totalCount, k, nextIndex, memo) -
        prevCountRepresentation;

    if (k > 0) {
      for (int i = 1; i <= k && i <= count; i++) {
        int currentCount = totalCount - i;
        int length = getLength(currentCount);
        //checking if we have to send current char and current char count or previous char
        //and previous char count
        int holder = length +
            recur(
                s,
                currentCount == 0 ? prevChar : String.fromCharCode(ch),
                currentCount == 0 ? prevCharCount : currentCount,
                k - i,
                nextIndex,
                memo) -
            prevCountRepresentation;
        ans = min(ans, holder);
      }
    }
    memo.forEach((keys, values) {
      keys = key;
      values = ans;
    });
    return ans;
  }

  int getLengthOfOptimalCompression(String s, int k) {
    HashMap<String, int> memo = HashMap();
    return recur(s, '\u0000', 0, k, 0, memo);
  }
}

// int getLengthOfOptimalCompression(String s, int k) {

// }
class M {
  int getLengthOfOptimalCompression(String s, int k) {
    // dp[i][k] := length of optimal compression of s[i:] w/ at most k deletion
    // dp.resize(s.length, List<int>(k + 1, kMax));
    dp = List.filled(s.length, 0).map((e) => List.filled(k + 1, kMax)).toList();
    return compression(s, 0, k);
  }

  int kMax = 101;
  late List<List<int>> dp;

  int compression(String s, int i, int k) {
    if (k < 0) return kMax;
    if (i == s.length || s.length - i <= k) return 0;
    if (dp[i][k] != kMax) return dp[i][k];

    int maxFreq = 0; // Max freq in s[i..j]
    List<int> count = List.filled(128, 0);

    // Make chars in s[i..j] be same
    // Keep the char that has max freq in this range and remove other chars
    for (int j = i; j < s.length; ++j) {
      maxFreq = max(maxFreq, ++count[s.codeUnitAt(j)]);
      dp[i][k] = min(
          dp[i][k],
          getLength(maxFreq) +
              compression(s, j + 1, k - (j - i + 1 - maxFreq)));
    }

    return dp[i][k];
  }

  int getLength(int maxFreq) {
    // The length to compress `maxFreq`
    if (maxFreq == 1) return 1; // C
    if (maxFreq < 10) return 2; // [1-9]c
    if (maxFreq < 100) return 3; // [1-9][0-9]c
    return 4; // [1-9][0-9][0-9]c
  }
}
