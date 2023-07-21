/*

-* 673. Number of Longest Increasing Subsequence *-

Given an integer array nums, return the number of longest increasing subsequences.

Notice that the sequence has to be strictly increasing.

 

Example 1:

Input: nums = [1,3,5,4,7]
Output: 2
Explanation: The two longest increasing subsequences are [1, 3, 4, 7] and [1, 3, 5, 7].
Example 2:

Input: nums = [2,2,2,2,2]
Output: 5
Explanation: The length of the longest increasing subsequence is 1, and there are 5 increasing subsequences of length 1, so output 5.
 

Constraints:

1 <= nums.length <= 2000
-106 <= nums[i] <= 106


*/
/*


class Pair {
  final int first;
  final int second;

  const Pair(this.first, this.second);
}

class A {
  int findNumberOfLIS(List<int> nums) {
    final int n = nums.length;
    final List<Pair> lisFQ = List.filled(n, Pair(0, 0));
    lisFQ[0] = Pair(1, 1);
    int lo = 1;

    for (int i = 1; i < nums.length; i++) {
      int mx = 0;
      int c = 1;

      for (int j = 0; j < i; j++) {
        if (nums[j] < nums[i]) {
          if (lisFQ[j].first > mx) {
            mx = lisFQ[j].first;
            c = lisFQ[j].second;
          } else if (lisFQ[j].first == mx) {
            c += lisFQ[j].second;
          }
        }
      }

      lisFQ[i] = Pair(mx + 1, c);

      if (lo < lisFQ[i].first) {
        lo = lisFQ[i].first;
      }
    }

    int count = 0;

    for (int i = 0; i < nums.length; i++) {
      if (lisFQ[i].first == lo) {
        count += lisFQ[i].second;
      }
    }

    return count;
  }
}
*/
/*
// I need to Work On Pair

class Solution {
  List<int> f(List<int> nums, int i, int prev, List<List<Pair>> dp) {
    if (i >= nums.length)
      return [
        0,
        1
      ]; // The length of LIS is 0, and there is one such LIS (an empty LIS).

    if (dp[prev + 1][i].first != -1) return dp[prev + 1][i];

    // 'a' is by taking that value and storing the length of the subsequence in a[0]
    // and storing the frequency of that subsequence in a[1].
    // 'b' is storing the then length of subsequence in b[0] and freq. of that subsequence in b[1] by not taking that value (means by skipping) ...

    List<int> a = [0, 0], b = [0, 0];

    if (prev == -1 || nums[i] > nums[prev]) {
      a = f(nums, i + 1, i, dp);
      a[0]++;
    }

    b = f(nums, i + 1, prev, dp);

    // if my length of the longest subsequence by taking ele. and not taking that ele. are equal then we just add up the freq.
    if (a[0] == b[0]) {
      dp[prev + 1][i] = Pair(a[0], a[1] + b[1]);
    }
    // if a has the longest subsequence length, then we take a.
    else if (a[0] > b[0]) {
      dp[prev + 1][i] = Pair(a[0], a[1]);
    } else {
      dp[prev + 1][i] = Pair(b[0], b[1]);
    }

    return dp[prev + 1][i] as List<int>;
  }

  int findNumberOfLIS(List<int> nums) {
    int n = nums.length;

    List<List<Pair>> dp =
        List.generate(n + 1, (index) => List.filled(n, Pair(-1, -1)));

    return f(nums, 0, -1, dp)[1];
  }
}

class Pair {
  int first;
  int second;

  Pair(this.first, this.second);
}
*/

class Solution {
  int findNumberOfLIS(List<int> nums) {
   final List<List<int>> cache =
        List.generate(nums.length, (index) => List<int>.filled(2, 0));
    int max = 0;
    int number = 0;
    for (int i = 0; i < nums.length; i++) {
     final List<int> pair = findSequence(nums, cache, i);
      if (pair[0] + 1 > max) {
        max = pair[0] + 1;
        number = pair[1];
      } else if (pair[0] + 1 == max) {
        number += pair[1];
      }
    }
    return number;
  }

  List<int> findSequence(List<int> nums, List<List<int>> cache, int index) {
    if (index == nums.length) return [0, 0];
    if (cache[index][0] != 0) return List.from(cache[index]);

    int max = 1;
    int numLIS = 1;
    List<int> pair = [0, 0]; // [LIS, num_LIS]
    for (int i = index + 1; i < nums.length; i++) {
      if (nums[i] > nums[index]) {
        pair = findSequence(nums, cache, i);
        // pair now has the result of LIS and number of times LIS occurred
        // we need to combine the subproblem values.
        if (pair[0] + 1 > max) {
          max = pair[0] + 1;
          numLIS = pair[1];
        } else if (pair[0] + 1 == max) {
          numLIS += pair[1];
        }
      }
    }

    cache[index] = [max, numLIS];
    return List.from(cache[index]);
  }
}
