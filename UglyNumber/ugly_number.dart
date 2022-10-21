/*



 -* Ugly Number *-

An ugly number is a positive integer whose prime factors are limited to 2, 3, and 5.

Given an integer n, return true if n is an ugly number.



Example 1:

Input: n = 6
Output: true
Explanation: 6 = 2 × 3
Example 2:

Input: n = 1
Output: true
Explanation: 1 has no prime factors, therefore all of its prime factors are limited to 2, 3, and 5.
Example 3:

Input: n = 14
Output: false
Explanation: 14 is not ugly since it includes the prime factor 7.


Constraints:

-231 <= n <= 231 - 1

*/

/*



*/

class A {
// Runtime: 546 ms, faster than 100.00% of Dart online submissions for Ugly Number.
// Memory Usage: 143.5 MB, less than 100.00% of Dart online submissions for Ugly Number.

  bool isUgly(int n) {
    if (n == 1)
      return true;
    else if (n <= 0) return false;
    if (n % 2 == 0) return isUgly(n ~/ 2);
    if (n % 3 == 0) return isUgly(n ~/ 3);
    if (n % 5 == 0) return isUgly(n ~/ 5);
    return false;
  }
}

class B {
  bool isUgly(int n) {
    while (n > 1) {
      if (n >= 5 && n % 5 == 0) {
        n = (n ~/ 5);
      } else if (n >= 3 && n % 3 == 0) {
        n = (n ~/ 3);
      } else if (n % 2 == 0) {
        n = (n ~/ 2);
      } else
        return false;
    }
    if (n == 1) {
      return true;
    }

    if (n <= 0) {
      return false;
    }
    return true;
  }
}

class C {
  bool isUgly(int n) {
    if (n < 1) return false;

    while (n % 2 == 0 || n % 3 == 0 || n % 5 == 0) {
      if (n % 2 == 0)
        n ~/= 2;
      else if (n % 3 == 0)
        n ~/= 3;
      else
        n ~/= 5;
    }

    if (n == 1) return true;
    return false;
  }
}

class D {
  bool isUgly(int n) {
    if (n <= 0) return false;
    if (n == 1) return true;

    while (n % 5 == 0 && n >= 5) n ~/= 5;

    while (n % 3 == 0 && n >= 3) n ~/= 3;

    while (n % 2 == 0 && n >= 2) n ~/= 2;

    // if(n==0 || n==1|| n==2 || n==3 || n==5) return true;
    if (n == 1)
      return true;
    else
      return false;
  }
}

class E {
// Runtime: 513 ms, faster than 100.00% of Dart online submissions for Ugly Number.
// Memory Usage: 143.2 MB, less than 100.00% of Dart online submissions for Ugly Number.
  bool isUgly(int n) {
    List<int> arr = [2, 3, 5];
    for (int i = 0; i < arr.length; i++) {
      while (n >= arr[i] && n % arr[i] == 0) {
        n ~/= arr[i];
      }
    }
    return n == 1;
  }
}
