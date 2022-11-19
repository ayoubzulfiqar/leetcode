# 🔥 Erect the Fence 🔥 || 4 Approaches || Simple Fast and Easy || with Explanation

## Solution - 1 Convex Hull | Graham Scan

```dart
class Solution {
// Runtime: 668 ms, faster than 100.00% of Dart online submissions for Erect the Fence.
// Memory Usage: 152.4 MB, less than 100.00% of Dart online submissions for Erect the Fence.
  int orientation(List<int> p, List<int> q, List<int> r) {
    return (r[1] - q[1]) * (q[0] - p[0]) - ((q[1] - p[1]) * (r[0] - q[0]));
  }

  List<List<int>> outerTrees(List<List<int>> trees) {
    List<List<int>> upper = [];
    List<List<int>> lower = [];
    trees.sort((p, q) => q[0] - p[0] == 0 ? q[1] - p[1] : q[0] - p[0]);
    for (int i = 0; i < trees.length; i++) {
      while (lower.length >= 2 &&
          orientation(lower.elementAt(lower.length - 2),
                  lower.elementAt(lower.length - 1), trees[i]) >
              0) {
        lower.removeLast();
      }
      while (upper.length >= 2 &&
          orientation(upper.elementAt(upper.length - 2),
                  upper.elementAt(upper.length - 1), trees[i]) <
              0) {
        upper.removeLast();
      }
      lower.add(trees[i]);
      upper.add(trees[i]);
    }
    HashSet<List<int>> res = HashSet();
    res.addAll(lower);
    res.addAll(upper);
    return res.toList();
  }
}
```

## Solution - 2 Convex Hull | Jarvis Algorithm

```dart
class Solution {
  // TLE
  int crossProduct(List<int> p, List<int> q, List<int> r) {
    return (q[1] - p[1]) * (r[0] - q[0]) - (q[0] - p[0]) * (r[1] - q[1]);
  }

  bool distance(List<int> p, List<int> i, List<int> q) {
    bool a = i[0] >= p[0] && i[0] <= q[0] || i[0] <= p[0] && i[0] >= q[0];
    bool b = i[1] >= p[1] && i[1] <= q[1] || i[1] <= p[1] && i[1] >= q[1];
    return a && b;
  }

  List<List<int>> outerTrees(List<List<int>> trees) {
    //use hashSet because this algorithm might try to insert duplicate point.
    HashSet<List<int>> hashSet = HashSet();
    if (trees.length < 4) {
      for (List<int> p in trees) hashSet.add(p);
      return hashSet.toList();
    }
    int leftMost = 0;
    for (int i = 0; i < trees.length; i++)
      if (trees[i][0] < trees[leftMost][0]) leftMost = i;

    //first find leftmost point to start the march.
    int p = leftMost;
    do {
      int q = (p + 1) % trees.length;

      for (int i = 0; i < trees.length; i++) {
        //if crossProduct < 0 it means trees[i] is on right of current point -> nextPoint. Make him the next point.
        if (crossProduct(trees[p], trees[i], trees[q]) < 0) {
          q = i;
        }
      }

      for (int i = 0; i < trees.length; i++) {
        if (i != p &&
            i != q &&
            crossProduct(trees[p], trees[i], trees[q]) == 0 &&
            distance(trees[p], trees[i], trees[q])) {
          // if more than one trees are on the rightmost, then insert all the collinear trees in the hashSet
          hashSet.add(trees[i]);
        }
      }

      hashSet.add(trees[q]);
      p = q;
    } while (p != leftMost);
    return hashSet.toList();
  }
}
```

## Solution - 3 Gift Wrapping

## Approach

The idea is that we start from a corner point, and we use a rope (fixed length, long enough), and we go as far as we can, since the length is fixed and we start from a corner point, we will go back to the origin point finally.

The first step is how to find such a corner point, this can be done by choosing the left most point, it must be a corner point.
The second step is find the next corner point, we will explain this later in detail.
The third step is checking if we have returned to the original point.
Now, we focus on the problem of finding the next corner point front one conner point.

Now, suppose we are now in the corner point A, we want to find the next corner point D, how do we do it: The idea is we start from a random point, say B, and select a random point, say C, and we compare B and C, find the outer one, where outer means C will be on the convex hull more likely than B in the anti-clockwise direction. If C is indeed outer than B, then we update B<-C, and find a new one, until all points has been visited.
Now our problem becomes: How to describe outer formally, or codable? The answer is outer product, I will not use mathematical definition here, but the property of outer product is that: if the crossProduct(AB, AC)>0, it means the vector B is in clockwise direction of C respect to A(as shown in figure above), otherwise B is in anti-clockwise direction of C respect to A (for example, D and C or C and B).
Finally, we need to check the case when three points are colinear, since we need to chose the farthest one.

```dart
class Solution {
  int crossProduct(List<int> A, List<int> B, List<int> C) {
    int BA_x = A[0] - B[0];
    int BC_x = C[0] - B[0];
    int BA_y = A[1] - B[1];
    int BC_y = C[1] - B[1];
    return BA_x * BC_y - BA_y * BC_x;
  }

  int distance(List<int> A, List<int> B) {
    return (A[0] - B[0]) * (A[0] - B[0]) + (A[1] - B[1]) * (A[1] - B[1]);
  }

  bool isNotInPointList(List<List<int>> pointList, List<int> point) {
    for (var point_ in pointList) {
      if (point_[0] == point[0] && point_[1] == point[1]) {
        return false;
      }
    }
    return true;
  }

  List<List<int>> outerTrees(List<List<int>> trees) {
    List<List<int>> result = [].map((e) => <int>[]).toList();
    int size = trees.length;
    // find the left most point and its index
    List<int> firstPoint = List.filled(2, 101);
    int firstIndex = 0;
    for (int i = 0; i < size; ++i) {
      if (trees[i][0] < firstPoint[0]) {
        firstPoint = trees[i];
        firstIndex = i;
      }
    }
    result.add(firstPoint);

    List<int> currentPoint = firstPoint;
    int currentIndex = firstIndex;
    while (true) {
      // find the most outer point
      List<int> nextPoint = trees[0];
      int nextIndex = 0;
      for (int index = 0; index < size; ++index) {
        if (index == currentIndex) continue;
        int crossPRODUCT = crossProduct(currentPoint, trees[index], nextPoint);
        if (nextIndex == currentIndex ||
            crossPRODUCT > 0 ||
            (crossPRODUCT == 0 &&
                distance(trees[index], currentPoint) >
                    distance(nextPoint, currentPoint))) {
          nextPoint = trees[index];
          nextIndex = index;
        }
      }
      // sanity check
      for (int index = 0; index < size; ++index) {
        if (index == currentIndex) continue;
        int crossPRODUCT = crossProduct(currentPoint, trees[index], nextPoint);
        if (crossPRODUCT == 0 && isNotInPointList(result, trees[index]))
          result.add(trees[index]);
      }
      currentPoint = nextPoint;
      currentIndex = nextIndex;
      if (currentIndex == firstIndex) break;
    }
    return result;
  }
}
```

## Solution - 4 Monotone Chain Algorithm

```dart
class Solution {
  int Orientation(List<int> p, List<int> q, List<int> r) =>
      (q[1] - p[1]) * (r[0] - q[0]) - (q[0] - p[0]) * (r[1] - q[1]);
  List<List<int>> outerTrees(List<List<int>> trees) {
    //  Array.Sort(trees, (p,q) => q[0] - p[0] == 0 ? q[1] - p[1] : q[0] - p[0]);
    trees.sort((p, q) => q[0] - p[0] == 0 ? q[1] - p[1] : q[0] - p[0]);

    List<List<int>> hull = [];
    for (int i = 0; i < trees.length; i++) {
      while (hull.length >= 2 &&
          Orientation(hull.elementAt(1), hull.first, trees[i]) > 0)
        hull.removeLast();
      hull.add(trees[i]);
    }

    hull.removeLast();

    for (int i = trees.length - 1; i >= 0; i--) {
      while (hull.length >= 2 &&
          Orientation(hull.elementAt(1), hull.first, trees[i]) > 0)
        hull.removeLast();
      hull.add(trees[i]);
    }

    HashSet<List<int>> hashSet = HashSet();
    hashSet.addAll(hull);
    return hashSet.toList();
  }
}
```
