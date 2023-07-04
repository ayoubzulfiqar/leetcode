/*



-* 137. Single Number II *-


Given an integer array nums where every element appears three times except for one, which appears exactly once. Find the single element and return it.

You must implement a solution with a linear runtime complexity and use only constant extra space.

 

Example 1:

Input: nums = [2,2,3,2]
Output: 3
Example 2:

Input: nums = [0,1,0,1,0,1,99]
Output: 99
 

Constraints:

1 <= nums.length <= 3 * 104
-231 <= nums[i] <= 231 - 1
Each element in nums appears exactly three times except for one element which appears once.

*/

import 'dart:collection';

class A {
  int singleNumber(List<int> nums) {
    HashMap<int, int> map = HashMap<int, int>();

    for (int x in nums) {
      map[x] = (map[x] ?? 0) + 1;
    }

    for (MapEntry entry in map.entries) {
      if (entry.value == 1) {
        return entry.key;
      }
    }

    return -1;
  }
}

class B {
  int singleNumber(List<int> nums) {
    int ans = 0;

    for (int i = 0; i < 32; ++i) {
      int sum = 0;
      for (final int number in nums) {
        sum += (number >> i) & 1;
      }
      sum %= 3;
      ans |= (sum << i);
    }

    // Handle negative numbers
    if ((ans & (1 << 31)) != 0) {
      ans = -(1 << 31) | (ans & ((1 << 31) - 1));
    }

    return ans;
  }
}

class C {
  int singleNumber(List<int> nums) {
    int ones = 0;
    int twos = 0;

    for (int i = 0; i < nums.length; i++) {
      final int number = nums[i];
      ones ^= (number & ~twos);
      twos ^= (number & ~ones);
    }

    return ones;
  }
}
