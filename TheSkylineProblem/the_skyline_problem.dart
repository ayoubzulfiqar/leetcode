/*

-* The Skyline Problem *-


A city's skyline is the outer contour of the silhouette formed by all the buildings in that city when viewed from a distance. Given the locations and heights of all the buildings, return the skyline formed by these buildings collectively.

The geometric information of each building is given in the array buildings where buildings[i] = [lefti, righti, heighti]:

left-i is the x coordinate of the left edge of the ith building.
right-i is the x coordinate of the right edge of the ith building.
height-i is the height of the ith building.
You may assume all buildings are perfect rectangles grounded on an absolutely flat surface at height 0.

The skyline should be represented as a list of "key points" sorted by their x-coordinate in the form [[x1,y1],[x2,y2],...]. Each key point is the left endpoint of some horizontal segment in the skyline except the last point in the list, which always has a y-coordinate 0 and is used to mark the skyline's termination where the rightmost building ends. Any ground between the leftmost and rightmost buildings should be part of the skyline's contour.

Note: There must be no consecutive horizontal lines of equal height in the output skyline. For instance, [...,[2 3],[4 5],[7 5],[11 5],[12 7],...] is not acceptable; the three lines of height 5 should be merged into one in the final output as such: [...,[2 3],[4 5],[12 7],...]



Example 1:


Input: buildings = [[2,9,10],[3,7,15],[5,12,12],[15,20,10],[19,24,8]]
Output: [[2,10],[3,15],[7,12],[12,0],[15,10],[20,8],[24,0]]
Explanation:
Figure A shows the buildings of the input.
Figure B shows the skyline formed by those buildings. The red points in figure B represent the key points in the output list.
Example 2:

Input: buildings = [[0,2,3],[2,5,3]]
Output: [[0,3],[5,0]]


Constraints:

1 <= buildings.length <= 104
0 <= left-i < right-i <= 231 - 1
1 <= height-i <= 231 - 1
buildings is sorted by left-i in non-decreasing order.




*/

import 'dart:math';

class A {
  List<List<int>> getSkyline(List<List<int>> buildings) {
    int n = buildings.length;
    List<int> keys = [];
    for (List<int> building in buildings) {
      keys.add(building[0]);
      keys.add(building[1]);
    }
    keys.sort();
    int last = 0;
    int lastKey = -1;
    List<int> temp = [];
    List<List<int>> result = [].map((e) => <int>[]).toList();
    for (int left in keys) {
      if (left == lastKey) continue;
      lastKey = left;
      int height = 0;
      for (List<int> building in buildings) {
        if (left >= building[0] && left < building[1])
          height = max(height, building[2]);
        else if (building[0] > left) break;
      }
      if (height != last) {
        temp.add(left);
        temp.add(height);
        result.add(temp);
        temp.clear();
      }
      last = height;
    }
    return result;
  }
}

class C {
  // Time Limit exceed
  List<List<int>> getSkyline(List<List<int>> buildings) {
    Set new_set = Set();
    buildings.forEach((b) {
      new_set.add(b[0]);
      new_set.add(b[1]);
    });
    List temp = List.from(new_set);
    temp.sort((a, b) => a - b);
    List<List<int>> result = [].map((e) => <int>[]).toList();
    temp.forEach((x) {
      List<List<int>> b =
          buildings.where((b) => b[0] == x || b[0] < x && b[1] > x).toList();
      int maxi = 0;
      for (int i = 0; i < b.length; i++) {
        maxi = max(maxi, b[i][2]);
      }
      result.add([x, maxi]);
    });

    for (int i = 1; i < result.length; i++) {
      List<int> last = result[i - 1];
      List<int> current = result[i];
      if (last[1] == current[1]) {
        result.sublist(1, i);
        i--;
      }
    }
    return result;
  }
}

class KeyPoint {
  int key;
  int height;
  KeyPoint? next = null;

  KeyPoint(int this.key, int this.height);
}

class D {
// Runtime: 592 ms, faster than 100.00% of Dart online submissions for The Skyline Problem.
// Memory Usage: 147.5 MB, less than 100.00% of Dart online submissions for The Skyline Problem.

  List<List<int>> getSkyline(List<List<int>> buildings) {
    List<List<int>> res = [].map((e) => <int>[]).toList();
    KeyPoint dummy = KeyPoint(-1, 0); // dummy head
    KeyPoint pre = dummy;

    for (List<int> bd in buildings) {
      int L = bd[0];
      int R = bd[1];
      int H = bd[2];

      while (pre.next != null && pre.next!.key <= L) pre = pre.next!;

      int preH = pre.height;

      if (pre.key == L)
        pre.height = max(pre.height, H);
      else if (pre.height < H) {
        KeyPoint? next = pre.next;
        pre.next = new KeyPoint(L, H);
        pre = pre.next!;
        pre.next = next;
      }

      KeyPoint preIter = pre;
      KeyPoint? curIter = pre.next;
      while (curIter != null && curIter.key < R) {
        preH = curIter.height;
        curIter.height = max(curIter.height, H);

        if (curIter.height == preIter.height)
          preIter.next = curIter.next;
        else
          preIter = curIter;

        curIter = curIter.next;
      }

      if (preIter.height != preH &&
          preIter.key != R &&
          (curIter == null || curIter.key != R)) {
        KeyPoint? next = preIter.next;
        preIter.next = KeyPoint(R, preH);
        preIter.next!.next = next;
      }
    }

    KeyPoint? first = dummy;
    KeyPoint? second = dummy.next;
    while (second != null) {
      if (second.height != first!.height)
        //res.add(Arrays.asList(second.key, second.height));
        res.add([second.key, second.height]);
      first = first.next;
      second = second.next;
    }
    return res;
  }
}

class E {
  // divide and conquer
// Runtime: 498 ms, faster than 100.00% of Dart online submissions for The Skyline Problem.
// Memory Usage: 152 MB, less than 100.00% of Dart online submissions for The Skyline Problem.

  List<List<int>> getSkyline(List<List<int>> buildings) {
    List<List<int>> res = [].map((e) => <int>[]).toList();
    if (buildings.length == 0) return res;
    int n = buildings.length;
    return findSkyline(buildings, 0, n - 1);
  }

  List<List<int>> findSkyline(List<List<int>> buildings, int lo, int hi) {
    List<List<int>> res = [].map((e) => <int>[]).toList();
    ;
    if (lo == hi) {
      res.add([buildings[lo][0], buildings[lo][2]]);
      res.add([buildings[lo][1], 0]);
      return res;
    }
    int mid = lo + (hi - lo) ~/ 2;
    List<List<int>> skyline1 = findSkyline(buildings, lo, mid);
    List<List<int>> skyline2 = findSkyline(buildings, mid + 1, hi);
    return mergeSkyline(skyline1, skyline2);
  }

  List<List<int>> mergeSkyline(
      List<List<int>> skyline1, List<List<int>> skyline2) {
    List<List<int>> res = [].map((e) => <int>[]).toList();
    int i = 0, j = 0;
    int h1 = 0, h2 = 0;

    while (i < skyline1.length && j < skyline2.length) {
      int x1 = skyline1.elementAt(i).elementAt(0);
      int x2 = skyline2.elementAt(j).elementAt(0);
      int x;
      if (x1 < x2) {
        h1 = skyline1.elementAt(i++).elementAt(1);
        x = x1;
      } else if (x1 > x2) {
        h2 = skyline2.elementAt(j++).elementAt(1);
        x = x2;
      } else {
        h1 = skyline1.elementAt(i++).elementAt(1);
        h2 = skyline2.elementAt(j++).elementAt(1);
        x = x1;
      }
      int h = max(h1, h2);

      if (res.isEmpty || h != res.elementAt(res.length - 1).elementAt(1)) {
        res.add([x, h]);
      }
    }

    while (i < skyline1.length) res.add(skyline1.elementAt(i++));
    while (j < skyline2.length) res.add(skyline2.elementAt(j++));

    return res;
  }
}

class F {
// Runtime: 835 ms, faster than 100.00% of Dart online submissions for The Skyline Problem.
// Memory Usage: 151.5 MB, less than 100.00% of Dart online submissions for The Skyline Problem.

  List<List<int>> getSkyline(List<List<int>> buildings) {
    if (buildings.length == 0) return [].map((e) => <int>[]).toList();
    return recurSkyline(buildings, 0, buildings.length - 1);
  }

  List<List<int>> recurSkyline(List<List<int>> buildings, int p, int q) {
    if (p < q) {
      int mid = p + (q - p) ~/ 2;
      return merge(
          recurSkyline(buildings, p, mid), recurSkyline(buildings, mid + 1, q));
    } else {
      List<List<int>> rs = [].map((e) => <int>[]).toList();
      rs.add([buildings[p][0], buildings[p][2]]);
      rs.add([buildings[p][1], 0]);
      return rs;
    }
  }

  List<List<int>> merge(List<List<int>> l1, List<List<int>> l2) {
    List<List<int>> rs = [].map((e) => <int>[]).toList();
    int h1 = 0, h2 = 0;
    while (l1.length > 0 && l2.length > 0) {
      int x = 0, h = 0;
      if (l1.first[0] < l2.first[0]) {
        x = l1.first[0];
        h1 = l1.first[1];
        h = max(h1, h2);
        // remove first
        l1.removeAt(0);
      } else if (l1.first[0] > l2.first[0]) {
        x = l2.first[0];
        h2 = l2.first[1];
        h = max(h1, h2);
        l2.removeAt(0);
      } else {
        x = l1.first[0];
        h1 = l1.first[1];
        h2 = l2.first[1];
        h = max(h1, h2);
        l1.removeAt(0);
        l2.removeAt(0);
      }
      if (rs.length == 0 || h != rs.last[1]) {
        rs.add([x, h]);
      }
    }
    rs.addAll(l1);
    rs.addAll(l2);
    return rs;
  }
}

extension Splice<T> on List<T> {
  List<T> splice<T>(List<T> list, int index,
      [num howMany = 0, /*<T | List<T>>*/ elements]) {
    var endIndex = index + howMany.truncate();
    list.removeRange(index, endIndex >= list.length ? list.length : endIndex);
    if (elements != null)
      list.insertAll(index, elements is List<T> ? elements : <T>[elements]);
    return list;
  }
}
