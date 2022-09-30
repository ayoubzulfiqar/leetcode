# 🔥 The Skyline Problem 🔥 || 3 Solutions || Simple Fast and Easy || with Explanation

## Solution - 1

```dart
class KeyPoint {
  int key;
  int height;
  KeyPoint? next = null;

  KeyPoint(int this.key, int this.height);
}



class Solution {
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
        res.add([second.key, second.height]);
      first = first.next;
      second = second.next;
    }
    return res;
  }
}
```

## Solution - 2 Divide and Conquer

```dart
class Solution {
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
```

## SOlution - 3

```dart
class Solution {
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
```
