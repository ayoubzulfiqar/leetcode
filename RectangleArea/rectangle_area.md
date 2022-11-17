# 🔥 Rectangle Area 🔥 || 4 Approaches || Simple Fast and Easy || with Explanation

## Solution - 1

```dart
class Solution {
  int computeArea(
      int ax1, int ay1, int ax2, int ay2, int bx1, int by1, int bx2, int by2) {
    // Calculating Area Of A and B
    int areaA = (ax2 - ax1) * (ay2 - ay1);
    int areaB = (bx2 - bx1) * (by2 - by1);

    // Calculating The Left Boundary
    int leftBoundary = max(ax1, bx1);

    // Calculating The Right Boundary
    int rightBoundary = min(bx2, ax2);

    // Calculating The Up Boundary
    int upperBoundary = min(by2, ay2);

    // Calculating The Down Boundary
    int lowerBoundary = max(ay1, by1);

    // Total Area
    int totalArea = areaA + areaB;

    // If Both Rectangle Overlaps
    if (rightBoundary > leftBoundary && upperBoundary > lowerBoundary)
      totalArea -=
          ((rightBoundary - leftBoundary) * (upperBoundary - lowerBoundary));

    return totalArea;
  }
}
```

## Solution - 2

```dart
class Solution {
  int computeArea(
      int ax1, int ay1, int ax2, int ay2, int bx1, int by1, int bx2, int by2) {
    int a = (ax2 - ax1) * (ay2 - ay1);
    int b = (bx2 - bx1) * (by2 - by1);

    if (ax1 >= bx2 || ax2 <= bx1 || ay2 <= by1 || ay1 >= by2) return a + b;

    return (a +
            b -
            (min(bx2, ax2) - max(ax1, bx1)) * (min(ay2, by2) - max(ay1, by1)))
        .toInt();
  }
}
```

## Solution - 3

```dart
class Solution {
  int computeArea(
      int ax1, int ay1, int ax2, int ay2, int bx1, int by1, int bx2, int by2) {
    if (ax1 <= bx1 && ay1 <= by1 && ax2 >= bx2 && ay2 >= by2)
      return (ax2 - ax1) * (ay2 - ay1);
    if (ax1 >= bx1 && ay1 >= by1 && ax2 <= bx2 && ay2 <= by2)
      return (bx2 - bx1) * (by2 - by1);
    if (ax1 >= bx1 && ax2 <= bx2 && ay2 >= by2 && ay1 <= by1)
      return (ax2 - ax1) * (ay2 - ay1) -
          (ax2 - ax1) * (by2 - by1) +
          (bx2 - bx1) * (by2 - by1);
    if (ax1 <= bx1 && ax2 >= bx2 && ay2 <= by2 && ay1 >= by1)
      return (ax2 - ax1) * (ay2 - ay1) -
          (bx2 - bx1) * (ay2 - ay1) +
          (bx2 - bx1) * (by2 - by1);
    if (ax2 >= bx1 && ax1 <= bx1 && ay2 >= by2 && ay1 <= by1)
      return (ax2 - ax1) * (ay2 - ay1) -
          (ax2 - bx1) * (by2 - by1) +
          (bx2 - bx1) * (by2 - by1);
    if (by2 >= ay1 && by2 <= ay2 && bx1 >= ax1 && bx2 <= ax2)
      return (ax2 - ax1) * (ay2 - ay1) -
          (bx2 - bx1) * (by2 - ay1) +
          (bx2 - bx1) * (by2 - by1);
    if (bx2 >= ax1 && bx2 <= ax2 && by1 >= ay1 && by2 <= ay2)
      return (ax2 - ax1) * (ay2 - ay1) -
          (bx2 - ax1) * (by2 - by1) +
          (bx2 - bx1) * (by2 - by1);
    if (by1 >= ay1 && by1 <= ay2 && bx1 >= ax1 && bx2 <= ax2)
      return (ax2 - ax1) * (ay2 - ay1) -
          (ay2 - by1) * (bx2 - bx1) +
          (bx2 - bx1) * (by2 - by1);
    if (bx2 >= ax1 && bx1 <= ax1 && by2 >= ay2 && by1 <= ay1)
      return (ax2 - ax1) * (ay2 - ay1) -
          (bx2 - ax1) * (ay2 - ay1) +
          (bx2 - bx1) * (by2 - by1);
    if (ay2 >= by1 && ay2 <= by2 && ax1 >= bx1 && ax2 <= bx2)
      return (ax2 - ax1) * (ay2 - ay1) -
          (ax2 - ax1) * (ay2 - by1) +
          (bx2 - bx1) * (by2 - by1);
    if (ax2 >= bx1 && ax2 <= bx2 && ay1 >= by1 && ay2 <= by2)
      return (ax2 - ax1) * (ay2 - ay1) -
          (ax2 - bx1) * (ay2 - ay1) +
          (bx2 - bx1) * (by2 - by1);
    if (ay1 >= by1 && ay1 <= by2 && ax1 >= bx1 && ax2 <= bx2)
      return (ax2 - ax1) * (ay2 - ay1) -
          (by2 - ay1) * (ax2 - ax1) +
          (bx2 - bx1) * (by2 - by1);
    if (ax2 >= bx1 && bx2 >= ax2 && ay1 >= by1 && by2 >= ay1)
      return (ax2 - ax1) * (ay2 - ay1) -
          (ax2 - bx1) * (by2 - ay1) +
          (bx2 - bx1) * (by2 - by1);
    if (bx2 >= ax1 && ax1 >= bx1 && by1 <= ay1 && ay1 <= by2)
      return (ax2 - ax1) * (ay2 - ay1) -
          (bx2 - ax1) * (by2 - ay1) +
          (bx2 - bx1) * (by2 - by1);
    if (bx2 >= ax1 && ax1 >= bx1 && by2 >= ay2 && by1 <= ay2)
      return (ax2 - ax1) * (ay2 - ay1) -
          (bx2 - ax1) * (ay2 - by1) +
          (bx2 - bx1) * (by2 - by1);
    if (ax2 >= bx1 && ax2 <= bx2 && by1 <= ay2 && by2 >= ay2)
      return (ax2 - ax1) * (ay2 - ay1) -
          (ax2 - bx1) * (ay2 - by1) +
          (bx2 - bx1) * (by2 - by1);
    return (ax2 - ax1) * (ay2 - ay1) + (bx2 - bx1) * (by2 - by1);
  }
}
```

## Solution - 4

```dart
class Solution {
  int computeArea(
      int ax1, int ay1, int ax2, int ay2, int bx1, int by1, int bx2, int by2) {
    if (ax1 <= bx1 && ay1 <= by1 && ax2 >= bx2 && ay2 >= by2)
      return (ax2 - ax1) * (ay2 - ay1);
    if (ax1 >= bx1 && ay1 >= by1 && ax2 <= bx2 && ay2 <= by2)
      return (bx2 - bx1) * (by2 - by1);
    if (ax1 >= bx1 && ax2 <= bx2 && ay2 >= by2 && ay1 <= by1)
      return (ax2 - ax1) * (ay2 - ay1) -
          (ax2 - ax1) * (by2 - by1) +
          (bx2 - bx1) * (by2 - by1);
    if (ax1 <= bx1 && ax2 >= bx2 && ay2 <= by2 && ay1 >= by1)
      return (ax2 - ax1) * (ay2 - ay1) -
          (bx2 - bx1) * (ay2 - ay1) +
          (bx2 - bx1) * (by2 - by1);
    if (ax2 >= bx1 && ax1 <= bx1 && ay2 >= by2 && ay1 <= by1)
      return (ax2 - ax1) * (ay2 - ay1) -
          (ax2 - bx1) * (by2 - by1) +
          (bx2 - bx1) * (by2 - by1);
    if (by2 >= ay1 && by2 <= ay2 && bx1 >= ax1 && bx2 <= ax2)
      return (ax2 - ax1) * (ay2 - ay1) -
          (bx2 - bx1) * (by2 - ay1) +
          (bx2 - bx1) * (by2 - by1);
    if (bx2 >= ax1 && bx2 <= ax2 && by1 >= ay1 && by2 <= ay2)
      return (ax2 - ax1) * (ay2 - ay1) -
          (bx2 - ax1) * (by2 - by1) +
          (bx2 - bx1) * (by2 - by1);
    if (by1 >= ay1 && by1 <= ay2 && bx1 >= ax1 && bx2 <= ax2)
      return (ax2 - ax1) * (ay2 - ay1) -
          (ay2 - by1) * (bx2 - bx1) +
          (bx2 - bx1) * (by2 - by1);
    if (bx2 >= ax1 && bx1 <= ax1 && by2 >= ay2 && by1 <= ay1)
      return (ax2 - ax1) * (ay2 - ay1) -
          (bx2 - ax1) * (ay2 - ay1) +
          (bx2 - bx1) * (by2 - by1);
    if (ay2 >= by1 && ay2 <= by2 && ax1 >= bx1 && ax2 <= bx2)
      return (ax2 - ax1) * (ay2 - ay1) -
          (ax2 - ax1) * (ay2 - by1) +
          (bx2 - bx1) * (by2 - by1);
    if (ax2 >= bx1 && ax2 <= bx2 && ay1 >= by1 && ay2 <= by2)
      return (ax2 - ax1) * (ay2 - ay1) -
          (ax2 - bx1) * (ay2 - ay1) +
          (bx2 - bx1) * (by2 - by1);
    if (ay1 >= by1 && ay1 <= by2 && ax1 >= bx1 && ax2 <= bx2)
      return (ax2 - ax1) * (ay2 - ay1) -
          (by2 - ay1) * (ax2 - ax1) +
          (bx2 - bx1) * (by2 - by1);
    if (ax2 >= bx1 && bx2 >= ax2 && ay1 >= by1 && by2 >= ay1)
      return (ax2 - ax1) * (ay2 - ay1) -
          (ax2 - bx1) * (by2 - ay1) +
          (bx2 - bx1) * (by2 - by1);
    if (bx2 >= ax1 && ax1 >= bx1 && by1 <= ay1 && ay1 <= by2)
      return (ax2 - ax1) * (ay2 - ay1) -
          (bx2 - ax1) * (by2 - ay1) +
          (bx2 - bx1) * (by2 - by1);
    if (bx2 >= ax1 && ax1 >= bx1 && by2 >= ay2 && by1 <= ay2)
      return (ax2 - ax1) * (ay2 - ay1) -
          (bx2 - ax1) * (ay2 - by1) +
          (bx2 - bx1) * (by2 - by1);
    if (ax2 >= bx1 && ax2 <= bx2 && by1 <= ay2 && by2 >= ay2)
      return (ax2 - ax1) * (ay2 - ay1) -
          (ax2 - bx1) * (ay2 - by1) +
          (bx2 - bx1) * (by2 - by1);
    return (ax2 - ax1) * (ay2 - ay1) + (bx2 - bx1) * (by2 - by1);
  }
}
```
