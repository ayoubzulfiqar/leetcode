/*


-* 415. Add Strings *-

Given two non-negative integers, num1 and num2 represented as string, return the sum of num1 and num2 as a string.

You must solve the problem without using any built-in library for handling large integers (such as BigInteger). You must also not convert the inputs to integers directly.

 

Example 1:

Input: num1 = "11", num2 = "123"
Output: "134"
Example 2:

Input: num1 = "456", num2 = "77"
Output: "533"
Example 3:

Input: num1 = "0", num2 = "0"
Output: "0"
 

Constraints:

1 <= num1.length, num2.length <= 104
num1 and num2 consist of only digits.
num1 and num2 don't have any leading zeros except for the zero itself.


*/
class A {
  String addStrings(String num1, String num2) {
    final StringBuffer sb = StringBuffer();

    int i = num1.length - 1;
    int j = num2.length - 1;
    int carry = 0;

    while (i >= 0 || j >= 0) {
      int sum = carry;

      if (i >= 0) sum += (num1.codeUnitAt(i--) - '0'.codeUnitAt(0));
      if (j >= 0) sum += (num2.codeUnitAt(j--) - '0'.codeUnitAt(0));

      sb.write(sum % 10);
      carry = sum ~/ 10;
    }

    if (carry != 0) sb.write(carry);
    return sb.toString().split('').reversed.join();
  }
}

class B {
  String addStrings(String num1, String num2) {
    int carry = 0;
    int i = num1.length - 1;
    int j = num2.length - 1;
    String ans = "";

    String addString(String s1, String s2, int i, int j, int c, String ans) {
      if (c == 0 && i < 0 && j < 0) {
        return ans.split('').reversed.join();
      }

      if (i >= 0) {
        c += int.parse(s1[i]);
        i--;
      }

      if (j >= 0) {
        c += int.parse(s2[j]);
        j--;
      }

      ans += String.fromCharCode(c % 10 + '0'.codeUnitAt(0));
      c = c ~/ 10;

      return addString(s1, s2, i, j, c, ans);
    }

    return addString(num1, num2, i, j, carry, ans);
  }
}

class C {
  String addStrings(String num1, String num2) {
    BigInt bigIntNum1 = BigInt.parse(num1);
    BigInt bigIntNum2 = BigInt.parse(num2);

    BigInt sum = bigIntNum1 + bigIntNum2;

    return sum.toString();
  }
}
