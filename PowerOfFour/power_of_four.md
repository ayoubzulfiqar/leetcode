# 🔥 Power of Four 🔥 || 4  Approaches || Simple Fast and Easy || with Explanation

## Solution - 1

```dart
class Solution {
  bool isPowerOfFour(int n) {
    if (n <= 0) return false;
    while (n % 3 == 0) {
      n ~/= 3;
    }
    return n == 1;
  }
}
```

## Solution - 2

```dart
class Solution {
  bool isPowerOfFour(int n) {
    if (n <= 1) return n == 1;
    return n % 4 == 0 && isPowerOfFour(n ~/ 4);
  }
}
```

## Solution - 3

```dart
class Solution {
  bool isPowerOfFour(int n) {
    return (log(n) / log(4)) % 1 == 0;
  }
}
```

## Solution - 4

```dart
class Solution {
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
```
