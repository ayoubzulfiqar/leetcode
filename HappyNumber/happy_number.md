# 🔥 Happy Number 🔥 || 5 Solutions || Simple Fast and Easy || with Explanation

## Solution - 1

### Complexity Analysis

- Time Complexity: O(n*log(n)).
- Auxiliary Space: O(1).

```dart
class Solution {
// Runtime: 559 ms, faster than 36.59% of Dart online submissions for Happy Number.
// Memory Usage: 140.6 MB, less than 95.12% of Dart online submissions for Happy Number.

  bool isHappy(int n) {
    int slow, fast;
    //  initialize slow and fast by n
    slow = fast = n;
    do {
      //  move slow number
      // by one iteration
      slow = numSquareSum(slow);
      //  move fast number
      // by two iteration
      fast = numSquareSum(numSquareSum(fast));
    } while (slow != fast);
    return (slow == 1);
  }
  // Utility method to return sum of square of
// digit of n
  int numSquareSum(int n) {
    int sumSquare = 0;
    while (n != 0) {
      sumSquare += (n % 10) * (n % 10);
      n ~/= 10;
    }
    return sumSquare;
  }
```

## Solution - 2

### Complexity-Analysis

- Time Complexity: O(n*log(n)).
- Auxiliary Space: O(n) since using extra set for storage

```dart
class Solution {
// Runtime: 536 ms, faster than 53.66% of Dart online submissions for Happy Number.
// Memory Usage: 143.7 MB, less than 29.27% of Dart online submissions for Happy Number.

  bool isHappy(int n) {
    HashSet hs = HashSet();
    while (true) {
      n = numSquareSum(n);
      if (n == 1) return true;
      if (hs.contains(n)) return false;
      hs.add(n);
    }
  }

  int numSquareSum(int n) {
    int sumSquare = 0;
    while (n != 0) {
      sumSquare += (n % 10) * (n % 10);
      n ~/= 10;
    }
    return sumSquare;
  }
}
```

## Solution - 3

```dart
class Solution {
// Runtime: 484 ms, faster than 78.05% of Dart online submissions for Happy Number.
// Memory Usage: 140.6 MB, less than 95.12% of Dart online submissions for Happy Number.

  bool isHappy(int n) {
    if (n == 1 || n == 7) return true;
    int sum = n, x = n;

    // this loop executes till the sum of square of
    // digits obtained is not a single digit number
    while (sum > 9) {
      sum = 0;

      // this loop finds the sum of square of digits
      while (x > 0) {
        int d = x % 10;
        sum += d * d;
        x ~/= 10;
      }
      if (sum == 1) return true;
      x = sum;
    }
    if (sum == 7) return true;
    return false;
  }
}
```

## Solution - 4

```dart
class Solution {
// Runtime: 261 ms, faster than 100.00% of Dart online submissions for Happy Number.
// Memory Usage: 139.3 MB, less than 100.00% of Dart online submissions for Happy Number.
  /// > It takes a number, adds the squares of its digits, and returns the result
  ///
  /// Args:
  ///   n (int): The number to be checked.
  ///
  /// Returns:
  ///   The sum of the squares of the digits of the number.
  int solve(int n) {
    int sum = 0;
    for (int i = 0; n != 0; i++) {
      int r = n % 10;
      sum = sum + r * r;
      n = n ~/ 10;
    }

    return sum;
  }

  bool isHappy(int n) {
    int i = 10;

    /// A loop that checks if the number is happy.
    while (i > 0) {
      int happy = solve(n);
      if (happy == 1) {
        return true;
      }
      n = happy;
      i--;
    }
    return false;
  }
}
```

## SOlution 5

```dart
class Solution {
// Runtime: 309 ms, faster than 100.00% of Dart online submissions for Happy Number.
// Memory Usage: 158 MB, less than 7.32% of Dart online submissions for Happy Number.
  int sums(int n) {
    int ans = 0;
    while (n != 0) {
      //ans += pow(n % 10, 2);
      ans += pow(n % 10, 2).floor();
      n = n ~/ 10;
    }
    return ans;
  }

  bool isHappy(int n) {
    int s = sums(n);
    int f = sums(sums(n));
    if (f == 1) return true; //for case n==1
    while (s != f) {
      if (f == 1) return true;
      s = sums(s);
      f = sums(sums(f));
    }
    return false;
  }
}

```
