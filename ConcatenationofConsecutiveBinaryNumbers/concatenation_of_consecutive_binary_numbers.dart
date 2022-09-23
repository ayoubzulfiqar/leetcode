/*

 - Concatenation of Consecutive Binary Numbers *-


Given an integer n, return the decimal value of the binary string formed by concatenating the binary representations of 1 to n in order, modulo 109 + 7.



Example 1:

Input: n = 1
Output: 1
Explanation: "1" in binary corresponds to the decimal value 1.
Example 2:

Input: n = 3
Output: 27
Explanation: In binary, 1, 2, and 3 corresponds to "1", "10", and "11".
After concatenating them, we have "11011", which corresponds to the decimal value 27.
Example 3:

Input: n = 12
Output: 505379714
Explanation: The concatenation results in "1101110010111011110001001101010111100".
The decimal value of that is 118505380540.
After modulo 109 + 7, the result is 505379714.


Constraints:

1 <= n <= 105


*/

// Disclaimer :  -* Unfortunately this Solution is not available in DART on Leetcode *-
// Solution :- Check the Golang Version for leetcode

import 'dart:math';

class A {
  // Bit Manipulation
  int concatenatedBinary(int n) {
    int mod = (1e9 + 7).toInt();
    int res = 0;
    for (int i = 1; i <= n; i++) {
      int bitLen = (log(i) ~/ log(2)) + 1;
      res = ((res << bitLen) + i) % mod;
    }
    return res;
  }
}

class B {
  int concatenatedBinary(int n) {
    int res = 0;
    int bitLength = 1;
    int nextIncrease = 2;

    for (int i = 1; i <= n; i++) {
      if (i == nextIncrease) {
        nextIncrease *= 2;
        bitLength++;
      }

      res = (res << bitLength) | i;
      res %= 1000000007;
    }

    return res;
  }
}

class C {
  int concatenatedBinary(int n) {
    int sum = 0;
    for (int i = 1; i <= n; i++) {
      // String binary = int.toBinaryString(i);
      String binary = i.toRadixString(2);
      sum = ((sum << binary.length) + i) % 1000000007;
    }
    return sum;
  }
}

// Math
class D {
  int concatenatedBinary(int n) {
    final int modulo = (1e9 + 7).toInt();
    int result = 0;
    for (int i = 1; i <= n; i++) {
      // For each i, we shift left the position of result with * 2,
      // while shifting right the position of i with / 2.
      int temp = i;
      while (temp > 0) {
        temp ~/= 2;
        result *= 2;
      }
      // Add the i to the result and get the remainder of modulo.
      result = (result + i) % modulo;
    }
    return result;
  }
}

class E {
  int concatenatedBinary(int n) {
    int digits = 0, MOD = 1000000007;
    int result = 0;
    for (int i = 1; i <= n; i++) {
      /* if "i" is a power of 2, then we have one additional digit in
			   its the binary equivalent compared to that of i-1 */
      if ((i & (i - 1)) == 0) digits++;
      result = ((result << digits) + i) % MOD;
    }

    return result;
  }
}
