# 🔥 Nim Game 🔥 || || 3 Approaches Simple Fast and Easy || with Explanation

## Solution - 1

```dart
class Solution {
  bool canWinNim(int n) {
    // if the remainder is not 0 because if there is remainder than nim will win
    return n % 4 != 0;
  }
}
```

## Solution - 2 Recursive

```dart
class Solution {
  bool canWinNim(int n) {
    // if the number is less than zero or equal nothing to do here
    if (n <= 0) return false;
    // because we can pick 0-3 pick one time  so true
    if (n == 1 || n == 2 || n == 3) return true;
    // recursive to see after picking 0,1,2,3 if there is something left we lost
    if (canWinNim(n - 1) && canWinNim(n - 2) && canWinNim(n - 3)) return false;
    return true;
  }
}
```

## Solution - 3

```dart
class Solution {
  bool canWinNim(int n) {
    if (n >= 134882061) return n % 4 != 0;
    bool result = true;
    bool first = true;
    bool second = true;
    bool third = true;
    for (int i = 4; i <= n; i++) {
      result = (first && second && third) ? false : true;
      first = second;
      second = third;
      third = result;
    }
    return result;
  }
}
```
