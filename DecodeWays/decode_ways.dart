/*

 -* Decode Ways *-

 A message containing letters from A-Z can be encoded into numbers using the following mapping:

'A' -> "1"
'B' -> "2"
...
'Z' -> "26"
To decode an encoded message, all the digits must be grouped then mapped back into letters using the reverse of the mapping above (there may be multiple ways). For example, "11106" can be mapped into:

"AAJF" with the grouping (1 1 10 6)
"KJF" with the grouping (11 10 6)
Note that the grouping (1 11 06) is invalid because "06" cannot be mapped into 'F' since "6" is different from "06".

Given a string s containing only digits, return the number of ways to decode it.

The test cases are generated so that the answer fits in a 32-bit integer.



Example 1:

Input: s = "12"
Output: 2
Explanation: "12" could be decoded as "AB" (1 2) or "L" (12).
Example 2:

Input: s = "226"
Output: 3
Explanation: "226" could be decoded as "BZ" (2 26), "VF" (22 6), or "BBF" (2 2 6).
Example 3:

Input: s = "06"
Output: 0
Explanation: "06" cannot be mapped to "F" because of the leading zero ("6" is different from "06").


Constraints:

1 <= s.length <= 100
s contains only digits and may contain leading zero(s).


*/

class A {
  // Using Tabulation
  // Runtime: 522 ms, faster than 50.00% of Dart online submissions for Decode Ways.
// Memory Usage: 140.3 MB, less than 100.00% of Dart online submissions for Decode Ways.
  int numDecodings(String s) {
    // if the string is empty
    if (s.isEmpty) return 0;
    // the length of the list
    int n = s.length;
    // filling the range of the list
    List<int> dp = List.filled(n + 1, 0);
    // setting the length of to One
    dp[n] = 1;
    int t;
    // Checking if the current character is a zero. If it is, then it is setting the current
    // character to the next character. If the current character is not a zero, then it is checking if
    // the
    // current character is not equal to the length of the string minus one. If it is not equal to the
    // length
    // of the string minus one, then it is setting the current character to the current character times
    // ten
    // plus the next character. If the current character is greater than nine and less than
    // twenty-seven, then
    // setting the current character to the current character plus the next character plus two.
    for (int i = n - 1; i >= 0; i--) {
      t = s.codeUnitAt(i) - '0'.codeUnitAt(0);
      if (t > 0) {
        dp[i] = dp[i + 1];
        if (i != n - 1) t = 10 * t + s[i + 1].codeUnitAt(0) - '0'.codeUnitAt(0);
        if (t > 9 && t < 27) {
          dp[i] += dp[i + 2];
        }
      }
    }

    return dp[0];
  }
}

class B {
// Runtime: 475 ms, faster than 50.00% of Dart online submissions for Decode Ways.
// Memory Usage: 140.6 MB, less than 100.00% of Dart online submissions for Decode Ways.
  // If the current character is 0, then the number of ways to decode is 0. Otherwise, the number of
  // ways to decode is the sum of the number of ways to decode the substring without the current
  // character and the number of ways to decode the substring without the current character and the
  // previous character
  //
  // Args:
  //   i (int): the index of the current character in the string
  //   s (String): the string to decode
  //   dp (List<int>): a list of integers, where dp[i] is the number of ways to decode the string
  // s[0..i]
  //
  // Returns:
  //   The number of ways to decode a string.
  int cal(int i, String s, List<int> dp) {
    if (i == -1 || i == 0) return 1;

    if (dp[i] != -1) return dp[i];
    int w1 = 0, w2 = 0;
    if (s.codeUnitAt(i) > '0'.codeUnitAt(0)) w1 = cal(i - 1, s, dp);
    if (s[i - 1] == '1' ||
        s[i - 1] == '2' && s.codeUnitAt(i) < '7'.codeUnitAt(0))
      w2 = cal(i - 2, s, dp);
    return dp[i] = w1 + w2;
  }

  /// It returns the number of ways to decode a string.
  ///
  /// Args:
  ///   s (String): the string to be decoded
  ///
  /// Returns:
  ///   The number of ways to decode the string.
  int numDecodings(String s) {
    int n = s.length;
    if (s == "0" && s[0] == '0') return 0;
    List<int> dp = List.filled(n + 1, -1);
    return cal(n - 1, s, dp);
  }
}

class C {
// Runtime: 466 ms, faster than 50.00% of Dart online submissions for Decode Ways.
// Memory Usage: 140.4 MB, less than 100.00% of Dart online submissions for Decode Ways.
  /// A recursive function that returns the number of ways to decode a string.
  ///
  /// Args:
  ///   index (int): the current index in the string
  ///   s (String): the string to decode
  ///   n (int): length of the string
  ///   dp (List<int>): This is the list that will store the number of ways to decode the string.
  ///
  /// Returns:
  ///   The number of ways to decode a string.
  int helper(int index, String s, int n, List<int> dp) {
    /// A recursive function that is checking if the index is greater than the length of the string. If it
    /// is, it returns 1. If the index is not greater than the length of the string, it checks if the index
    /// is equal to 0. If it is, it returns 0. If the index is not equal to 0, it checks if the index is
    /// not equal to -1. If it is not equal to -1, it returns the index. If the index is equal to -1, it
    /// takes the index and adds 1 to it. It then takes the index and adds
    if (index >= n) return 1;
    if (s[index] == '0') return 0;
    if (dp[index] != -1) return dp[index];
    int take = helper(index + 1, s, n, dp);
    int take2 = 0;

    /// Checking if the current index is less than n-1. If it is, then it is checking if the current
    /// index is 2 and the next index is less than or equal to 6. If it is, then it is setting take2 to
    /// the helper function with the index + 2. If the current index is 1, then it is setting take2 to
    /// the helper function with the index + 2.
    if (index < n - 1) {
      if (s[index] == '2' && s.codeUnitAt(index + 1) <= '6'.codeUnitAt(0))
        take2 = helper(index + 2, s, n, dp);
      else if (s[index] == '1') take2 = helper(index + 2, s, n, dp);
    }
    return dp[index] = take + take2;
  }

  int numDecodings(String s) {
    int n = s.length;

    /// Creating a list of size n and filling it with -1.
    List<int> dp = List.filled(n, -1);

    /// Returning the helper function with the index of 0, the string, the length of the string, and the
    /// list.
    return helper(0, s, n, dp);
  }
}

class D {
  int numDecodings(String s) {
    int len = s.length;
    List<int> list = List.filled(102, 0);
    list[len] = 1;
    list[len + 1] = 0;
    while (len > 0) {
      len--;
      if (s[len] != '0') {
        list[len] = list[len + 1];
        if (s.codeUnitAt(len) < '3'.codeUnitAt(0)) {
          if (s[len] == '1') {
            list[len] += list[len + 2];
            // range error
          } else if (s.codeUnitAt(len + 1) < '7'.codeUnitAt(0)) {
            list[len] += list[len + 2];
          }
        }
      } else {
        list[len] = 0;
      }
    }
    return list[0];
  }
}

class E {
  // > If the current character is a zero, then the number of ways to decode the string is the same as
  // the number of ways to decode the string without the current character. Otherwise, if the current
  // character is a one, then the number of ways to decode the string is the sum of the number of ways
  // to decode the string without the current character and the number of ways to decode the string
  // without the current character and the next character. Otherwise, if the current character is a two
  // and the next character is less than seven, then the number of ways to decode the string is the sum
  // of the number of ways to decode the string without the current character and the number of ways to
  // decode the string without the current character and the next character. Otherwise, if the current
  // character is a two and the next character is greater than or equal to seven, then the number of
  // ways to decode the string is the number of ways to decode the string without the current character.
  // Otherwise, the number
  //
  // Args:
  //   s (String): the string of digits
  //
  // Returns:
  //   The number of ways to decode the string.
  int optimization(String s) {
    int n = s.length;
    int next = 1, next2 = 0;

    for (int index = n - 1; index >= 0; index--) {
      int pick1 = 0, pick2 = 0;
      if (s[index] != '0') pick1 = next;
      if (index + 1 < n && s[index] != '0') {
        if (s[index].codeUnitAt(0) >= '3'.codeUnitAt(0))
          pick2 = 0;
        else if (s[index] == '2' &&
            s.codeUnitAt(index + 1) >= '7'.codeUnitAt(0))
          pick2 = 0;
        else
          pick2 = next2;
      }

      next2 = next;
      next = pick1 + pick2;
    }

    return next;
  }

  /// It returns the number of ways to decode a string.
  ///
  /// Args:
  ///   s (String): the string to decode
  ///
  /// Returns:
  ///   The number of ways to decode a string.
  int numDecodings(String s) {
    return optimization(s);
  }
}

class F {
  // Time Limit exceed
  int numDecodings(String s) {
    Map<int, int> map = Map();
    return helper(s, 0, map);
  }

  int helper(String s, int index, Map<int, int> map) {
    if (map.containsKey(index)) {
      return map.keys.elementAt(index);
    }
    int len = s.length;

    if (index >= len) return 1;

    int numOfWays = 0;

    int firstNumberWithOneDigit = s.codeUnitAt(index);

    if (firstNumberWithOneDigit - '0'.codeUnitAt(0) > 0) {
      numOfWays += helper(s, index + 1, map);
    }

    if (index < len - 1) {
      String secondNumberWithTwoDigits = s.substring(index, index + 2);

      int value = parse(secondNumberWithTwoDigits);

      if (value <= 26 && value > 0) numOfWays += helper(s, index + 2, map);
    }
    map.forEach((key, value) {
      key = index;
      value = numOfWays;
    });
    return numOfWays;
  }

  int parse(String nums) {
    if (nums.isEmpty) return 0;

    if (nums.startsWith("0")) {
      return 0;
    }

    int result = 0;

    try {
      result = int.parse(nums);
    } catch (e) {
      return 0;
    }

    return result;
  }
}
