/*



-* 1027. Longest Arithmetic Subsequence *-


Given an array nums of integers, return the length of the longest arithmetic subsequence in nums.

Note that:

A subsequence is an array that can be derived from another array by deleting some or no elements without changing the order of the remaining elements.
A sequence seq is arithmetic if seq[i + 1] - seq[i] are all the same value (for 0 <= i < seq.length - 1).
 

Example 1:

Input: nums = [3,6,9,12]
Output: 4
Explanation:  The whole array is an arithmetic sequence with steps of length = 3.
Example 2:

Input: nums = [9,4,7,2,10]
Output: 3
Explanation:  The longest arithmetic subsequence is [4,7,10].
Example 3:

Input: nums = [20,1,15,3,10,5,8]
Output: 4
Explanation:  The longest arithmetic subsequence is [20,15,10,5].
 

Constraints:

2 <= nums.length <= 1000
0 <= nums[i] <= 500

*/

import 'dart:collection';
import 'dart:math';

class Solution {
  int longestArithSeqLength(List<int> nums) {
    int n = nums.length;
    if (n <= 2) return n;

    int longest = 2;
    List<HashMap<int, int>> dp =
        List<HashMap<int, int>>.generate(n, (index) => HashMap<int, int>());

    for (int i = 0; i < n; i++) {
      for (int j = 0; j < i; j++) {
        int diff = nums[i] - nums[j];
        dp[i][diff] = dp[j].containsKey(diff) ? dp[j][diff]! + 1 : 2;
        longest = longest > dp[i][diff]! ? longest : dp[i][diff]!;
      }
    }

    return longest;
  }
}

class B {
  int longestArithSeqLength(List<int> nums) {
    int n = nums.length;
    int max = 0;
    List<List<int>> dp = List.generate(n, (i) => List<int>.filled(1001, 0));

    for (int i = 1; i < n; i++) {
      for (int j = 0; j < i; j++) {
        int diff = nums[j] - nums[i] + 500;
        dp[i][diff] = dp[j][diff] + 1;
        max = max < dp[i][diff] ? dp[i][diff] : max;
      }
    }
    return max + 1;
  }
}

class C {
  int longestArithSeqLength(List<int> nums) {
    Map<int, List<int>> hash = {};
    for (int i = 0; i < nums.length; i++) {
      if (!hash.containsKey(nums[i])) {
        hash[nums[i]] = [];
      }
      hash[nums[i]]!.add(i);
    }
    int maxCount = 0;
    for (int i = 0; i < nums.length; i++) {
      for (int j = i + 1; j < nums.length; j++) {
        int d = nums[j] - nums[i], ls = nums[j], cnt = 2, li = j;
        while (ls >= 0) {
          List<int>? v = hash[ls + d];
          if (d == 0) {
            cnt = v!.length;
            break;
          }
          if (v != null && v.length > 0) {
            int ind = v.indexOf(li);
            if (ind >= 0 && ind < v.length) {
              cnt++;
              ls += d;
              li = v[ind];
            } else {
              break;
            }
          } else {
            break;
          }
        }
        maxCount = max(maxCount, cnt);
      }
    }
    return maxCount;
  }
}
