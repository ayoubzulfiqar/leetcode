# 🔥 Add Digits 🔥 || 5 Solutions || Simple Fast and Easy

## The problem, widely known as digit root problem, has a congruence formula

## Solution - 1 Mathematical Congruence Formula

```dart
class Solution {
  int addDigits(int num) {
    if (num == 0) return 0;
    if (num % 9 == 0) return 9;
    return num % 9;
  }
}
```

## Solution - 2 Two Pointers

```dart
class Solution {
  int addDigits(int num) {
    while (num > 9) {
      int leftNum = num ~/ 10;
      int rightNum = num % 10;
      num = leftNum + rightNum;
    }
    return num;
  }
}
```

## Solution - 3 Using Array

```dart
class Solution {
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
```

## Solution - 4

```dart
class Solution {
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
```

## Solution - 5 Recursion

```dart
class Solution {
  int addDigits(int num) {
    String s = num.toString();
    int sum = 0;
    for (int i = 0; i < s.length; i++) {
      sum += s[i].codeUnitAt(0) - '0'.codeUnitAt(0);
    }
    if (sum > 9) return addDigits(sum);
    return sum;
  }
}
```
