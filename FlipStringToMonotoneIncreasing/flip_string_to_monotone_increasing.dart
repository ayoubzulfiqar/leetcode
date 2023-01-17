/*


-* 926. Flip String to Monotone Increasing *-

A binary string is monotone increasing if it consists of some number of 0's (possibly none), followed by some number of 1's (also possibly none).

You are given a binary string s. You can flip s[i] changing it from 0 to 1 or from 1 to 0.

Return the minimum number of flips to make s monotone increasing.

 

Example 1:

Input: s = "00110"
Output: 1
Explanation: We flip the last digit to get 00111.
Example 2:

Input: s = "010110"
Output: 2
Explanation: We flip to get 011111, or alternatively 000111.
Example 3:

Input: s = "00011000"
Output: 2
Explanation: We flip to get 00000000.
 

Constraints:

1 <= s.length <= 105
s[i] is either '0' or '1'.


*/

import 'dart:math';

class A {
  int minFlipsMonoIncr(String s) {
    // Initialize variables to store the minimum number of flips and the number of flips currently needed
    int ans = 0;
    int noOfFlip = 0;

    // Iterate through each character in the input string
    for (int i = 0; i < s.length; i++) {
      // If the current character is a '0', update the minimum number of flips and add 1 to the current number of flips
      if (s.codeUnitAt(i) == '0')
        ans = min(noOfFlip, ans + 1);
      // If the current character is a '1', increment the number of flips
      else
        noOfFlip++;
    }
    // Return the minimum number of flips
    return ans;
  }
}

class B {
  int minFlipsMonoIncr(String s) {
    int n = s.length;
    int ans = 100000;
    List<int> oneCount = List.filled(n, 0);
    List<int> zeroCount = List.filled(n, 0);
    oneCount[0] = 0;
    zeroCount[n - 1] = 0;
    for (int i = 1; i < n; i++) {
      if (s[i - 1] == '1')
        oneCount[i] = oneCount[i - 1] + 1;
      else
        oneCount[i] = oneCount[i - 1];
      if (s[n - i] == '0')
        zeroCount[n - i - 1] = zeroCount[n - i] + 1;
      else
        zeroCount[n - i - 1] = zeroCount[n - i];
    }
    for (int i = 0; i < n; i++) {
      ans = min(ans, zeroCount[i] + oneCount[i]);
    }
    return ans;
  }
}

class C {
  //TLE
  int minFlipsMonoIncr(String s) {
    int n = s.length;
    int mini = 10000;
    List<int> ans = List.filled(n, 0);
    for (int i = 0; i < n; i++) {
      ans[i] += oneCount(s.substring(0, i));
      ans[i] += zeroCount(s.substring(i + 1));
      mini = min(mini, ans[i]);
    }
    return mini;
  }

  int oneCount(String s) {
    int n = s.length;
    int cnt = 0;
    for (int i = 0; i < n; i++) {
      if (s[i] == '1') cnt++;
    }
    return cnt;
  }

  int zeroCount(String s) {
    int n = s.length;
    int cnt = 0;
    for (int i = 0; i < n; i++) {
      if (s[i] == '0') cnt++;
    }
    return cnt;
  }
}
