# 🔥 Guess Number Higher or Lower 🔥 || 3 Approaches || Simple Fast and Easy || with Explanation

## Guess API

```dart
 Forward declaration of guess API.
 @param  number   your guess
 @return 	     -1 if number is higher than the picked number
			      1 if number is lower than the picked number
               otherwise return 0
```

```dart
int guess(int number) => number;
```

## Solution - 1

```dart
class Solution {
  int guessNumber(int n) {
    int low = 1;
    int high = n;
    while (low <= high) {
      int mid = low + (high - low) ~/ 2;
      int g = guess(mid);
      if (g == 0) {
        return mid;
      } else if (g == -1) {
        high = mid - 1;
      } else {
        low = mid + 1;
      }
    }
    return -1;
  }
}
```

## Solution - 2

```dart
class Solution {
  int guessNumber(int n) {
    int i = 1, mid = n ~/ 2, k, l = 0;
    if (guess(mid) == 0)
      return mid;
    else if (guess(mid) == -1) {
      k = mid;
      l = 0;
    } else
      k = n;
    l = mid;
    for (i = l; i < k; i++) {
      if (guess(i) == 0) break;
    }
    return i;
  }
}
```

## Solution - 3

```dart
class Solution {
  int guessNumber(int n) {
    return binarySearch(0, n);
  }

  int binarySearch(int start, int end) {
    if (start > end) return -1;
    int mid = start + (end - start) ~/ 2;
    switch (guess(mid)) {
      case -1:
        return binarySearch(start, mid - 1);
      case 1:
        return binarySearch(mid + 1, end);
      default:
        return mid;
    }
  }
}
```

### 😈 Disclaimer 😈 :-

This Solution is not available in DART Programing language with is a bummer. Hurts my feeling. But as a man we should implement it no matter what. We are not bunch of wussies who gonna skip it if it's not available in one language we love. Instead we will conquer the sea and rivers and cross the mountains so see what's lies beyond our horizons.

### [GitHub Link](https://github.com/ayoubzulfiqar/leetcode)
