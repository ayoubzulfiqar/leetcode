# A

## Solution

```dart
class Solution {
  bool doesIntersect(List<int> intervalA, List<int> intervalB) {
    return intervalA[0] <= intervalB[1] && intervalB[0] <= intervalA[1];
  }

  List<List<int>> insert(List<List<int>> intervals, List<int> newInterval) {
    List<List<int>> mergedIntervals = [];
    List<int> merged = [newInterval[0], newInterval[1]];
    bool isInserted = false;

    for (List<int> interval in intervals) {
      if (interval[0] > merged[1]) {
        if (!isInserted) {
          mergedIntervals.add(merged);
          isInserted = true;
        }
        mergedIntervals.add(interval);
      } else {
        // does intersect
        if (doesIntersect(merged, interval)) {
          merged[0] = min(merged[0], interval[0]);
          merged[1] = max(merged[1], interval[1]);
        } else {
          // not intersecting
          mergedIntervals.add(interval);
        }
      }
    }

    // new interval is at the end
    if (!isInserted) {
      mergedIntervals.add(merged);
      isInserted = true;
    }

    // Java specific to copy to arr[][]...
    List.filled(mergedIntervals.length, 0).map((e) => List.filled(2, 0));
    List<List<int>> res = List.filled(mergedIntervals.length, 0)
        .map((e) => List.filled(2, 0))
        .toList();
    for (int i = 0; i < mergedIntervals.length; i++) {
      res[i] = mergedIntervals.elementAt(i);
    }
    return res;
  }
}
```
