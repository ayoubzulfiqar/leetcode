/*


-* Continuous SubArray Sum *-



Given an integer array nums and an integer k, return true if nums has a continuous sub-array of size at least two whose elements sum up to a multiple of k, or false otherwise.

An integer x is a multiple of k if there exists an integer n such that x = n * k. 0 is always a multiple of k.



Example 1:

Input: nums = [23,2,4,6,7], k = 6
Output: true
Explanation: [2, 4] is a continuous sub-array of size 2 whose elements sum up to 6.
Example 2:

Input: nums = [23,2,6,4,7], k = 6
Output: true
Explanation: [23, 2, 6, 4, 7] is an continuous sub-array of size 5 whose elements sum up to 42.
42 is a multiple of 6 because 42 = 7 * 6 and 7 is an integer.
Example 3:

Input: nums = [23,2,6,4,7], k = 13
Output: false


Constraints:

1 <= nums.length <= 105
0 <= nums[i] <= 109
0 <= sum(nums[i]) <= 231 - 1
1 <= k <= 231 - 1

*/

import 'dart:collection';

/*

Explanation 📝
We want to check if there is any [L, R] such that Sum(L, R) % k == 0
Let's represent Sum(L, R) in terms of prefixSums.
Sum(L, R) = Prefix[R] - Prefix[L] + Arr[L]
We want to solve for, Sum(L, R) % k = 0
(Prefix[R] - Prefix[L] + Arr[L]) % k = 0
LHS % k = 0 =>LHS should be a multiple of k
Prefix[R] - Prefix[L] + Arr[L] = constant * k
Prefix[R] = Prefix[L] - Arr[L] + constant * k
Taking % k both sides
Prefix[R] % k = (Prefix[L] - Arr[L] + constant * k) % k
Prefix[R] % k = (Prefix[L] - Arr[L]) % k
So basically, for every R, we can check if there is any L such that(Prefix[L] - Arr[L]) % k equal to Prefix[R] % k, which can be done easily maintaining a Hashset for previously visited values.
But, how will we handle Subarray length >= 2 case? It's very easy to do so, We will only check for L values < R which will make sure subarray length is at least 2.



Time Complexity: O(N)
Space Complexity: O(Min(N, K))
*/

class A {
  // Runtime: 899 ms, faster than 100.00% of Dart online submissions for Continuous Subarray Sum.
// Memory Usage: 204.9 MB, less than 100.00% of Dart online submissions for Continuous Subarray Sum.
  bool checkSubarraySum(List<int> nums, int k) {
    HashSet<int> modSet = HashSet();
    int currSum = 0, prevSum = 0;
    //when we add prevSum=0 in set it will actually check if currSum is divided by k
    for (int n in nums) {
      currSum += n;
      if (modSet.contains(currSum % k)) {
        return true;
      }
      currSum %= k;
      modSet.add(prevSum);
      prevSum = currSum;
    }
    return false;
  }
}

class B {
// Runtime: 696 ms, faster than 100.00% of Dart online submissions for Continuous Subarray Sum.
// Memory Usage: 186.4 MB, less than 100.00% of Dart online submissions for Continuous Subarray Sum.
  bool checkSubarraySum(List<int> nums, int k) {
    for (int i = 1; i < nums.length; i++) {
      if (nums[i] == 0 && nums[i - 1] == 0) return true;
    }
    for (int i = 1; i < nums.length; i++) {
      nums[i] += nums[i - 1];
      if (nums[i] % k == 0) return true;
      int j = i;
      while (j > 1 && nums[i] > k) {
        if ((nums[i] - nums[j - 2]) % k == 0) {
          return true;
        }
        j--;
      }
    }
    return false;
  }
}

class C {
  // Runtime: 668 ms, faster than 100.00% of Dart online submissions for Continuous Subarray Sum.
// Memory Usage: 207.5 MB, less than 100.00% of Dart online submissions for Continuous Subarray Sum.
  bool checkSubarraySum(List<int> nums, int k) {
    if (nums.length < 2) return false;

    // Map<remainder, index>
    HashMap<int, int> map = HashMap();

    map[0] = -1; // Why? Find the answer below

    int currSum = 0; // This would be our running sum

    for (int i = 0; i < nums.length; i++) {
      currSum += nums[i];
      int rem = 0;

      if (k != 0) rem = currSum % k; // k can't be 0 when we do a number % k

      if (map.containsKey(rem)) {
        // map.keys.firstWhere((element) => map[element] == rem)       // if that remainder already exists
        if (i - map[rem]! > 1) {
          // Length/difference checking Step
          return true; // and if the diff between the indices of the same remainder > 1, we get our answer
        }
      }

      map.putIfAbsent(
          rem,
          () =>
              i); // else we put that remainder along with its index in the map

      // we don't do map.put(rem, i) because it'll overwrite the old index (value) for the same rem (key).
      // using a 'putIfAbsent' will create a new unique map which we want.
    }

    return false;
  }
}
