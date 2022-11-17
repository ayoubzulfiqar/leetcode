/*

-* 223. Rectangle Area *-

Given the coordinates of two rectilinear rectangles in a 2D plane, return the total area covered by the two rectangles.

The first rectangle is defined by its bottom-left corner (ax1, ay1) and its top-right corner (ax2, ay2).

The second rectangle is defined by its bottom-left corner (bx1, by1) and its top-right corner (bx2, by2).



Example 1:

Rectangle Area
Input: ax1 = -3, ay1 = 0, ax2 = 3, ay2 = 4, bx1 = 0, by1 = -1, bx2 = 9, by2 = 2
Output: 45
Example 2:

Input: ax1 = -2, ay1 = -2, ax2 = 2, ay2 = 2, bx1 = -2, by1 = -2, bx2 = 2, by2 = 2
Output: 16


Constraints:

-104 <= ax1 <= ax2 <= 104
-104 <= ay1 <= ay2 <= 104
-104 <= bx1 <= bx2 <= 104
-104 <= by1 <= by2 <= 104

*/

import 'dart:math';

class A {
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

class B {
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

class C {
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

class D {
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
