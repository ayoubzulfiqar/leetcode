# 🔥 6 Approaches 🔥 || Simple Fast and Easy || with Explanation

## Intuition

we will calculate all odd number from 1 to low-1 and 1 to high;
why low-1??
because we want include our low value.

## Approach

Total odd number between 1 and low - 1 is low/2.
Total odd number between 1 and high is (high + 1 ) / 2.
For getting answer we will do
Total odd number between 1 and high - Total odd number between 1 and low - 1

## Complexity

### - Time complexity:O(1)

### - Space complexity:O(1)

## Code -1

```dart
class Solution {
  int countOdds(int high, int low) {
    return ((high + 1) ~/ 2) - (low ~/ 2);
  }
}
```

## Code -2

```dart
class Solution {
  int countOdds(int high, int low) {
    if ((high & 1) == 0) high--;
    return (low > high) ? 0 : (high + 1) ~/ 2 - (low ~/ 2);
  }
}
```

## Code -3

```dart
class Solution {
  int countOdds(int high, int low) {
    int total = high - low + 1;
    if (total % 2 == 0)
      return total ~/ 2;
    else {
      if (low % 2 != 0)
        return total ~/ 2 + 1;
      else
        return total ~/ 2;
    }
  }
}
```

## Code -4

```dart
class Solution {
  int countOdds(int low, int high) {
    if (low % 2 == 0 && high % 2 == 0)
      return (high - low) ~/ 2;
    else {
      int firstOddNumber = low % 2 == 0 ? low + 1 : low;
      return (high - firstOddNumber) ~/ 2 + 1;
    }
  }
}
```

## Code -5

```dart
class Solution {
  int countOdds(int high, int low) {
    int count = 0;
    for (int i = low; i <= high; i++) {
      if (i % 2 != 0) count++;
    }
    return count;
  }
}
```

## Code -6

```dart
class Solution {
  int countOdds(int low, int high) {
    if (low % 2 == 0 && high % 2 == 0) {
      return (high - low) ~/ 2;
    } else if (low % 2 != 0 && high % 2 != 0) {
      return 2 + (high - low) ~/ 2 - 1;
    } else {
      return 1 + (high - low) ~/ 2;
    }
  }
}
```
