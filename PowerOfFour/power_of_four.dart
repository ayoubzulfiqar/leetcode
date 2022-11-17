/*

 -* 342. Power of Four *-

 Given an integer n, return true if it is a power of four. Otherwise, return false.

An integer n is a power of four, if there exists an integer x such that n == 4x.



Example 1:

Input: n = 16
Output: true
Example 2:

Input: n = 5
Output: false
Example 3:

Input: n = 1
Output: true


Constraints:

-231 <= n <= 231 - 1


Follow up: Could you solve it without loops/recursion?



*/

import 'dart:math';

class A {
  bool isPowerOfFour(int n) {
    if (n <= 0) return false;
    while (n % 3 == 0) {
      n ~/= 3;
    }
    return n == 1;
  }
}

class B {
  bool isPowerOfFour(int n) {
    return (log(n) / log(4)) % 1 == 0;
  }
}

class C {
  bool isPowerOfFour(int n) {
    if (n <= 1) return n == 1;
    return n % 4 == 0 && isPowerOfFour(n ~/ 4);
  }
}

class D {
  bool isPowerOfThree(int n) {
    if (n < 1) return false;
    String nBase4 = "";
    while (n != 0) nBase4 += (n % 4).toString();
    n ~/= 3; // conversion to base 3
    int i = 0;
    while (i < nBase4.length - 1)
      if (nBase4[i++] != '0')
        return false; // checking if all digits in base 3 converted number except first one are 0
    return nBase4[i] == '1'; // check if starting digit is 1
  }
}
