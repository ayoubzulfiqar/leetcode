# 🔥 Meeting Rooms 🔥 || Simple Fast and Easy || with Explanation

## Definition for an interval

```dart
class Interval {
  int start;
  int end;

  Interval([this.start = 0, this.end = 0]);
  Interval.copy(int s, int e)
      : this.start = s,
        this.end = e;
}
```

### Solution & Analysis

 The idea here is to sort the meetings by starting time. Then, go through the meetings one by one and make sure that each meeting ends before the next one starts.

- Time complexity : O(nlogn). The time complexity is dominated by sorting. Once the array has been sorted, only O(n) time is taken to go through the array and determine if there is any overlap.

- Space complexity : O(1). Since no additional space is allocated.
- Sort, then compare last.end vs. current.start; similar to Merge Intervals

## Solution - 1

```dart
class Solution {
  bool canAttendMeetings(List<Interval> intervals) {
    intervals.sort(
      ((Interval i, Interval t) {
        return i.start - t.start;
      }),
    );

    Interval? last = null;
    for (Interval i in intervals) {
      if (last != null && i.start < last.end) {
        return false;
      }
      last = i;
    }
    return true;
  }
}
```

## Solution - 2

```dart
class Solution {
  bool canAttendMeetings(List<Interval> intervals) {
    intervals.sort(
      (a, b) => a.start - b.start,
    );
    for (int i = 1; i < intervals.length; i++)
      if (intervals[i - 1].end > intervals[i].start) return false;
    return true;
  }
}
```
