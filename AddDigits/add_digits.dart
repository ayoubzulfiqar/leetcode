/*

-* Add Digits *-

Given an integer num, repeatedly add all its digits until the result has only one digit, and return it.



Example 1:

Input: num = 38
Output: 2
Explanation: The process is
38 --> 3 + 8 --> 11
11 --> 1 + 1 --> 2
Since 2 has only one digit, return it.
Example 2:

Input: num = 0
Output: 0


Constraints:

0 <= num <= 231 - 1


Follow up: Could you do it without any loop/recursion in O(1)


*/
// class Solution {
//   // The problem, widely known as digit root problem, has a congruence formula:
//   int addDigits(int num) {
//     return num % 9 == 0 && num > 0 ? 9 : num % 9;
//   }
// }

// class B {
//   int addDigits(int num) {
//     if (num == 0) return 0;
//     return num % 9 == 0 ? 9 : num % 9;
//   }
// }

// // Recursion
// class C {
//   int addDigits(int num) {
//     String s = num.toString();
//     int sum = 0;
//     for (int i = 0; i < s.length; i++) {
//       sum += s[i].codeUnitAt(0) - '0'.codeUnitAt(0);
//     }
//     if (sum > 9) return addDigits(sum);
//     return sum;
//   }
// }

// class D {
//   int addDigits(int num) {
//     int x = num;
//     int sum = 0;
//     while (x != 0) {
//       sum = sum + x % 10;
//       x = x ~/ 10;
//       if (x == 0 && sum > 9) {
//         x = sum;
//         sum = 0;
//       }
//     }
//     return sum;
//   }
// }

class A {
  // The problem, widely known as digit root problem, has a congruence formula:
  int addDigits(int num) {
    if (num == 0) return 0;
    if (num % 9 == 0) return 9;
    return num % 9;
  }
}

class B {
  int addDigits(int num) {
    while (num > 9) {
      int leftNum = num ~/ 10;
      int rightNum = num % 10;
      num = leftNum + rightNum;
    }
    return num;
  }
}

class C {
  List<int> digits(int num) {
    List<int> result = [];
    if (num == 0) {
      return [0];
    }
    while (num != 0) {
      result.add(num % 10);
      num ~/= 10;
    }
    return result;
  }

  int addDigits(int num) {
    var digitList = digits(num);
    while (digitList.length > 1) {
      int sum = 0;
      for (int d in digitList) {
        sum += d;
      }
      digitList = digits(sum);
    }
    return digitList[0];
  }
}

class D {
  int addDigits(int num) {
    int sum = 0;
    if (num == 0) {
      return 0;
    }

    while (num > 0) {
      if ((sum + num % 10) > 9) {
        sum = 1 + (sum + num % 10) % 10;
      } else
        sum += num % 10;

      num = num ~/ 10;
    }

    return sum;
  }
}
