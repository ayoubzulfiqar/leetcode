/*


* Palindrome_Number *


Given an integer x, return true if x is palindrome integer.
An integer is a palindrome when it reads the same backward as forward.
For example, 121 is a palindrome while 123 is not.


Example 1:

Input: x = 121
Output: true
Explanation: 121 reads as 121 from left to right and from right to left.


Example 2:

Input: x = -121
Output: false
Explanation: From left to right, it reads -121. From right to left, it becomes 121-.
Therefore it is not a palindrome.


Example 3:

Input: x = 10
Output: false
Explanation: Reads 01 from right to left. Therefore it is not a palindrome.



Constraints:

-231 <= x <= 231 - 1
Follow up:- Could you solve it without converting the integer to a string?

 */

import 'dart:math';

void main() {
  // final a = B();
  // final ab = a.isPalindrome(121);
  // final ac = a.isPalindrome(1580990851);
  // final ad = a.isPalindrome(10001);
  // print(ad);
  // print(ab);
  // print(ac);

  // final b = B();

  // final ab = b.isPalindrome(121);
  // print(ab);

  // final c = C();
  // final ac = c.isPalindrome(10);
  // print(ac);

  // final d = D();
  // final ad = d.isPalindrome(10);
  // print(ad);
  // final f = F();
  // final fd = f.isPalindrome(10);
  // print(fd);

  // final g = G();
  // final gd = g.isPalindrome(10);
  // print(gd);

  // final h = H();
  // final ha = h.isPalindrome(10);
  // print(ha);
  final i = I();
  final ia = i.isPalindrome(1000030001);
  print(ia);
}

class A {
  bool isPalindrome(int x) {
    // the condition because we don't want negative number
    if (x < 0) {
      // so if the number is less than 0 it will always be zero less than zero is negative
      return false;
    }

    double divisor = 1;

    // in this case we are dividing the input value with digit one
    // to see if the the entered value is less then 10 or greater than 10
    while (x / divisor >= 10) {
      // if it is greater than 10 than we multiply with 10 and change the divisor value
      divisor *= 10;
    }
    //  if the entered x value is not zero
    while (x != 0) {
      // than
      // we will divide entered value with the updated value of divisor
      // truncate:- if answer is 1.00001 than it will turn into 1,
      // it should not be equal to reminder of entered value divided by 10 and floor convert the double to int
      if ((x / divisor).truncate() != (x % 10).floor()) {
        // if all this condition is true  than return false
        return false;
      }

      // OR x = x % divisor;
      x %= divisor.toInt();
      // floor to convert the value to int
      x = (x / 10).floor();

      // OR divisor = divisor / 100;
      divisor /= 100;
    }

    return true;
  }
}

class B {
  // My favorite short and simple
  bool isPalindrome(int x) {
    // if entered value is less than zero and
    // reminder of entered value is 0 by 10
    // AND entered value is not zero
    if (x < 0 || (x % 10 == 0 && x != 0)) {
      // return false
      return false;
    }

    // initial value of the revision number
    int revNum = 0;
    // if the entered value is greater than revision number
    while (x > revNum) {
      // than we will update the value of the revision number
      // Please:- learn about modulo operator %
      revNum = revNum * 10 + x % 10;

      // floor:- convert the double into int
      x = (x / 10).floor();
    }
    // if upper x value is equal to revision number or revision number is divide able by 10
    //than all is well and true
    return (x == revNum || x == revNum / 10);
  }
}

class C {
  bool isPalindrome(int x) {
    if (x < 0) {
      return false;
    }
    int y = 0;
    int xx = x;

    if (xx > 0) {
      y = y * 10 + xx % 10;
      xx = (xx / 10).floor();
    }
    return (y != x);
  }

  // while (xx > 0) {
  //   y = y * 10 + xx % 10;
  //   xx = (xx / 10).floor();
  // }
}

class D {
  bool isPalindrome(int x) {
    if (x.isNegative) return false;
    final list = convert(x);
    for (var i = 0; i < (list.length ~/ 2); i++) {
      if (list[i] != list[list.length - 1 - i]) return false;
    }
    return true;
  }

  List convert(int x) {
    final List<int> list = <int>[];

    while (x > 0) {
      list.add(x % 10);
      x = x ~/ 10;
    }
    return list;
  }
}

class F {
  bool isPalindrome(int x) {
    if (x.isNegative) return false;
    if (x == 0) return true;
    if (x % 10 == 0) return false;

    var reverted = 0, iter = x;
    while (iter > 0) {
      reverted = reverted * 10;
      reverted += iter % 10;
      iter = iter ~/ 10;
    }

    return reverted == x;
  }
}

class G {
  bool isPalindrome(int x) {
    if (x.isNegative) return false;

    var tens = 10;
    while (tens < x) tens *= 10;
    tens = tens ~/ 10;

    while (x > 10) {
      var lastDigit = x % 10;
      var firstDigit = x ~/ tens;

      if (lastDigit != firstDigit) return false;

      x -= firstDigit * tens;
      x = x ~/ 10;
      tens = tens ~/ 100;
    }

    return true;
  }
}

class H {
  // String method

  bool isPalindrome(int x) {
// basically taking the input value converting into string than
// splitting the string one by one and revering it and converting into list and joint it
// so we get the reverse value of the entered value

    final reverse = x.toString().split("").reversed.toList().join();

// now if the entered value is same as reversed value than true
//of course we have to convert the String into int because entered value is x is int
    return x == int.tryParse(reverse);
  }
}

class I {
  bool isPalindrome(int x) {
    if (x < 0) return false;

    if (x == 0) return true;

    if (x % 10 == 0) return false;

    final digits = (log(x) * log10e).floor();

    for (var pos = 0; pos <= digits ~/ 2; pos++) {
      if (getDigitAt(x, pos) != getDigitAt(x, digits - pos)) {
        return false;
      }
    }
    return true;
  }

  int getDigitAt(int number, int pos) => (number ~/ pow(10, pos)) % 10;
}

class J {
  bool isPalindrome(int x) {
    if (x < 0) return false;
    if (x < 10) return true;
    var s = x.toString();
    for (var i = 0, j = s.length - 1; i < j; i++, j--) {
      if (s.codeUnitAt(i) != s.codeUnitAt(j)) return false;
    }
    return true;
  }
}

class K {
  bool isPalindrome(int x) {
    if (x < 0) return false;
    if (x < 10) return true;
    int r = 0;
    do {
      var d = x.remainder(10);
      x = x ~/ 10;
      if (r == x) return true; // Odd length number
      r = r * 10 + d;
      if (r == x) return true; // Even length number
      if (r == 0) return false; // Trailing zero
    } while (r < x);
    return false;
  }
}

class L {
  // Minimize divisions by dividing by 100, and do lookup for the digits.
  static const digits = [
    0,
    0,
    0,
    1,
    0,
    2,
    0,
    3,
    0,
    4,
    0,
    5,
    0,
    6,
    0,
    7,
    0,
    8,
    0,
    9,
    1,
    0,
    1,
    1,
    1,
    2,
    1,
    3,
    1,
    4,
    1,
    5,
    1,
    6,
    1,
    7,
    1,
    8,
    1,
    9,
    2,
    0,
    2,
    1,
    2,
    2,
    2,
    3,
    2,
    4,
    2,
    5,
    2,
    6,
    2,
    7,
    2,
    8,
    2,
    9,
    3,
    0,
    3,
    1,
    3,
    2,
    3,
    3,
    3,
    4,
    3,
    5,
    3,
    6,
    3,
    7,
    3,
    8,
    3,
    9,
    4,
    0,
    4,
    1,
    4,
    2,
    4,
    3,
    4,
    4,
    4,
    5,
    4,
    6,
    4,
    7,
    4,
    8,
    4,
    9,
    5,
    0,
    5,
    1,
    5,
    2,
    5,
    3,
    5,
    4,
    5,
    5,
    5,
    6,
    5,
    7,
    5,
    8,
    5,
    9,
    6,
    0,
    6,
    1,
    6,
    2,
    6,
    3,
    6,
    4,
    6,
    5,
    6,
    6,
    6,
    7,
    6,
    8,
    6,
    9,
    7,
    0,
    7,
    1,
    7,
    2,
    7,
    3,
    7,
    4,
    7,
    5,
    7,
    6,
    7,
    7,
    7,
    8,
    7,
    9,
    8,
    0,
    8,
    1,
    8,
    2,
    8,
    3,
    8,
    4,
    8,
    5,
    8,
    6,
    8,
    7,
    8,
    8,
    8,
    9,
    9,
    0,
    9,
    1,
    9,
    2,
    9,
    3,
    9,
    4,
    9,
    5,
    9,
    6,
    9,
    7,
    9,
    8,
    9,
    9,
  ];
  bool isPalindrome(int x) {
    if (x < 0) return false;
    if (x < 10) return true;
    int r = 0;
    do {
      var d = x.remainder(100);
      x = x ~/ 100;
      var d1 = digits[d * 2];
      var d2 = digits[d * 2 + 1];
      if (r == x && d1 == d2) return true; // Even length number
      if (r == x * 10 + d1) return true; // Odd length number.
      r = r * 10 + d2;
      if (r == 0) return false; // Trailing zero
      if (r == x) return true; // Odd length number
      r = r * 10 + d1;
      if (r == x) return true; // Even length number
    } while (r < x);
    return false;
  }
}

class O {
  bool isPalindrome(int x) {
    if (x < 0 || (x != 0 && x % 10 == 0)) return false;
    int rev = 0;
    while (x > rev) {
      rev = rev * 10 + x % 10;
      x = (x / 10).floor();
    }
    return (x == rev || x == rev / 10);
  }
}
