/*



-* Valid Perfect Square *-


Given a positive integer num, write a function which returns True if num is a perfect square else False.

Follow up: Do not use any built-in library function such as sqrt.



Example 1:

Input: num = 16
Output: true
Example 2:

Input: num = 14
Output: false


Constraints:

1 <= num <= 2^31 - 1

*/

import 'dart:math';

class A {
  // using math
  bool isPerfectSquare(int num) {
    double n = sqrt(num);
    if (n ~/ n == 1) return true;
    return false;
  }
}

class B {
  // binary search
  bool isPerfectSquare(int num) {
    int low = 0;
    int high = num;
    while (low <= high) {
      int mid = low + (high - low) ~/ 2;
      if (mid * mid == num) {
        return true;
      } else if (mid * mid < num) {
        low = mid + 1;
      } else {
        high = mid - 1;
      }
    }
    return false;
  }
}

class C {
  bool isPerfectSquare(int num) {
    for (int i = 1; num > 0; i += 2) num -= i;
    return num == 0;
  }
}

class D {
  // Using Newton-Raphson method : X+1 = 1/2 [ Xn + a / Xn ]
  bool isPerfectSquare(int num) {
    int temp = num;
    while (temp * temp > num) temp = (temp + num ~/ temp) ~/ 2;
    return temp * temp == num;
  }
}

class E {
  bool isPerfectSquare(int num) {
    int i = 1;
    while (num > 0) {
      num -= i;
      i += 2; // The  1 + 3 + 5 + 7 + 9 +......pattern.
    }
    return num == 0;
  }
}
