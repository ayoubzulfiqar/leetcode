/*

-* 2366. Minimum Replacements to Sort the Array *-

You are given a 0-indexed integer array nums. In one operation you can replace any element of the array with any two elements that sum to it.

For example, consider nums = [5,6,7]. In one operation, we can replace nums[1] with 2 and 4 and convert nums to [5,2,4,7].
Return the minimum number of operations to make an array that is sorted in non-decreasing order.

 

Example 1:

Input: nums = [3,9,3]
Output: 2
Explanation: Here are the steps to sort the array in non-decreasing order:
- From [3,9,3], replace the 9 with 3 and 6 so the array becomes [3,3,6,3]
- From [3,3,6,3], replace the 6 with 3 and 3 so the array becomes [3,3,3,3,3]
There are 2 steps to sort the array in non-decreasing order. Therefore, we return 2.

Example 2:

Input: nums = [1,2,3,4,5]
Output: 0
Explanation: The array is already in non-decreasing order. Therefore, we return 0. 
 

Constraints:

1 <= nums.length <= 105
1 <= nums[i] <= 109


*/

class Solution {
  int minimumReplacement(List<int> nums) {
    int ans = 0;
    for (int i = nums.length - 2; i >= 0; i--) {
      if (nums[i] > nums[i + 1]) {
        final int temp = ((nums[i] + nums[i + 1] - 1) ~/ nums[i + 1]);
        ans += temp - 1;
        nums[i] = nums[i] ~/ temp;
      }
    }

    return ans;
  }
}

//-----------

class A {
  int minimumReplacement(List<int> nums) {
    int n = nums.length;

    if (n == 1) {
      return 0;
    }

    return helper(n - 1, nums, 0, n);
  }

  int helper(int index, List<int> nums, int min, int n) {
    if (index == n - 1) {
      return helper(index - 1, nums, nums[index], n);
    } else {
      int ec = 0;
      if (nums[index] > min) {
        if (nums[index] % min == 0) {
          ec = nums[index] ~/ min;
        } else {
          ec = nums[index] ~/ min + 1;
        }

        int nMin = nums[index] ~/ ec;
        int lc = ec;

        if (index == 0) {
          return lc - 1;
        } else {
          return lc - 1 + helper(index - 1, nums, nMin, n);
        }
      } else {
        if (index == 0) {
          return 0;
        } else {
          return helper(index - 1, nums, nums[index], n);
        }
      }
    }
  }
}
