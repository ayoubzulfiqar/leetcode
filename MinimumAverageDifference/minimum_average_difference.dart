/*


-* 2256. Minimum Average Difference *-

You are given a 0-indexed integer array nums of length n.

The average difference of the index i is the absolute difference between the average of the first i + 1 elements of nums and the average of the last n - i - 1 elements. Both averages should be rounded down to the nearest integer.

Return the index with the minimum average difference. If there are multiple such indices, return the smallest one.

Note:

The absolute difference of two numbers is the absolute value of their difference.
The average of n elements is the sum of the n elements divided (integer division) by n.
The average of 0 elements is considered to be 0.
 

Example 1:

Input: nums = [2,5,3,9,5,3]
Output: 3
Explanation:
- The average difference of index 0 is: |2 / 1 - (5 + 3 + 9 + 5 + 3) / 5| = |2 / 1 - 25 / 5| = |2 - 5| = 3.
- The average difference of index 1 is: |(2 + 5) / 2 - (3 + 9 + 5 + 3) / 4| = |7 / 2 - 20 / 4| = |3 - 5| = 2.
- The average difference of index 2 is: |(2 + 5 + 3) / 3 - (9 + 5 + 3) / 3| = |10 / 3 - 17 / 3| = |3 - 5| = 2.
- The average difference of index 3 is: |(2 + 5 + 3 + 9) / 4 - (5 + 3) / 2| = |19 / 4 - 8 / 2| = |4 - 4| = 0.
- The average difference of index 4 is: |(2 + 5 + 3 + 9 + 5) / 5 - 3 / 1| = |24 / 5 - 3 / 1| = |4 - 3| = 1.
- The average difference of index 5 is: |(2 + 5 + 3 + 9 + 5 + 3) / 6 - 0| = |27 / 6 - 0| = |4 - 0| = 4.
The average difference of index 3 is the minimum average difference so return 3.
Example 2:

Input: nums = [0]
Output: 0
Explanation:
The only index is 0 so return 0.
The average difference of index 0 is: |0 / 1 - 0| = |0 - 0| = 0.
 

Constraints:

1 <= nums.length <= 105
0 <= nums[i] <= 105





*/

import 'dart:math';

class A {
  int minimumAverageDifference(List<int> nums) {
    int ans = 0, n = nums.length, mi = double.maxFinite.toInt();
    // since we need the sum for first i + 1 and last n - i - 1 elements
    // we can pre-calculate it first
    // it is called prefix sum and suffix sum
    List<int> pref = List.filled(n, 0);
    // prev[0] is the first element
    pref[0] = nums[0];
    // starting from i = 1, pref[i] is the sum + the current element
    for (int i = 1; i < n; i++) pref[i] = pref[i - 1] + nums[i];
    // then we can iterate each number
    for (int i = 0; i < n; i++) {
      // now we know the prefix sum
      // the suffix sum is simply pref[n - 1] - pref[i]
      int k = ((pref[i] ~/ (i + 1)) -
              ((pref[n - 1] - pref[i]) ~/ max(n - i - 1, 1)))
          .abs();
      // check the min and update ans
      if (k < mi) {
        mi = k;
        ans = i;
      }
    }
    return ans;
  }
}

class B {
  int minimumAverageDifference(List<int> nums) {
    int n = nums.length;

    int sum = 0;
    for (int num in nums) sum += num;

    int minDiff = double.maxFinite.toInt();
    int leftSum = 0;
    int rightSum = sum;
    int ans = 0;

    for (int i = 0; i < n; i++) {
      leftSum += nums[i];
      rightSum -= nums[i];
      int lAvg = leftSum ~/ (i + 1);
      int rAvg = (n - 1 - i) != 0 ? rightSum ~/ (n - 1 - i) : rightSum;
      int diff = (lAvg - rAvg).abs();
      if (diff == 0) return i;
      if (diff < minDiff) {
        minDiff = diff;
        ans = i;
      }
    }

    return ans;
  }
}

class C {
  int minimumAverageDifference(List<int> nums) {
    // if there is only one element then itself would be the ans (index 0).
    if (nums.length == 1) return 0;

    // finding total sum of vector (using int int to prevent overflow)
    int sum = 0;
    for (int a in nums) {
      sum += a;
    }

    //initially left side sum will be zero and right side sum will be total sum
    int leftSum = 0;
    int rightSum = sum;

    // this will be used to keep track of minimum
    int avgDiff;
    int mini = -1;
    int minIndex = -1;
    int n = nums.length;

    for (int i = 0; i < n - 1; i++) {
      // increasing left sum and decreasing right sum
      leftSum += nums[i];
      rightSum -= nums[i];

      // finding avgDiff ,  (here (n-i-1) represents element count in right part, ans (i+1) in left part)
      avgDiff = ((leftSum ~/ (i + 1)) - (rightSum ~/ (n - i - 1))).abs();

      //updating mini
      if (mini == -1) {
        mini = avgDiff;
        minIndex = i;
      } else if (mini > avgDiff) {
        mini = avgDiff;
        minIndex = i;
      }
    }

    // check for last element
    avgDiff = sum ~/ n;
    if (mini > avgDiff) {
      mini = avgDiff;
      minIndex = n - 1;
    }
    return minIndex;
  }
}
