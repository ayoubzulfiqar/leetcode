/*


-* 714. Best Time to Buy and Sell Stock with Transaction Fee *-


You are given an array prices where prices[i] is the price of a given stock on the ith day, and an integer fee representing a transaction fee.

Find the maximum profit you can achieve. You may complete as many transactions as you like, but you need to pay the transaction fee for each transaction.

Note: You may not engage in multiple transactions simultaneously (i.e., you must sell the stock before you buy again).

 

Example 1:

Input: prices = [1,3,2,8,4,9], fee = 2
Output: 8
Explanation: The maximum profit can be achieved by:
- Buying at prices[0] = 1
- Selling at prices[3] = 8
- Buying at prices[4] = 4
- Selling at prices[5] = 9
The total profit is ((8 - 1) - 2) + ((9 - 4) - 2) = 8.
Example 2:

Input: prices = [1,3,7,5,10,3], fee = 3
Output: 6
 

Constraints:

1 <= prices.length <= 5 * 104
1 <= prices[i] < 5 * 104
0 <= fee < 5 * 104

*/

import 'dart:math';

class A {
  int maxProfit(List<int> prices, int fee) {
    int buy = -2147483648;
    int sell = 0;

    for (int price in prices) {
      buy = buy > sell - price ? buy : sell - price;
      sell = sell > buy + price - fee ? sell : buy + price - fee;
    }

    return sell;
  }
}

class B {
  int getAns(
      List<int> arr, int ind, int buy, int n, int fee, List<List<int>> dp) {
    if (ind == n) return 0; // base case

    if (dp[ind][buy] != -1) return dp[ind][buy];

    int profit = 0;

    if (buy == 0) {
      // We can buy the stock
      profit = max(
        0 + getAns(arr, ind + 1, 0, n, fee, dp),
        -arr[ind] + getAns(arr, ind + 1, 1, n, fee, dp),
      );
    }

    if (buy == 1) {
      // We can sell the stock
      profit = max(
        0 + getAns(arr, ind + 1, 1, n, fee, dp),
        arr[ind] - fee + getAns(arr, ind + 1, 0, n, fee, dp),
      );
    }

    return dp[ind][buy] = profit;
  }

  int maxProfit(List<int> prices, int fee) {
    List<List<int>> dp =
        List.generate(prices.length, (_) => List<int>.filled(2, -1));

    if (prices.length == 0) return 0;

    int ans = getAns(prices, 0, 0, prices.length, fee, dp);
    return ans;
  }
}

class C {
  int maxProfit(List<int> prices, int fee) {
    if (prices.isEmpty) return 0;
    int n = prices.length;

    List<List<int>> dp = List.generate(n, (_) => List<int>.filled(2, 0));

    // Initialize base cases
    dp[0][0] = 0;
    dp[0][1] = -prices[0];

    for (int i = 1; i < n; i++) {
      // Calculate the maximum profit when not holding a stock
      dp[i][0] = dp[i - 1][0];
      if (dp[i - 1][1] + prices[i] - fee > dp[i][0]) {
        dp[i][0] = dp[i - 1][1] + prices[i] - fee;
      }

      // Calculate the maximum profit when holding a stock
      dp[i][1] = dp[i - 1][1];
      if (dp[i - 1][0] - prices[i] > dp[i][1]) {
        dp[i][1] = dp[i - 1][0] - prices[i];
      }
    }

    return dp[n - 1][0];
  }
}

class D {
  int maxProfit(List<int> prices, int fee) {
    int n = prices.length;
    if (n == 0) return 0;

    Map<String, int> dp = {};

    // Base cases
    dp['false-$n'] = 0;
    dp['true-$n'] = 0;

    for (int i = n - 1; i >= 0; i--) {
      for (bool buy in [false, true]) {
        if (buy) {
          dp['$buy-$i'] = ((dp['false-${i + 1}']! + prices[i])
                      .compareTo(dp['$buy-${i + 1}']!) >
                  0
              ? dp['false-${i + 1}']! + prices[i]
              : dp['$buy-${i + 1}'])!;
        } else {
          dp['$buy-$i'] = ((dp['$buy-${i + 1}'])!
                      .compareTo(dp['true-${i + 1}']! - prices[i] - fee) >
                  0
              ? dp['$buy-${i + 1}']
              : dp['true-${i + 1}']! - prices[i] - fee)!;
        }
      }
    }

    return dp['false-0']!;
  }
}
