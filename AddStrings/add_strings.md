# 🔥 Add Strings 🔥 || Simple Fast and Easy || with Explanation 😈

## Solution - 1

```dart
class Solution {
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
```

## Solution - 2

```dart
class Solution {
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
```

## Solution - 3

```dart
class Solution {
  String addStrings(String num1, String num2) {
    BigInt bigIntNum1 = BigInt.parse(num1);
    BigInt bigIntNum2 = BigInt.parse(num2);

    BigInt sum = bigIntNum1 + bigIntNum2;

    return sum.toString();
  }
}
```
