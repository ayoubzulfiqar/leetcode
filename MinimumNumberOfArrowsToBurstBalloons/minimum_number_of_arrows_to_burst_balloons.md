# 🔥 2 Approaches 🔥 || Simple Fast and Easy || with Explanation

## Explanation

This problem actually asks us: how many intervals are left when you combine all possible intersections. Well, it get's a lot easier when we first sort the array by the starting points of the intervals. Due to sorting, we have a runtime complexity of
**O(N log N)**.

Sort the array of intervals, starting with the smallest starting point.
Store the current end of the interval.
As long as the current end is bigger or equal the start of the interval, we don't need another arrow. Be careful here, we have to update the current end as it might happen that the end of this interval is smaller than our current one.
If the start of the interval is bigger than our current end, we have to use a new arrow.

## Solution - 1 GREEDY

```dart
class Solution {
/**
Two key Ideas :
    (a) Greedy heuristic : burst all the balloons whose start is <= min(end);
    (b) If the start > min(end), you need another arrow to burst it so increment arrows and move the end forward.
**/
  int findMinArrowShots(List<List<int>> points) {
    if (points.length == 0) return 0;
    points.sort((a, b) => a[1] - b[1]);
    int arrowPos = points[0][1];
    int arrowCnt = 1;
    for (int i = 1; i < points.length; i++) {
      if (arrowPos >= points[i][0]) {
        continue;
      }
      arrowCnt++;
      arrowPos = points[i][1];
    }
    return arrowCnt;
  }
}
```

## Solution - 2 OPTIMIZED GREEDY

```dart
class Solution {
  int findMinArrowShots(List<List<int>> points) {
    // corner case
    if (points.length == 0 || points[0].length == 0) return 0;
    // sort and get merger point
    points.sort((List<int> a, List<int> b) {
      if (a[0] != b[0]) {
        return a[0] - b[0];
      } else {
        return a[1] - b[1];
      }
    });

    List<List<int>> res = [];
    for (List<int> mid in points) {
      //mid[0] and mid[1]
      if (res.length == 0) {
        res.add(mid);
      } else {
        List<int> temp = res[res.length - 1];
        if (mid[0] <= temp[1]) {
          // value equal is represent interact each other
          temp[0] = max(temp[0], mid[0]);
          temp[1] = min(temp[1], mid[1]);
          res[res.length - 1] = temp;
        } else {
          res.add(mid);
        }
      }
    }
    return res.length;
  }
}
```
