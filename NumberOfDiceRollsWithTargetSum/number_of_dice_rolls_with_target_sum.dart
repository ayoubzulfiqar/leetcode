/*


 -* Number of Dice Rolls With Target Sum *-

You have n dice and each die has k faces numbered from 1 to k.

Given three integers n, k, and target, return the number of possible ways (out of the kn total ways) to roll the dice so the sum of the face-up numbers equals target. Since the answer may be too large, return it modulo 109 + 7.



Example 1:

Input: n = 1, k = 6, target = 3
Output: 1
Explanation: You throw one die with 6 faces.
There is only one way to get a sum of 3.
Example 2:

Input: n = 2, k = 6, target = 7
Output: 6
Explanation: You throw two dice, each with 6 faces.
There are 6 ways to get a sum of 7: 1+6, 2+5, 3+4, 4+3, 5+2, 6+1.
Example 3:

Input: n = 30, k = 30, target = 500
Output: 222616187
Explanation: The answer must be returned modulo 109 + 7.


Constraints:

1 <= n, k <= 30
1 <= target <= 1000


*/

// DP Approach- Tabulation
import 'dart:collection';

class A {
// Runtime: 529 ms, faster than 100.00% of Dart online submissions for Number of Dice Rolls With Target Sum.
// Memory Usage: 143.7 MB, less than 100.00% of Dart online submissions for Number of Dice Rolls With Target Sum.

  int numRollsToTarget(int n, int k, int target) {
    //int mod = (1e9 + 7).floor();
    int m = 1000000007;
    List<List<int>> dp =
        List.filled(n + 1, 0).map((e) => List.filled(target + 1, 0)).toList();
    dp[0][0] = 1;
    for (int i = 1; i <= n; i++) {
      for (int j = 1; j <= target; j++) {
        for (int r = 1; r <= k; r++) {
          if (r <= j) dp[i][j] = ((dp[i][j] % m) + (dp[i - 1][j - r] % m)) % m;
        }
      }
    }
    return dp[n][target];
  }
}

class B {
  // Memoization but TLC
  int numRollsToTarget(int n, int k, int target) {
    //int mod = (1e9 + 7).floor();
    int MOD = 1000000007;
    // HashMap to unique elements because we don't wanna repeat
    HashMap<int, int> mem = HashMap();
    // if our target and side is end up 0 than we will return 1
    if (n == 0 && target == 0) return 1;
    // if the face is OR the target is less or equal to zero return zeo
    if (n <= 0 || target <= 0) return 0;
    // our key in the HAsh map to hold the value
    int key = n + "_".codeUnitAt(0) + target;
    // if we find the we will simply return the key based on the index we have found
    if (mem.containsKey(key)) return mem.keys.elementAt(key);
    // holding our value
    int ans = 0;
    // loop to iterate through the target value and face value of the dice
    for (int i = 1; i <= k && i <= target; i++) {
      // getting the MOD recursively
      ans = (ans + numRollsToTarget(n - 1, k, target - i)) % MOD;
    }
    // putting the value inside our hashMap
    mem.forEach((key, value) {
      key = key;
      value = ans;
    });
    // return the value
    return ans;
  }
}

class C {
  // Recursive
  // Correct but TLC
  /// > The number of ways to get to `target` using `n` dice with `k` sides is the sum of the number of
  /// ways to get to `target - 1` through `target - k` using `n - 1` dice with `k` sides
  ///
  /// Args:
  ///   n (int): number of dice
  ///   k (int): the maximum number that can be used in the sum
  ///   target (int): the sum of the numbers
  ///
  /// Returns:
  ///   The number of ways to sum to target using n numbers from 1 to k.
  int solve(int n, int k, int target) {
    if (n == 0 && target == 0) return 1;

    if (n <= 0 || target <= 0) return 0;

    int ans = 0;
    for (int i = 1; i <= k; i++) ans += solve(n - 1, k, target - i);

    return ans;
  }

  int numRollsToTarget(int n, int k, int target) {
    return solve(n, k, target);
  }
}
