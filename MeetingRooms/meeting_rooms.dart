/*

 -* Meeting Rooms *-


Given an array of meeting time intervals consisting of start and end times[[s1,e1],[s2,e2],...](si< ei), determine if a person could attend all meetings.
Example 1:
Input:
[[0,30],[5,10],[15,20]]
Output:
 false
Example 2:
Input:
 [[7,10],[2,4]]

Output:
 true

*/

// Definition for an interval.
//import 'dart:core';

class Interval {
  int start;
  int end;

  Interval([this.start = 0, this.end = 0]);
  Interval.copy(int s, int e)
      : this.start = s,
        this.end = e;
}

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

class B {
  bool canAttendMeetings(List<Interval> intervals) {
    intervals.sort(
      (a, b) => a.start - b.start,
    );
    for (int i = 1; i < intervals.length; i++)
      if (intervals[i - 1].end > intervals[i].start) return false;
    return true;
  }
}
