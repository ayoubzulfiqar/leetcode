/*

-* Minimum Cost to Cut a Stick *-

Given a wooden stick of length n units. The stick is labelled from 0 to n. For example, a stick of length 6 is labelled as follows:


Given an integer array cuts where cuts[i] denotes a position you should perform a cut at.

You should perform the cuts in order, you can change the order of the cuts as you wish.

The cost of one cut is the length of the stick to be cut, the total cost is the sum of costs of all cuts. When you cut a stick, it will be split into two smaller sticks (i.e. the sum of their lengths is the length of the stick before the cut). Please refer to the first example for a better explanation.

Return the minimum total cost of the cuts.

 

Example 1:


Input: n = 7, cuts = [1,3,4,5]
Output: 16
Explanation: Using cuts order = [1, 3, 4, 5] as in the input leads to the following scenario:

The first cut is done to a rod of length 7 so the cost is 7. The second cut is done to a rod of length 6 (i.e. the second part of the first cut), the third is done to a rod of length 4 and the last cut is to a rod of length 3. The total cost is 7 + 6 + 4 + 3 = 20.
Rearranging the cuts to be [3, 5, 1, 4] for example will lead to a scenario with total cost = 16 (as shown in the example photo 7 + 4 + 3 + 2 = 16).
Example 2:

Input: n = 9, cuts = [5,6,1,4,2]
Output: 22
Explanation: If you try the given cuts ordering the cost will be 25.
There are much ordering with total cost <= 25, for example, the order [4, 6, 5, 2, 1] has total cost = 22 which is the minimum possible.
 

Constraints:

2 <= n <= 106
1 <= cuts.length <= min(n - 1, 100)
1 <= cuts[i] <= n - 1
All the integers in cuts array are distinct.

*/

import 'dart:collection';

class A {
  int minCost(int n, List<int> cuts) {
    cuts
      ..add(0)
      ..add(n);
    int m = cuts.length;
    cuts.sort();
    List<List<int>> dp = List.generate(m, (_) => List<int>.filled(m, -1));

/*
 I've defined maxIntValue as 1 << 30, 
 which represents a large integer value that can act as a substitute for infinity in this context. 
*/
    final int maxIntValue = 1 << 30; // Define a large constant value

    int cost(int i, int j) {
      if (j - i <= 1) return 0;
      if (dp[i][j] != -1) return dp[i][j];
      int result = maxIntValue;
      for (int k = i + 1; k < j; k++) {
        result =
            result < cost(i, k) + cost(k, j) ? result : cost(i, k) + cost(k, j);
      }
      return dp[i][j] = result + (cuts[j] - cuts[i]);
    }

    return cost(0, m - 1);
  }
}

class B {
  int minCost(int n, List<int> cuts) {
    List<int> combinedCuts = List<int>.from(cuts);
    combinedCuts
      ..add(0)
      ..add(n);
    combinedCuts.sort();
    int m = combinedCuts.length;

    List<List<int>> dp = List.generate(m, (_) => List<int>.filled(m, 0));

    for (int length = 2; length < m; length++) {
      for (int i = 0; i < m - length; i++) {
        int j = i + length;
        dp[i][j] = 1 << 30;
        for (int k = i + 1; k < j; k++) {
          dp[i][j] =
              dp[i][j] < dp[i][k] + dp[k][j] + combinedCuts[j] - combinedCuts[i]
                  ? dp[i][j]
                  : dp[i][k] + dp[k][j] + combinedCuts[j] - combinedCuts[i];
        }
      }
    }

    return dp[0][m - 1];
  }
}

// import 'dart:collection';

class Solution {
  SplayTreeSet<int> set = SplayTreeSet<int>();
  late int n;

  Map<int, int> memo = {};

  int minCost(int n, List<int> cuts) {
    for (int c in cuts) set.add(c);
    this.n = n;

    return helper(0, n);
  }

  int helper(int i, int j) {
    int key = i * (n + 1) + j;
    if (memo.containsKey(key)) return memo[key]!;

    int res = double.infinity.toInt();
    int index = set.toList().indexWhere((value) => value > i);
    for (int k = index; k < set.length; k++) {
      int value = set.elementAt(k);
      res = res < (j - i) + helper(i, value) + helper(value, j)
          ? res
          : (j - i) + helper(i, value) + helper(value, j);
    }

    if (res == double.infinity.toInt()) res = 0;
    memo[key] = res;

    return res;
  }
}
