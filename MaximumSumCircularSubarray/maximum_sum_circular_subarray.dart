/*


-* 918. Maximum Sum Circular SubArray *-

Given a circular integer array nums of length n, return the maximum possible sum of a non-empty sub-array of nums.

A circular array means the end of the array connects to the beginning of the array. Formally, the next element of nums[i] is nums[(i + 1) % n] and the previous element of nums[i] is nums[(i - 1 + n) % n].

A sub-array may only include each element of the fixed buffer nums at most once. Formally, for a sub-array nums[i], nums[i + 1], ..., nums[j], there does not exist i <= k1, k2 <= j with k1 % n == k2 % n.

 

Example 1:

Input: nums = [1,-2,3,-2]
Output: 3
Explanation: Sub-array [3] has maximum sum 3.
Example 2:

Input: nums = [5,-3,5]
Output: 10
Explanation: Sub-array [5,5] has maximum sum 5 + 5 = 10.
Example 3:

Input: nums = [-3,-2,-3]
Output: -2
Explanation: Sub-array [-2] has maximum sum -2.
 

Constraints:

n == nums.length
1 <= n <= 3 * 104
-3 * 104 <= nums[i] <= 3 * 104

*/

import 'dart:math';

class A {
  int maxSubarraySumCircular(List<int> nums) {
    // max = int_min
    int totalSum = 0, maxSum = -30012, curMax = 0, minSum = 30012, curMin = 0;
    for (int x in nums) {
      curMax = max(x, curMax + x); //update the current max sub-array sum
      maxSum = max(maxSum, curMax); //update the overall max sub-array sum
      curMin = min(x, curMin + x); //update the current min sub-array sum
      minSum = min(minSum, curMin); //update the overall min sub-array sum
      totalSum += x;
    }
    return maxSum > 0 ? max(maxSum, totalSum - minSum) : maxSum;
  }
}

class B {
  int kadane(List<int> nums) {
    int local = nums[0];
    int global = nums[0];
    for (int i = 1; i < nums.length; i++) {
      local = max(nums[i], local + nums[i]);
      global = max(global, local);
    }
    return global;
  }
  // case 1: max subarray sum in [0 .. n - 1]
  // i.e. kadane's algo
  // case 2. circular subarray in [0 .. |  n - 1 .. | .. 2 * n - 1]
  // i.e. total sum - min subarray sum in [0 .. n - 1]

  int maxSubarraySumCircular(List<int> nums) {
    int n = nums.length;
    // use kadane's algo to find out max sub array sum (case 1)
    int maxSubArraySum = kadane(nums);
    // handle cases like [-3,-2,-3]
    if (maxSubArraySum < 0) return maxSubArraySum;
    // calculate the total sum
    int totalSum = 0;
    // in order to use the same kadane function, we flip the sign
    for (int i = 0; i < n; i++) {
      totalSum += nums[i];
      nums[i] = -nums[i];
    }
    // use kadane's algo to find out min sub array sum
    int minSubArraySum = kadane(nums);
    // compare case 1 & case 2, take the max
    return max(maxSubArraySum, totalSum + minSubArraySum);
  }
}
