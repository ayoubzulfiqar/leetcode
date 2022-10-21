# 🔥 Ugly Number 🔥 || 5 Solutions || Simple Fast and Easy || with Explanation

## Approach

- Loop for all positive integers till the ugly number count is smaller than n, if an integer is ugly than increment ugly number count.
- To check if a number is ugly, divide the number by greatest divisible powers of 2, 3 and 5, if the number becomes 1 then it is an ugly number otherwise not.

- For example, let us see how to check for 300 is ugly or not. Greatest divisible power of 2 is 4, after dividing 300 by 4 we get 75. Greatest divisible power of 3 is 3, after dividing 75 by 3 we get 25. Greatest divisible power of 5 is 25, after dividing 25 by 25 we get 1. Since we get 1 finally, 300 is ugly number.

## Solution - 1

```dart
class Solution {
// Runtime: 546 ms, faster than 100.00% of Dart online submissions for Ugly Number.
// Memory Usage: 143.5 MB, less than 100.00% of Dart online submissions for Ugly Number.

  bool isUgly(int n) {
    if (n == 1)
      return true;
    else if (n <= 0) return false;
    if (n % 2 == 0) return isUgly(n ~/ 2);
    if (n % 3 == 0) return isUgly(n ~/ 3);
    if (n % 5 == 0) return isUgly(n ~/ 5);
    return false;
  }
}
```

## Solution - 2

```dart
class Solution {
  bool isUgly(int n) {
    while (n > 1) {
      if (n >= 5 && n % 5 == 0) {
        n = (n ~/ 5);
      } else if (n >= 3 && n % 3 == 0) {
        n = (n ~/ 3);
      } else if (n % 2 == 0) {
        n = (n ~/ 2);
      } else
        return false;
    }
    if (n == 1) {
      return true;
    }

    if (n <= 0) {
      return false;
    }
    return true;
  }
}
```

## Solution - 3

```dart
class Solution {
  bool isUgly(int n) {
    if (n < 1) return false;

    while (n % 2 == 0 || n % 3 == 0 || n % 5 == 0) {
      if (n % 2 == 0)
        n ~/= 2;
      else if (n % 3 == 0)
        n ~/= 3;
      else
        n ~/= 5;
    }

    if (n == 1) return true;
    return false;
  }
}
```

## Solution - 4

```dart
class Solution {
  bool isUgly(int n) {
    if (n <= 0) return false;
    if (n == 1) return true;

    while (n % 5 == 0 && n >= 5) n ~/= 5;

    while (n % 3 == 0 && n >= 3) n ~/= 3;

    while (n % 2 == 0 && n >= 2) n ~/= 2;

    // if(n==0 || n==1|| n==2 || n==3 || n==5) return true;
    if (n == 1)
      return true;
    else
      return false;
  }
}
```

## Solution - 5

```dart
class Solution {
// Runtime: 513 ms, faster than 100.00% of Dart online submissions for Ugly Number.
// Memory Usage: 143.2 MB, less than 100.00% of Dart online submissions for Ugly Number.
  bool isUgly(int n) {
    List<int> arr = [2, 3, 5];
    for (int i = 0; i < arr.length; i++) {
      while (n >= arr[i] && n % arr[i] == 0) {
        n ~/= arr[i];
      }
    }
    return n == 1;
  }
}
```
