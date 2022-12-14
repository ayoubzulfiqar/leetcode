/*

-* 198. House Robber *-



You are a professional robber planning to rob houses along a street. Each house has a certain amount of money stashed, the only constraint stopping you from robbing each of them is that adjacent houses have security systems connected and it will automatically contact the police if two adjacent houses were broken into on the same night.

Given an integer array nums representing the amount of money of each house, return the maximum amount of money you can rob tonight without alerting the police.

 

Example 1:

Input: nums = [1,2,3,1]
Output: 4
Explanation: Rob house 1 (money = 1) and then rob house 3 (money = 3).
Total amount you can rob = 1 + 3 = 4.
Example 2:

Input: nums = [2,7,9,3,1]
Output: 12
Explanation: Rob house 1 (money = 2), rob house 3 (money = 9) and rob house 5 (money = 1).
Total amount you can rob = 2 + 9 + 1 = 12.
 

Constraints:

1 <= nums.length <= 100
0 <= nums[i] <= 400

*/

import 'dart:collection';
import 'dart:math';

class A {
  int rob(List<int> nums) {
    int previous = 0;
    int last = 0;
    for (int current in nums) {
      last = max(previous + current, previous = last);
    }
    return last;
  }
}

class B {
  int rob(List<int> nums) {
    //max money can get if rob current house
    int rob = 0;
    //max money can get if not rob current house
    int notRob = 0;
    for (int i = 0; i < nums.length; i++) {
      //if rob current value, previous house must not be robbed
      int curRob = notRob + nums[i];
      //if not rob ith house, take the max value of robbed (i-1)th house and not rob (i-1)th house
      notRob = max(notRob, rob);
      rob = curRob;
    }
    return max(rob, notRob);
  }
}

class C {
  HashMap<int, int> map = HashMap();
  int rob(List<int> nums) {
    if (nums.length == 0) return 0;
    map[nums.length] = 0;
    return tryRob(nums, 0);
  }

  int tryRob(List<int> nums, int idx) {
    if (map.containsKey(idx)) return map[idx] ?? 0;

    late int maxi;
    if (nums.length - idx == 1) {
      maxi = nums[nums.length - 1];
      map[idx] = maxi;
    } else if (nums.length - idx == 2) {
      maxi = max(nums[nums.length - 1], nums[nums.length - 2]);
      map[idx] = maxi;
    } else {
      maxi = max(nums[idx] + tryRob(nums, idx + 2),
          nums[idx + 1] + tryRob(nums, idx + 3));
      map[idx] = maxi;
    }
    return maxi;
  }
}
