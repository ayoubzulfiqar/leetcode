/*


 -* 587. Erect the Fence *-


 You are given an array trees where trees[i] = [xi, yi] represents the location of a tree in the garden.

You are asked to fence the entire garden using the minimum length of rope as it is expensive. The garden is well fenced only if all the trees are enclosed.

Return the coordinates of trees that are exactly located on the fence perimeter.



Example 1:


Input: trees = [[1,1],[2,2],[2,0],[2,4],[3,3],[4,2]]
Output: [[1,1],[2,0],[3,3],[2,4],[4,2]]
Example 2:


Input: trees = [[1,2],[2,2],[4,2]]
Output: [[4,2],[2,2],[1,2]]


Constraints:

1 <= trees.length <= 3000
trees[i].length == 2
0 <= xi, yi <= 100
All the given trees are unique.


*/

import 'dart:collection';

class A {
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

class B {
  int getRotationAngle(List<int> A, List<int> B, List<int> C) {
    // (x2-x1)(y3-y1) - (y2-y1)(x3-x1) -> 3D Cross-product of AB and AC Lists
    return ((B[0] - A[0]) * (C[1] - A[1])) - ((B[1] - A[1]) * (C[0] - A[0]));
  }

  List<List<int>> outerTrees(List<List<int>> trees) {
    if (trees.length <= 3) return trees;
    // sort(trees.begin(), trees.end());
    trees.sort();

    // Upper HULL construction
    List<List<int>> lTrees = [].map((e) => <int>[]).toList();
    lTrees.add(trees[0]);
    lTrees.add(trees[1]);
    for (int i = 2; i < trees.length; i++) {
      int ls = lTrees.length;
      while (lTrees.length >= 2 &&
          getRotationAngle(lTrees[ls - 2], lTrees[ls - 1], trees[i]) > 0) {
        lTrees.removeLast();
        ls--;
      }
      lTrees.add(trees[i]);
    }

    // Lower HULL construction
    List<List<int>> rTrees = [].map((e) => <int>[]).toList();
    rTrees.add(trees[trees.length - 1]);
    rTrees.add(trees[trees.length - 2]);
    for (int i = trees.length - 3; i >= 0; --i) {
      int rs = rTrees.length;
      while (rTrees.length >= 2 &&
          getRotationAngle(rTrees[rs - 2], rTrees[rs - 1], trees[i]) > 0) {
        rTrees.removeLast();
        rs--;
      }
      rTrees.add(trees[i]);
    }

    // Pop the last elements as they would've occurred in both lists
    rTrees.removeLast();
    lTrees.removeLast();
    for (int i = 0; i < rTrees.length; i++) {
      lTrees.add(rTrees[i]);
    }

    // Sort and remove duplicate elements. (It is begging for a different approach!!)
    // sort(lTrees.begin(), lTrees.end());
    lTrees.sort();
    // lTrees.clear(unique(lTrees.begin(), lTrees.end()), lTrees.end());
    lTrees.clear();

    return lTrees;
  }
}

class D {
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

class C {
  // TLE
  int crossPRODUCT(List<int> p, List<int> q, List<int> r) {
    return (q[1] - p[1]) * (r[0] - q[0]) - (q[0] - p[0]) * (r[1] - q[1]);
  }

  bool distance(List<int> p, List<int> i, List<int> q) {
    bool a = i[0] >= p[0] && i[0] <= q[0] || i[0] <= p[0] && i[0] >= q[0];
    bool b = i[1] >= p[1] && i[1] <= q[1] || i[1] <= p[1] && i[1] >= q[1];
    return a && b;
  }

  List<List<int>> outerTrees(List<List<int>> trees) {
    //use hashSet because this algorithm might try to insert duplicate List<int>.
    HashSet<List<int>> hashSet = HashSet();
    if (trees.length < 4) {
      for (List<int> p in trees) hashSet.add(p);
      return hashSet.toList();
    }
    int leftMost = 0;
    for (int i = 0; i < trees.length; i++)
      if (trees[i][0] < trees[leftMost][0]) leftMost = i;

    //first find leftmost List<int> to start the march.
    int p = leftMost;
    do {
      int q = (p + 1) % trees.length;

      for (int i = 0; i < trees.length; i++) {
        //if crossPRODUCT < 0 it means trees[i] is on right of current List<int> -> nextList<int>. Make him the next List<int>.
        if (crossPRODUCT(trees[p], trees[i], trees[q]) < 0) {
          q = i;
        }
      }

      for (int i = 0; i < trees.length; i++) {
        if (i != p &&
            i != q &&
            crossPRODUCT(trees[p], trees[i], trees[q]) == 0 &&
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

class E {
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
