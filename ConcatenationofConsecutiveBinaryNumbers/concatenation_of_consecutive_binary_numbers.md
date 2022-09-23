# 🔥 Dart 🔥 || 5 solution || line by line explanation

## Warning:-

At the time of writing this solution You can't submit on leetcode because there is not option for `Dart` But i did my best to implement it in `DART` because in future if leetcode support dart for this specific solution than things will workout for us `HOPE SO`

### Solution - 1 Bit Manipulation

```dart
class Solution {
  int concatenatedBinary(int n) {
    int mod = (1e9 + 7).toInt();
    int res = 0;
    for (int i = 1; i <= n; i++) {
      int bitLen = (log(i) ~/ log(2)) + 1;
      res = ((res << bitLen) + i) % mod;
    }
    return res;
  }
}
```

### Solution 3 -

```dart
class Solution {
  int concatenatedBinary(int n) {
    int res = 0;
    int bitLength = 1;
    int nextIncrease = 2;

    for (int i = 1; i <= n; i++) {
      if (i == nextIncrease) {
        nextIncrease *= 2;
        bitLength++;
      }

      res = (res << bitLength) | i;
      res %= 1000000007;
    }

    return res;
  }
}
```

### Solution - 3

```dart
class Solution {
  int concatenatedBinary(int n) {
    int sum = 0;
    for (int i = 1; i <= n; i++) {
      String binary = i.toRadixString(2);
      sum = ((sum << binary.length) + i) % 1000000007;
    }
    return sum;
  }
}
```

### Solution - 4 Math

```dart
class Solution {
  int concatenatedBinary(int n) {
    final int modulo = (1e9 + 7).toInt();
    int result = 0;
    for (int i = 1; i <= n; i++) {
      // For each i, we shift left the position of result with * 2,
      // while shifting right the position of i with / 2.
      int temp = i;
      while (temp > 0) {
        temp ~/= 2;
        result *= 2;
      }
      // Add the i to the result and get the remainder of modulo.
      result = (result + i) % modulo;
    }
    return result;
  }
}
```

### Solution - 5

```dart
class Solution {
  int concatenatedBinary(int n) {
    int digits = 0, MOD = 1000000007;
    int result = 0;
    for (int i = 1; i <= n; i++) {
      /* if "i" is a power of 2, then we have one additional digit in
      its the binary equivalent compared to that of i-1 */
      if ((i & (i - 1)) == 0) digits++;
      result = ((result << digits) + i) % MOD;
    }

    return result;
  }
}
```
