/*


-* 50. Pow(x, n) *-

Implement pow(x, n), which calculates x raised to the power n (i.e., xn).

 

Example 1:

Input: x = 2.00000, n = 10
Output: 1024.00000
Example 2:

Input: x = 2.10000, n = 3
Output: 9.26100
Example 3:

Input: x = 2.00000, n = -2
Output: 0.25000
Explanation: 2-2 = 1/22 = 1/4 = 0.25
 

Constraints:

-100.0 < x < 100.0
-231 <= n <= 231-1
n is an integer.
Either x is not zero or n > 0.
-104 <= xn <= 104



*/

class A {
  double solve(double x, int n) {
    if (n == 0) {
      return 1.0; // power of 0 is 1
    }
    double temp = solve(x, n ~/ 2);
    temp = temp * temp;

    if (n % 2 == 0) {
      // if even, return just without doing anything
      return temp;
    } else {
      return temp *
          x; // if odd, return by multiplying once more with the given number
    }
  }

  double myPow(double x, int n) {
    if (x == 1) return 1;

    int longN = n;
    double ans = solve(x, longN.abs().toUnsigned(64).toInt());

    if (longN < 0) return 1 / ans;

    return ans;
  }
}

class B {
  double solve(double x, int n) {
    double ans = 1;
    while (n > 0) {
      if (n & 1 == 1) {
        ans *= x;
      }
      x *= x;
      n >>= 1;
    }
    return ans;
  }

  double myPow(double x, int n) {
    if (x == 1) {
      return 1;
    }

    int longN = n;
    double ans = solve(x, longN.abs().toUnsigned(64).toInt());

    if (longN < 0) {
      return 1 / ans;
    }
    return ans;
  }
}

class Solution {
  double myPow(double x, int n) {
    if (x == 1) {
      return 1;
    }

    if (n == 0) {
      return 1;
    }

    if (n < 0) {
      x = 1 / x;
      n = -n;
    }

    double ans = 1;
    while (n > 0) {
      if ((n & 1) == 1) {
        ans *= x;
      }
      x *= x;
      n >>= 1;
    }

    return ans;
  }
}
