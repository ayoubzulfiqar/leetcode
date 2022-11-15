/*

-* 326. Power of Three *-


Given an integer n, return true if it is a power of three. Otherwise, return false.

An integer n is a power of three, if there exists an integer x such that n == 3x.



Example 1:

Input: n = 27
Output: true
Explanation: 27 = 33
Example 2:

Input: n = 0
Output: false
Explanation: There is no x where 3x = 0.
Example 3:

Input: n = -1
Output: false
Explanation: There is no x where 3x = (-1).


Constraints:

-231 <= n <= 231 - 1


Follow up: Could you solve it without loops/recursion?


*/

import 'dart:collection';
import 'dart:math';

class A {
  bool isPowerOfThree(int n) {
    if (n <= 0) return false;
    while (n % 3 == 0) {
      n ~/= 3;
    }
    return n == 1;
  }
}

class B {
  bool isPowerOfThree(int n) {
    return (log(n) / log(3)) % 1 == 0;
  }
}

class C {
  bool isPowerOfThree(int n) {
    HashMap<int, bool> m = HashMap();
    m[1] = true;
    m[3] = true;
    m[9] = true;
    m[27] = true;
    m[81] = true;
    m[243] = true;
    m[729] = true;
    m[2187] = true;
    m[6561] = true;
    m[19683] = true;
    m[59049] = true;
    m[177147] = true;
    m[531441] = true;
    m[1594323] = true;
    m[4782969] = true;
    m[14348907] = true;
    m[43046721] = true;
    m[129140163] = true;
    m[387420489] = true;
    m[1162261467] = true;
    return m[n] ?? false;
  }
}

class D {
  bool isPowerOfThree(int n) {
    if (n <= 1) return n == 1;
    return n % 3 == 0 && isPowerOfThree(n ~/ 3);
  }
}

class E {
  bool isPowerOfThree(int n) {
    if (n < 1) return false;
    for (; n != 1; n ~/= 3) if (n % 3 != 0) return false;
    return true;
  }
}

class F {
  bool isPowerOfThree(int n) {
    return n > 0 && 1162261467 % n == 0;
    // pow(3, floor(log(INT_MAX)/log(3))) = 1162261467
  }
}

class G {
  bool isPowerOfThree(int n) {
    if (n < 1) return false;
    String nBase3 = "";
    while (n != 0) nBase3 += (n % 3).toString();
    n ~/= 3; // conversion to base 3
    int i = 0;
    while (i < nBase3.length - 1)
      if (nBase3[i++] != '0')
        return false; // checking if all digits in base 3 converted number except first one are 0
    return nBase3[i] == '1'; // check if starting digit is 1
  }
}
