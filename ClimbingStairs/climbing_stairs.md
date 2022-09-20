# [Dart] 6 Approaches | Recursion - Memoization - Tabulation - Mathematical - Memoization (100% Faster)

## Algorithmic

```dart
class Algorithmic {
  int climbStairs(int n) {
    if (n == 0 || n == 1 || n == 2 || n == 3) {
      return n;
    }
    int sum = 0;
    int left = 1;
    int right = 2;
    for (int i = 2; i < n; i++) {
      sum = left + right;
      left = right;
      right = sum;
    }
    return sum;
  }
}
```

## Recursive

```dart
class Recursive {
  int climbStairs(int n) {
    //handle invalid cases
    if (n < 0) return 0;
    //base case 1: if reached 0 or 1-> 1
    if (n == 0 || n == 1) return 1;
    //the current position will be the sum of the last two ones
    return climbStairs(n - 1) + climbStairs(n - 2);
  }
}
```

## Mathematical

```dart
class Mathematical {
// Runtime: 306 ms, faster than 97.73% of Dart online submissions for Climbing Stairs.
// Memory Usage: 155.3 MB, less than 13.64% of Dart online submissions for Climbing Stairs.

  int climbStairs(int n) {
    return ((1 / sqrt(5.0)) *
            (pow((1 + sqrt(5)) / 2, n + 1) - pow((1 - sqrt(5)) / 2, n + 1)))
        .toInt();
  }
}
```

## Memory Efficient Tabulation

```dart
class MemoryEfficientTabulation {
  //  Memory Efficient Tabulation
//   Runtime: 452 ms, faster than 43.18% of Dart online submissions for Climbing Stairs.
// Memory Usage: 140.2 MB, less than 79.55% of Dart online submissions for Climbing Stairs.
  int climbStairs(int n) {
    int stair1 = 1;
    int stair2 = 1;

    for (int i = 2; i <= n; i++) {
      int stair = stair1 + stair2;
      stair1 = stair2;
      stair2 = stair;
    }

    return stair2;
  }
}
```

## Tabulation

```dart
class Tabulation {
// Runtime: 484 ms, faster than 31.82% of Dart online submissions for Climbing Stairs.
// Memory Usage: 140.3 MB, less than 70.45% of Dart online submissions for Climbing Stairs.

  int climbStairs(int n) {
    //initialize two variables base cases
    int one = 1, two = 1;
    //loop until reaching the given number
    for (int i = 2; i <= n; i++) {
      //save the one value in temp variable
      int temp = one;
      //update the one value by adding the last one and current two values
      one += two;
      //update the two value by the old one variable value
      two = temp;
    }
    //return the last reached value
    return one;
  }
}
```

## Memoization

```dart
  class Memoization {
  int stairs(int n, List<int> stair) {
    if (n <= 1) {
      stair[n] = 1;
      return 1;
    }

    if (stair[n] != -1) {
      return stair[n];
    }

    int one = stairs(n - 1, stair);
    int two = stairs(n - 2, stair);

    stair[n] = one + two;

    return one + two;
  }

  int climbStairs(int n) {
    List<int> stair = [n + 1, -1];
    stairs(n, stair);
    return stair[n];
  }
}
```
