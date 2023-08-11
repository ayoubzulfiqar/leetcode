/*

-* 518. Coin Change II *-

You are given an integer array coins representing coins of different denominations and an integer amount representing a total amount of money.

Return the number of combinations that make up that amount. If that amount of money cannot be made up by any combination of the coins, return 0.

You may assume that you have an infinite number of each kind of coin.

The answer is guaranteed to fit into a signed 32-bit integer.

 

Example 1:

Input: amount = 5, coins = [1,2,5]
Output: 4
Explanation: there are four ways to make up the amount:
5=5
5=2+2+1
5=2+1+1+1
5=1+1+1+1+1
Example 2:

Input: amount = 3, coins = [2]
Output: 0
Explanation: the amount of 3 cannot be made up just with coins of 2.
Example 3:

Input: amount = 10, coins = [10]
Output: 1
 

Constraints:

1 <= coins.length <= 300
1 <= coins[i] <= 5000
All the values of coins are unique.
0 <= amount <= 5000

*/

// Tabulation
class A {
  int change(int amount, List<int> coins) {
    final int m = coins.length;
    final int n = amount;
    final List<List<int>> dp =
        List.filled(m + 1, 0).map((e) => List.filled(n + 1, 0)).toList();
    // int dp[m+1][n+1];
    for (int i = 0; i < m + 1; i++) {
      for (int j = 0; j < n + 1; j++) {
        if (j == 0) {
          dp[i][j] = 1;
        }
        if (i == 0) {
          dp[i][j] = 0;
        }
      }
    }
    dp[0][0] = 1;
    for (int i = 1; i < m + 1; i++) {
      for (int j = 1; j < n + 1; j++) {
        if (coins[i - 1] <= j) {
          dp[i][j] = dp[i][j - coins[i - 1]] + dp[i - 1][j];
        } else
          dp[i][j] = dp[i - 1][j];
      }
    }
    return dp[m][n];
  }
}

// Dynamic Programming
class Solution {
  final List<List<int>> dp =
      List.generate(5001, (_) => List<int>.filled(301, -1));
  int solve(int amount, List<int> coins, int i) {
    if (amount == 0) return 1;

    if (dp[amount][i] != -1) return dp[amount][i];

    if (i == coins.length) return 0;

    int tk = 0;
    if (coins[i] <= amount) {
      tk = solve(amount - coins[i], coins, i);
    }
    final int nt = solve(amount, coins, i + 1);
    return dp[amount][i] = tk + nt;
  }

  int change(int amount, List<int> coins) {
    for (int i = 0; i < 5001; i++) {
      dp[i] = List<int>.filled(301, -1);
    }
    return solve(amount, coins, 0);
  }
}

// Tabulation with Space Optimization
class C {
  int change(int amount, List<int> coins) {
    final List<int> dp = List<int>.filled(amount + 1, 0);
    dp[0] = 1;
    for (int i = 0; i < coins.length; i++) {
      for (int j = coins[i]; j <= amount; j++) {
        dp[j] += dp[j - coins[i]];
      }
    }
    return dp[amount];
  }
}
