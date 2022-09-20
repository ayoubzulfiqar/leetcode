# ✅ Dart | 4 Solutions | Sqrt(x)

## Solution - 1  Algorithmic Solution

```dart
class A {
// Runtime: 679 ms, faster than 43.75% of Dart online submissions for Sqrt(x).
// Memory Usage: 158.8 MB, less than 6.25% of Dart online submissions for Sqrt(x).
  int mySqrt(int x) {
    int binarySearch(int x) {
      int left = 1, right = x ~/ 2, mid, ans = 0;
      var temp;
      while (left <= right) {
        mid = (left + (right - left) ~/ 2);
        temp = mid * mid;
        //mid * mid can be large, so use long
        if (temp == x) return mid;
        if (temp < x) {
          ans = mid;
          left = mid + 1;
        } else
          right = mid - 1;
      }
      return ans;
    }

    if (x <= 1) return x;
    return binarySearch(x);
  }
}
```

## Solution - 2 Using While-loop

```dart
class B {
// Runtime: 812 ms, faster than 9.38% of Dart online submissions for Sqrt(x).
// Memory Usage: 149 MB, less than 37.50% of Dart online submissions for Sqrt(x).
  int mySqrt(int x) {
    int result = 0, i = 1;
    while (x >= 0) {
      x = x - i;
      result++;
      i += 2;
    }
    return result - 1;
  }
}
```

## Solution - 3 Binary Search Solution - TC O(log n) | 100% Faster

```dart
class C {
// Runtime: 661 ms, faster than 50.00% of Dart online submissions for Sqrt(x).
// Memory Usage: 141.8 MB, less than 96.88% of Dart online submissions for Sqrt(x).

  int mySqrt(int x) {
    if (x == 1 || x == 0) return x;

    int low = 1, high = x ~/ 2;

    while (low <= high) {
      var mid = low + (high - low) ~/ 2;

      if (mid * mid == x) {
        return mid;
      } else if (mid * mid > x) {
        high = mid - 1;
      } else {
        low = mid + 1;
      }
    }

    return high;
  }
}
```

## Solution - 4 Simple

```dart
class D {
// Runtime: 722 ms, faster than 21.88% of Dart online submissions for Sqrt(x).
// Memory Usage: 150 MB, less than 15.63% of Dart online submissions for Sqrt(x).

  int mySqrt(int x) {
    int i = 1;
    while (i * i <= x) {
      i++;
    }
    return i - 1;
  }
}
```
