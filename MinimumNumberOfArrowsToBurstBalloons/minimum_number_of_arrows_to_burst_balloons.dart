/*

*- 452. Minimum Number of Arrows to Burst Balloons -*



There are some spherical balloons taped onto a flat wall that represents the XY-plane. The balloons are represented as a 2D integer array points where points[i] = [x-start, x-end] denotes a balloon whose horizontal diameter stretches between x-start and x-end. You do not know the exact y-coordinates of the balloons.

Arrows can be shot up directly vertically (in the positive y-direction) from different points along the x-axis. A balloon with x-start and x-end is burst by an arrow shot at x if x-start <= x <= x-end. There is no limit to the number of arrows that can be shot. A shot arrow keeps traveling up infinitely, bursting any balloons in its path.

Given the array points, return the minimum number of arrows that must be shot to burst all balloons.

 

Example 1:

Input: points = [[10,16],[2,8],[1,6],[7,12]]
Output: 2
Explanation: The balloons can be burst by 2 arrows:
- Shoot an arrow at x = 6, bursting the balloons [2,8] and [1,6].
- Shoot an arrow at x = 11, bursting the balloons [10,16] and [7,12].
Example 2:

Input: points = [[1,2],[3,4],[5,6],[7,8]]
Output: 4
Explanation: One arrow needs to be shot for each balloon for a total of 4 arrows.
Example 3:

Input: points = [[1,2],[2,3],[3,4],[4,5]]
Output: 2
Explanation: The balloons can be burst by 2 arrows:
- Shoot an arrow at x = 2, bursting the balloons [1,2] and [2,3].
- Shoot an arrow at x = 4, bursting the balloons [3,4] and [4,5].
 

Constraints:

1 <= points.length <= 105
points[i].length == 2
-231 <= x-start < x-end <= 231 - 1


*/

import 'dart:math';

/*


Idea:
We know that eventually we have to shoot down every balloon, so for each ballon there must be an arrow whose position is between balloon[0] and balloon[1] inclusively. Given that, we can sort the array of balloons by their ending position. Then we make sure that while we take care of each balloon in order, we can shoot as many following balloons as possible.

So what position should we pick each time? We should shoot as to the right as possible, because since balloons are sorted, this gives you the best chance to take down more balloons. Therefore the position should always be balloon[i][1] for the ith balloon.

This is exactly what I do in the for loop: check how many balloons I can shoot down with one shot aiming at the ending position of the current balloon. Then I skip all these balloons and start again from the next one (or the leftmost remaining one) that needs another arrow.

Example:

balloons = [[7,10], [1,5], [3,6], [2,4], [1,4]]
After sorting, it becomes:

balloons = [[2,4], [1,4], [1,5], [3,6], [7,10]]
So first of all, we shoot at position 4, we go through the array and see that all first 4 balloons can be taken care of by this single shot. Then we need another shot for one last balloon. So the result should be 2.


*/

class A {
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

class B {
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
