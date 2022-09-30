/*

-* Majority Element *-


Given an array nums of size n, return the majority element.

The majority element is the element that appears more than ⌊n / 2⌋ times.
You may assume that the majority element always exists in the array.



Example 1:

Input: nums = [3,2,3]
Output: 3
Example 2:

Input: nums = [2,2,1,1,1,2,2]
Output: 2


Constraints:

n == nums.length
1 <= n <= 5 * 104
-109 <= nums[i] <= 109


Follow-up: Could you solve the problem in linear time and in O(1) space?


*/

class A {
// Runtime: 512 ms, faster than 58.33% of Dart online submissions for Majority Element.
// Memory Usage: 147.1 MB, less than 66.67% of Dart online submissions for Majority Element.

  int majorityElement(List<int> nums) {
    int n = nums.length;
    int majEle = nums[0];
    int count = 1;

    for (int i = 1; i < n; i++) {
      if (nums[i] == majEle) {
        count++;
      } else {
        count--;
        if (count == 0) {
          majEle = nums[i];
          count = 1;
        }
      }
    }

    return majEle;
  }
}

class B {
  int majorityElement(List<int> nums) {
    Map<int, int> counter = {};
    for (int x in nums) {
      // null  error i will fix soon
      if (counter[x++] == null && counter[x++]! > nums.length ~/ 2) {
        return x;
      }
    }
    return 0;
  }
}

class C {
// Runtime: 505 ms, faster than 61.11% of Dart online submissions for Majority Element.
// Memory Usage: 146.7 MB, less than 94.44% of Dart online submissions for Majority Element.
  int majorityElement(List<int> nums) {
    int major = nums[0], count = 1;
    for (int i = 1; i < nums.length; i++) {
      if (count == 0) {
        count++;
        major = nums[i];
      } else if (major == nums[i]) {
        count++;
      } else
        count--;
    }
    return major;
  }
}
