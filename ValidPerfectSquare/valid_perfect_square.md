# 🔥 Valid Perfect Square 🔥 || 5 Approaches || Simple Fast and Easy || with Explanation

## Solution - 1 Using Math Sqrt

```dart
class Solution {
  bool isPerfectSquare(int num) {
    double n = sqrt(num);
    if (n ~/ n == 1) return true;
    return false;
  }
}
```

## Solution - 2 Binary search Algorithm

```dart
class Solution {
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
```

## Solution - 3

```dart
class Solution {
  bool isPerfectSquare(int num) {
    for (int i = 1; num > 0; i += 2) num -= i;
    return num == 0;
  }
}
```

## Solution - 4 Using Newton-Raphson method : X+1 = 1/2 [ Xn + a / Xn ]

```dart
class Solution {
  bool isPerfectSquare(int num) {
    int temp = num;
    while (temp * temp > num) temp = (temp + num ~/ temp) ~/ 2;
    return temp * temp == num;
  }
}
```

## Solution - 5

```dart
class Solution {
  bool isPerfectSquare(int num) {
    int i = 1;
    while (num > 0) {
      num -= i;
      i += 2; // The  1 + 3 + 5 + 7 + 9 +......pattern.
    }
    return num == 0;
  }
}
```
