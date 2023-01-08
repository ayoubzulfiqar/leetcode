/*




-* 149. Max Points on a Line *-


Given an array of points where points[i] = [xi, yi] represents a point on the X-Y plane, return the maximum number of points that lie on the same straight line.

 

Example 1:


Input: points = [[1,1],[2,2],[3,3]]
Output: 3
Example 2:


Input: points = [[1,1],[3,2],[5,3],[4,1],[2,3],[1,4]]
Output: 4
 

Constraints:

1 <= points.length <= 300
points[i].length == 2
-104 <= xi, yi <= 104
All the points are unique.



*/
import 'dart:collection';
import 'dart:math';

class Point {
  late int x;
  late int y;
  // Point() {
  //   x = 0;
  //   y = 0;
  // }
  Point(int a, int b) {
    x = a;
    y = b;
  }
}

class A {
  int maxPoints(List<List<int>> points) {
    if (points.length <= 0) return 0;
    if (points.length <= 2) return points.length;
    int result = 0;
    int x = 0;
    int y = 0;
    for (int i = 0; i < points.length; i++) {
      HashMap<double, int> hm = HashMap();
      int sameX = 1;
      int sameP = 0;
      for (int j = 0; j < points.length; j++) {
        if (j != i) {
          if ((points[j][x] == points[i][x]) &&
              (points[j][y] == points[i][y])) {
            sameP++;
          }
          if (points[j][x] == points[i][x]) {
            sameX++;
            continue;
          }
          double k =
              (points[j][y] - points[i][y]) / (points[j][x] - points[i][x]);
          if (hm.containsKey(k)) {
            hm[k] = (hm[k] ?? 0) + 1;
          } else {
            hm[k] = 2;
          }
          result = max(result, (hm[k] ?? 0) + sameP);
        }
      }
      result = max(result, sameX);
    }
    return result;
  }
}

class B {
  int getGcd(int a, int b) {
    if (a == 0) return b;
    return getGcd(b % a, a);
  }

  int maxPoints(List<List<int>> points) {
    int v = 0;
    int res = 0;
    int len = points.length;
    if (len < 3) return len;
    for (int i = 0; i + res < len; i++) {
      HashMap<String, int> m = HashMap();
      int x1 = points[i][0], y1 = points[i][1], v = 0, maxv = 0, dups = 0;
      int nIdentical = 0;
      // start with i+1, since if any previous point is on the same line,
      // then this was already calculated then that point was a starting point
      for (int j = i + 1; j < len; j++) {
        int x2 = points[j][0], y2 = points[j][1];
        int dx = x2 - x1, dy = y2 - y1;

        if (dx == 0 && dy == 0) {
          dups++;
        } else {
          // we need the slope: dx/dy. but float rounds up the end and produces slightly different results,
          // so instead we keep both dx and dy as the key.
          // to make them identical for the identical slope, use GCD: greatest common divisor
          int gcd = getGcd(dx, dy);
          dy ~/= gcd;
          dx ~/= gcd;

          // dx and dy define the slope.
          // we keep the map for the current point i, so the full key is point[i]+slope excludes parallel lines.
          // vertical line: dx==0, horizontal line: dy==0. GCD will set vertical: dx=0, dy=1, horizontal: dx=1, dy=0
          String key = dx.toString() + '/' + dy.toString();
          //m[key] != m.entries
          if (m.containsKey(key)) {
            // m[key]++;
            m[key] = (m[key] ?? 0) + 1;
            v = m[key] ?? 0;
          } else {
            m[key] = 1;
            v = 1;
          }
        }
        // duplicates should increase our best result found with point[i]
        if (maxv < v) maxv = v;
        if (res < dups + maxv + 1) res = dups + maxv + 1;
      }
    }
    return res;
  }
}

class C {
  int getGcd(int a, int b) {
    if (a == 0) return b;
    return getGcd(b % a, a);
  }

  int maxPoints(List<List<int>> points) {
    int res = 0, len = points.length;
    if (len < 3) return len;
    for (int i = 0; i + res < len; i++) {
      Map<String, int> m = {};
      int x1 = points[i][0], y1 = points[i][1], v = 0, maxV = 0, dups = 0;
      int nIdentical = 0;
      for (int j = i + 1; j < len; j++) {
        int x2 = points[j][0], y2 = points[j][1];
        int dx = x2 - x1, dy = y2 - y1;
        if (dx == 0 && dy == 0) {
          dups++;
        } else {
          int gcd = getGcd(dx, dy);
          dy ~/= gcd;
          dx ~/= gcd;
          String key = "$dx/$dy";
          if (m.containsKey(key)) {
            // m[key]++;
            // v = m[key];
            m[key] = (m[key] ?? 0) + 1;
            v = m[key] ?? 0;
          } else {
            m[key] = 1;
            v = 1;
          }
        }
        if (maxV < v) maxV = v;
        if (res < dups + maxV + 1) res = dups + maxV + 1;
      }
    }
    return res;
  }
}

class D {
  int maxPoints(List<List<int>> pt) {
    int ans = 1;
    int n = pt.length;
    for (int i = 0; i < n - 1; i++) {
      HashMap<double, int> mp = HashMap();
      for (int j = i + 1; j < n; j++) {
        if (pt[j][1] == pt[i][1]) {
          mp[-90] = (mp[-90] ?? 0) + 1;
        } else {
          double x = (pt[j][0] - pt[i][0]).toDouble() /
              (pt[j][1] - pt[i][1]).toDouble();
          mp[x] = (mp[x] ?? 0) + 1;
        }
      }
      int temp = 0;
      for (MapEntry<double, int> it in mp.entries) {
        temp = max(temp, it.value + 1);
      }
      ans = max(temp, ans);
    }
    return ans;
  }
}
