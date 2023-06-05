# 🔥 3 Solutions 🔥 || Simple Fast and Easy || with Explanation

## Solution -1

```dart
class Solution {
  bool checkStraightLine(List<List<int>> coordinates) {
    int dx = coordinates[1][1] - coordinates[0][1];
    int dy = coordinates[1][0] - coordinates[0][0];
    for (int i = 2; i < coordinates.length; i++) {
      if (dx * (coordinates[i][0] - coordinates[1][0]) !=
          dy * (coordinates[i][1] - coordinates[1][1])) {
        return false;
      }
    }
    return true;
  }
}
```

## Solution - 2

```dart
class Solution {
  bool checkStraightLine(List<List<int>> coordinates) {
    int x0 = coordinates[0][0];
    int y0 = coordinates[0][1];
    int x1 = coordinates[1][0];
    int y1 = coordinates[1][1];
    for (List<int> point in coordinates) {
      int x = point[0];
      int y = point[1];
      if ((x - x0) * (y1 - y0) != (y - y0) * (x1 - x0)) return false;
    }

    return true;
  }
}
```

## Solution - 3

```dart
class Solution {
  bool checkStraightLine(List<List<int>> coordinates) {
    double slope;
    double c;

    if (coordinates[1][0] == coordinates[0][0]) {
      slope = double.infinity;
      c = coordinates[0][1].toDouble() - slope * coordinates[0][0].toDouble();
      for (int i = 2; i < coordinates.length; i++) {
        if (coordinates[i][0] != coordinates[0][0]) {
          return false;
        }
      }
      return true;
    }

    slope = (coordinates[1][1] - coordinates[0][1]).toDouble() /
        (coordinates[1][0] - coordinates[0][0]).toDouble();
    c = coordinates[0][1].toDouble() - slope * coordinates[0][0].toDouble();

    for (int i = 2; i < coordinates.length; i++) {
      if (coordinates[i][1] - slope * coordinates[i][0] != c) {
        return false;
      }
    }

    return true;
  }
}
```

### Disclaimer:-

This Solution is not available in DART Programming language with is a bummer.
Hurts my feeling. But as a man we should implement it no matter what.
We are not bunch of wussies who gonna skip it if it's not available in one language we love.
Instead we will conquer the sea and rivers and cross the mountains so see what's lies beyond our horizons.

### [GitHub Link](https://github.com/ayoubzulfiqar/leetcode)
