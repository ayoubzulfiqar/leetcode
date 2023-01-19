/*

-* 974. Sub-array Sums Divisible by K *-


Given an integer array nums and an integer k, return the number of non-empty subarrays that have a sum divisible by k.

A subarray is a contiguous part of an array.

 

Example 1:

Input: nums = [4,5,0,-2,-3,1], k = 5
Output: 7
Explanation: There are 7 subarrays with a sum divisible by k = 5:
[4, 5, 0, -2, -3, 1], [5], [5, 0], [5, 0, -2, -3], [0], [0, -2, -3], [-2, -3]
Example 2:

Input: nums = [5], k = 9
Output: 0
 

Constraints:

1 <= nums.length <= 3 * 104
-104 <= nums[i] <= 104
2 <= k <= 104

*/

import 'dart:collection';

class A {
  int subarraysDivByK(List<int> nums, int k) {
    // Use the HashMap to record the frequency of all the prefix sum remainders.
    HashMap<int, int> map = HashMap();
    // Note that the integer in 'nums' can be negative.
    // Thus, we need to adjust the negative remainder to positive remainder.
    // Below accounts for both negative and positive remainders.
    // We can also check if the remainder is negative, then add a 'k' to make the remainder positive.
    // For Example, nums = [-2,3,2], k = 5,
    // remainder for the prefix sum of [-2,1,3] are -2, 1 and 3 respectively.
    // We know that [3,2] sum to 5, which is divisible by 5.
    // After converting -2 to 3, by adding 5, it has the same remainder with prefix sum 3.
    for (int i = 0, remainder; i < nums.length; i++) {
      if (i > 0) nums[i] += nums[i - 1];
      remainder = (nums[i] % k + k) % k;
      map[remainder] = (map[remainder] ?? 0) + 1;
    }
    // The result contains all the prefix sum with remainder 0,
    // as all the prefix sum with remainder of 0 is itself divisible by 'k'.
    // However, do note that the prefix sum with remainder 0 also able to form sub-array sums that is divisible by 'k'
    // with one another, which will be calculated next.
    // For Example: nums = [5,5,5,5], k = 5,
    // The prefix sum of [5,10,15,20] are themselves divisible by 5, while also forming sub-array sums divisible by 5
    // with 10 [5,5] - 5 [5] == 5, 15 [5,5,5] - 5 [5] == 10, etc.
    int result = (map[0] ?? 0);
    // The prefix sums with the same remainder can form sub-array sums that is divisible by 'k' with each other.
    // For each remainder, the number of sub-array that is divisible by 'k' is the number of combinations from the frequency.
    // Equation for the number of combinations of n items is n * "(n - 1) / 2".
    for (int frequency in map.values)
      result += frequency * (frequency - 1) ~/ 2;
    return result;
  }
}

class B {
  int subarraysDivByK(List<int> nums, int k) {
    // Use counting array to record the frequency of all the prefix sum remainders.
    List<int> counting = List.filled(k, 0);
    for (int i = 0; i < nums.length; i++) {
      if (i > 0) nums[i] += nums[i - 1];
      // Note that the integer in 'nums' can be negative.
      // Thus, we need to adjust the negative remainder to positive remainder.
      // Below accounts for both negative and positive remainders.
      // We can also check if the remainder is negative, then add a 'k' to make the remainder positive.
      // For Example, nums = [-2,3,2], k = 5,
      // remainder for the prefix sum of [-2,1,3] are -2, 1 and 3 respectively.
      // We know that [3,2] sum to 5, which is divisible by 5.
      // After converting -2 to 3, by adding 5, it has the same remainder with prefix sum 3.
      counting[(nums[i] % k + k) % k]++;
    }

    // The result contains all the prefix sum with remainder 0,
    // as all the prefix sum with remainder of 0 is itself divisible by 'k'.
    // However, do note that the prefix sum with remainder 0 also able to form subarray sums that is divisible by 'k'
    // with one another, which will be calculated next.
    // For Example: nums = [5,5,5,5], k = 5,
    // The prefix sum of [5,10,15,20] are themselves divisible by 5, while also forming subarray sums divisible by 5
    // with 10 [5,5] - 5 [5] == 5, 15 [5,5,5] - 5 [5] == 10, etc.
    int result = counting[0];

    // The prefix sums with the same remainder can form subarray sums that is divisible by 'k' with each other.
    // For each remainder, the number of subarray that is divisible by 'k' is the number of combinations from the frequency.
    // Equation for the number of combinations of n items is n * "(n - 1) / 2".
    for (int frequency in counting) result += frequency * (frequency - 1) ~/ 2;

    return result;
  }
}

class C {
  int subarraysDivByK(List<int> nums, int k) {
    int sum = 0;
    int cnt = 0;
    HashMap<int, int> hm = HashMap();
    hm[0] = 1;
    for (int i = 0; i < nums.length; i++) {
      sum += nums[i];

      int diff = sum % k;

      if (diff < 0) {
        diff += k;
      }

      if (hm.containsKey(diff)) {
        cnt += hm[diff]!;
      }
      hm[diff] = (hm[diff] ?? 0) + 1;
    }
    return cnt;
  }
}
