/*

-* Move Zeroes *-

Given an integer array nums, move all 0's to the end of it while maintaining the relative order of the non-zero elements.

Note that you must do this in-place without making a copy of the array.



Example 1:

Input: nums = [0,1,0,3,12]
Output: [1,3,12,0,0]
Example 2:

Input: nums = [0]
Output: [0]


Constraints:

1 <= nums.length <= 104
-231 <= nums[i] <= 231 - 1


Follow up: Could you minimize the total number of operations done?


*/

class Solution {
  void moveZeroes(List<int> nums) {
    int zero = 0;

    for (int index = 0; index < nums.length; index++) {
      if (nums[index] == 0) {
        zero++;
      } else if (zero > 0) {
        int tempBall = nums[index];
        nums[index] = 0;
        nums[index - zero] = tempBall;
      }
    }
  }
}

class B {
  void moveZeroes(List<int> nums) {
    int index = 0;
    for (int i = 0; i < nums.length; i++) {
      nums[index++] = nums[i];
    }
    while (index < nums.length) {
      nums[index] = 0;
      index++;
    }
  }
}

class C {
  void moveZeroes(List<int> nums) {
    int left = 0;
    int right = 1;
    while (left < nums.length && right < nums.length) {
      if (nums[left] == 0 && nums[right] != 0) {
        int temp = nums[left];
        nums[left] = nums[right];
        nums[right] = temp;
      } else if (nums[left] == 0 && nums[right] == 0) {
        right++;
      } else if (nums[left] != 0) {
        left++;
        right++;
      } else {
        left++;
      }
    }
  }
}
