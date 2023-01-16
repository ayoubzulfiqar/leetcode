/*


-* 57. Insert Interval *-

You are given an array of non-overlapping intervals intervals where intervals[i] = [start-i, end-i] represent the start and the end of the ith interval and intervals is sorted in ascending order by start-i. You are also given an interval newInterval = [start, end] that represents the start and end of another interval.

Insert newInterval into intervals such that intervals is still sorted in ascending order by start-i and intervals still does not have any overlapping intervals (merge overlapping intervals if necessary).

Return intervals after the insertion.

 

Example 1:

Input: intervals = [[1,3],[6,9]], newInterval = [2,5]
Output: [[1,5],[6,9]]
Example 2:

Input: intervals = [[1,2],[3,5],[6,7],[8,10],[12,16]], newInterval = [4,8]
Output: [[1,2],[3,10],[12,16]]
Explanation: Because the new interval [4,8] overlaps with [3,5],[6,7],[8,10].
 

Constraints:

0 <= intervals.length <= 104
intervals[i].length == 2
0 <= start-i <= end-i <= 105
intervals is sorted by start-i in ascending order.
newInterval.length == 2
0 <= start <= end <= 105

*/

import 'dart:math';

class A {
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

class B {
  List<List<int>> insert(List<List<int>> intervals, List<int> newInterval) {
    List<List<int>> ans = [];
    List<int> toAdd = newInterval;
    for (int i = 0; i < intervals.length; i++) {
      if (intervals[i][0] > toAdd[1]) {
        ans.add(toAdd);
        toAdd = intervals[i];
      } else if (intervals[i][1] >= toAdd[0])
        toAdd = [
          min(intervals[i][0], toAdd[0]),
          max(intervals[i][1], toAdd[1])
        ];
      else
        ans.add(intervals[i]);
    }
    ans.add(toAdd);
    return List.filled(ans.length, 0).map((e) => List.filled(2, 0)).toList();
  }
  // List.filled(res.length, 0).map((e) => List.filled(2, 0)).toList();
}

class C {
  List<List<int>> insert(List<List<int>> intervals, List<int> newInterval) {
    List<List<int>> ans = [];
    int idx = 0;
    while (idx < intervals.length && intervals[idx][0] < newInterval[0]) {
      ans.add(intervals[idx++]);
    }
    if (ans.length == 0 || newInterval[0] > ans.elementAt(ans.length - 1)[1]) {
      ans.add(newInterval);
    } else {
      List<int> lastInterval = ans.elementAt(ans.length - 1);
      lastInterval[1] = max(lastInterval[1], newInterval[1]);
    }
    while (idx < intervals.length) {
      List<int> lastInterval = ans.elementAt(ans.length - 1);
      if (lastInterval[1] >= intervals[idx][0]) {
        lastInterval[1] = max(lastInterval[1], intervals[idx++][1]);
      } else
        ans.add(intervals[idx++]);
    }
    return List.filled(ans.length, 0).map((e) => <int>[]).toList();
    // return ans.toArray(new int[ans.size()][]);
  }
}
