/*


 -* 3Sum Closest *-

Given an integer array nums of length n and an integer target, find three integers in nums such that the sum is closest to target.

Return the sum of the three integers.

You may assume that each input would have exactly one solution.



Example 1:

Input: nums = [-1,2,1,-4], target = 1
Output: 2
Explanation: The sum that is closest to the target is 2. (-1 + 2 + 1 = 2).
Example 2:

Input: nums = [0,0,0], target = 1
Output: 0
Explanation: The sum that is closest to the target is 0. (0 + 0 + 0 = 0).


Constraints:

3 <= nums.length <= 1000
-1000 <= nums[i] <= 1000
-104 <= target <= 104


*/

class A {
  // TLC
  int getClose(int idx, int target, List<int> nums) {
    int n = nums.length, l = idx, r = n - 1;
    int resClosest = nums[idx] + nums[n - 1];

    while (l < r) {
      int curSum = nums[l] + nums[r];
      if (curSum == target) return target;
      if (curSum > target)
        r--;
      else
        l++;
      if ((target - curSum).abs() < (target - resClosest).abs())
        resClosest = curSum;
    }

    return resClosest;
  }

  int threeSumClosest(List<int> nums, int target) {
    nums.sort();
    int res = nums[0] + nums[1] + nums[2], n = nums.length;
    for (int i = 0; i < n - 2; i++) {
      int current = getClose(i + 1, target - nums[i], nums) + nums[i];
      if ((target - current).abs() < (target - res).abs()) res = current;
    }
    return res;
  }
}

class B {
// Runtime: 458 ms, faster than 75.00% of Dart online submissions for 3Sum Closest.
// Memory Usage: 162.3 MB, less than 25.00% of Dart online submissions for 3Sum Closest.
  int threeSumClosest(List<int> nums, int target) {
    int ans = 1e6.toInt();
    int n = nums.length;

    nums.sort();
    for (int i = 0; i < n - 2; i++) {
      int j = i + 1, k = n - 1;
      while (j < k) {
        int sum = nums[i] + nums[j] + nums[k];
        if (sum == target)
          return target;
        else if (sum > target) {
          k--;
        } else {
          j++;
        }
        if ((sum - target).abs() < (ans - target).abs()) ans = sum;
      }
    }
    return ans;
  }
}

class C {
  // TLC
  int threeSumClosest(List<int> nums, int target) {
    int diff = 1e6.toInt();
    int ans = 0;
    for (int i = 0; i < nums.length; i++) {
      for (int j = i + 1; j < nums.length; j++) {
        for (int k = j + 1; k < nums.length; k++) {
          int val = nums[i] + nums[j] + nums[k];
          if ((val - target).abs() < diff) {
            diff = (val - target).abs();
            ans = val;
          }
        }
      }
    }
    return ans;
  }
}
