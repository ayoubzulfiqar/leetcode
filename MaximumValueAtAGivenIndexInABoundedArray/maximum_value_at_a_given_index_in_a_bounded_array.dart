/*


-* 1802. Maximum Value at a Given Index in a Bounded Array *-


You are given three positive integers: n, index, and maxSum. You want to construct an array nums (0-indexed) that satisfies the following conditions:

nums.length == n
nums[i] is a positive integer where 0 <= i < n.
abs(nums[i] - nums[i+1]) <= 1 where 0 <= i < n-1.
The sum of all the elements of nums does not exceed maxSum.
nums[index] is maximized.
Return nums[index] of the constructed array.

Note that abs(x) equals x if x >= 0, and -x otherwise.

 

Example 1:

Input: n = 4, index = 2,  maxSum = 6
Output: 2
Explanation: nums = [1,2,2,1] is one array that satisfies all the conditions.
There are no arrays that satisfy all the conditions and have nums[2] == 3, so 2 is the maximum nums[2].
Example 2:

Input: n = 6, index = 1,  maxSum = 10
Output: 3
 

Constraints:

1 <= n <= maxSum <= 109
0 <= index < n



*/

import 'dart:math';

class A {
  int maxValue(int n, int index, int maxSum) {
    maxSum -= n;
    int left = 0, right = maxSum;
    while (left < right) {
      int mid = (left + right + 1) ~/ 2;
      if (check(mid, index, n) <= maxSum) {
        left = mid;
      } else {
        right = mid - 1;
      }
    }
    return left + 1;
  }

  int check(int a, int index, int n) {
    int leftOffset = (a - index).clamp(0, a);
    int result = (a + leftOffset) * (a - leftOffset + 1) ~/ 2;
    int rightOffset = (a - ((n - 1) - index)).clamp(0, a);
    result += (a + rightOffset) * (a - rightOffset + 1) ~/ 2;
    return result - a;
  }
}

class B {
  int maxValue(int n, int index, int maxSum) {
    maxSum -= n;
    int left = index + 1;
    int right = n - index;

    int small = min(left, right);
    int large = max(left, right);

    int a = s(large, large) + s(large, small) - large;
    if (maxSum >= a) {
      return large + (maxSum - a) ~/ n + 1;
    }
    int b = s(small, small) * 2 - small;
    if (maxSum >= b) {
      return small + findExtra(small * 2, 1, maxSum - b) + 1;
    }
    return findExtra(1, 2, maxSum) + 1;
  }

  int s(int h, int l) {
    return (2 * h - l + 1) * l ~/ 2;
  }

  int findExtra(int start, int increment, int max_sum) {
    int b = start * 2 ~/ increment - 1;
    int c = 2 * max_sum ~/ increment;

    int d = sqrt(b * b + 4 * c).toInt();
    int n = (d - b) ~/ 2;
    return n;
  }
}

class C {
  int maxValue(int n, int index, int maxSum) {
    if (n == 1) return maxSum;
    maxSum -= n;
    int left = index, right = n - index - 1, ans = 1;

    int t1 = -1, t2 = -1;
    while (maxSum > 0) {
      t1++;
      t2++;
      double x = min(t1, left) + min(t2, right) + 1;

      if (maxSum < x) break;
      maxSum -= x.toInt();
      ans++;

      if (x == (left + right + 1)) {
        ans += (maxSum ~/ x);
        break;
      }
    }
    return ans;
  }
}
