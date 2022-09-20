/*

  -* Maximum Length of Repeated SubArray *-

  Given two integer arrays nums1 and nums2, return the maximum length of a sub-array that appears in both arrays.



Example 1:

Input: nums1 = [1,2,3,2,1], nums2 = [3,2,1,4,7]
Output: 3
Explanation: The repeated sub-array with maximum length is [3,2,1].
Example 2:

Input: nums1 = [0,0,0,0,0], nums2 = [0,0,0,0,0]
Output: 5


Constraints:

1 <= nums1.length, nums2.length <= 1000
0 <= nums1[i], nums2[i] <= 100

*/

import 'dart:math';

class A {
// Runtime: 546 ms, faster than 100.00% of Dart online submissions for Maximum Length of Repeated SubArray.
// Memory Usage: 143.5 MB, less than 100.00% of Dart online submissions for Maximum Length of Repeated SubArray.

  int findLength(List<int> nums1, List<int> nums2) {
    // checking if the list is empty of zero
    if (nums1.isEmpty || nums2.isEmpty || nums1 == 0 || nums2 == 0) return 0;
    // length of the first list
    int row = nums1.length;
    // length of the second list
    int column = nums2.length;
    // growable list
    List<int> dp = List.filled(column + 1, 0);
    // max length that will hold our answer based om both list
    int maxLength = 0;
    // loop to iterate all the value inside first list to get each and every element
    for (var i = 1; i <= row; i++) {
      // loop to iterate the all the values in second list
      for (int j = column; j > 0; j--) {
        // if the both means each single element same as the other list
        if (nums1[i - 1] == nums2[j - 1]) {
          dp[j] = 1 + dp[j - 1];
          // than our max length will be based on the larger two numbers
          maxLength = max(maxLength, dp[j]);
        } else {
          // if not than dp is zero the element of the second list
          dp[j] = 0;
        }
      }
    }
    return maxLength;
  }
}

// Recursive
class B {
// 25 / 57 test cases passed.
// Status: Time Limit Exceeded
// Submitted: 0 minutes ago
// Last executed input:
// [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]
// [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
  int ans = 0;
  int findLength(List<int> nums1, List<int> nums2) {
    solve(nums1, nums2, 0, 0);
    return ans;
  }

  int solve(List<int> a, List<int> b, int i, int j) {
    if (i >= a.length || j >= b.length) return 0;
    solve(a, b, i + 1, j);
    solve(a, b, i, j + 1); // recurse to solve for each possible (i, j)
    int common = a[i] == b[j]
        ? 1 + solve(a, b, i + 1, j + 1)
        : 0; // longest common sub-array starting at A[i] & B[j]
    ans = max(ans, common); // update ans to hold max length found till now
    return common;
  }
}

// Iterative Version
class C {
// 52 / 57 test cases passed.
// Status: Time Limit Exceeded
// Submitted: 0 minutes ago
// Last executed input:
// [91,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,92,35,35,35]
// [35,35,93,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,3

  int findLength(List<int> nums1, List<int> nums2) {
    if (nums1.isEmpty || nums2.isEmpty || nums1 == 0 || nums2 == 0) return 0;
    int m = nums1.length, n = nums2.length, ans = 0;
    for (int i = 0; i < m; i++) {
      for (int j = 0; j < n; j++) {
        int len = 0;
        while (i + len < m && j + len < n && nums1[i + len] == nums2[j + len])
          len++; // get length of longest common sub-array starting at A[i] & B[j]
        ans = max(ans, len); // update ans to hold max length found till now
      }
    }
    return ans;
  }
}

class MaxLength {
  int val = 0;
}

class D {
  int findLength(List<int> nums1, List<int> nums2) {
    MaxLength maxLength = new MaxLength();
    //  int[][] memo = new int[A.length][B.length];
    List<List<int>> memo = List.filled(nums1.length, 0)
        .map((e) => List.filled(nums2.length, 0))
        .toList();

    for (int row = 0; row < memo.length; row++) {
      // Arrays.fill(memo[row], -1);
      List.filled(memo[row].length, -1);
    }

    find_length(0, 0, nums1, nums2, maxLength, memo);
    return maxLength.val;
  }

  int find_length(int i, int j, List<int> a, List<int> b, MaxLength maxLength,
      List<List<int>> memo) {
    if (i >= a.length || j >= b.length) return 0;
    if (memo[i][j] != -1) return memo[i][j];

    int length = 0;

    if (a[i] == b[j]) {
      length = find_length(i + 1, j + 1, a, b, maxLength, memo) + 1;
      maxLength.val = max(maxLength.val, length);
    }

    find_length(i + 1, j, a, b, maxLength, memo);
    find_length(i, j + 1, a, b, maxLength, memo);

    memo[i][j] = length;
    return length;
  }
}

// O(n^2) Time, O(1) Space solution
class E {
// 25 / 57 test cases passed.
// Status: Time Limit Exceeded
// Submitted: 0 minutes ago
// Last executed input:
// [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]
// [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
  int findLength(List<int> nums1, List<int> nums2) {
    int n1 = nums1.length, n2 = nums2.length;
    int res = 0;
    for (int offset = -n1; offset < n2; offset++) {
      int count = 0;
      for (int i = max(offset, 0); i - offset < n1 && i < n2; i++) {
        if (nums1[i - offset] == nums2[i]) {
          count++;
          res = max(res, count);
        } else {
          count = 0;
        }
      }
    }
    return res;
  }
}
