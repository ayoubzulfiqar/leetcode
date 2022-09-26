/*

 -* Best Time to Buy and Sell Stock *-

You are given an array prices where prices[i] is the price of a given stock on the ith day.

You want to maximize your profit by choosing a single day to buy one stock and choosing a different day in the future to sell that stock.

Return the maximum profit you can achieve from this transaction. If you cannot achieve any profit, return 0.



Example 1:

Input: prices = [7,1,5,3,6,4]
Output: 5
Explanation: Buy on day 2 (price = 1) and sell on day 5 (price = 6), profit = 6-1 = 5.
Note that buying on day 2 and selling on day 1 is not allowed because you must buy before you sell.
Example 2:

Input: prices = [7,6,4,3,1]
Output: 0
Explanation: In this case, no transactions are done and the max profit = 0.


Constraints:

1 <= prices.length <= 105
0 <= prices[i] <= 104


*/

import 'dart:math';

class Solution {
// Runtime: 696 ms, faster than 27.03% of Dart online submissions for Best Time to Buy and Sell Stock.
// Memory Usage: 186.5 MB, less than 56.76% of Dart online submissions for Best Time to Buy and Sell Stock.
  /*
  Approach
  Follow the steps below to implement the above idea:
  Declare a buy variable to store the buy cost and maxProfit to store the maximum profit.
  Initialize the buy variable to the first element of the prices array.
  Iterate over the prices array and check if the current price is minimum or not.
  If the current price is minimum then buy on this ith day.
  If the current price is greater than the previous buy then make profit from it and maximize the maxProfit.
  Finally, return the maxProfit.

  */
  int maxProfit(List<int> prices) {
    int buy = 0;
    int maxProfit = 0;
    buy = prices[0];
    for (int i = 0; i < prices.length; i++) {
      if (prices[i] < buy) {
        buy = prices[i];
      } else if (prices[i] - buy > maxProfit) {
        maxProfit = prices[i] - buy;
      }
    }
    return maxProfit;
  }
}

class B {
  int maxProfit(List<int> prices) {
    int maxPro = 0, mn = 100050450;

    for (int i = 0; i < prices.length; i++) {
      mn = min(mn, prices[i]);
      maxPro = max(maxPro, prices[i] - mn);
    }
    return maxPro;
  }
}

// Massive Stack Overflow
class C {
  int findMaximumProfit(
      List<int> prices, int i, int k, int buy, List<List<int>> v) {
    // If no stock can be chosen
    if (i >= prices.length || k <= 0) return 0;

    if (v[i][buy] != -1) return v[i][buy];

    // If a stock is already bought
    // Buy now
    int nbuy;
    if (buy == 1)
      nbuy = 0;
    else
      nbuy = 1;
    if (buy == 1) {
      // return v[i][buy] = max(
      //     -prices[i] + findMaximumProfit(prices, i + 1, k, nbuy, v),
      //     findMaximumProfit(prices, i + 1, k, buy, v));
      return v[i][buy] = max(
          (-prices[i] + findMaximumProfit(prices, i + 1, k, nbuy, v)).toInt(),
          findMaximumProfit(prices, i + 1, k, buy, v));
    }

    // Otherwise
    else {
      // Buy now
      if (buy == 1)
        nbuy = 0;
      else
        nbuy = 1;
      return v[i][buy] = max(
          (prices[i] + findMaximumProfit(prices, i + 1, k - 1, nbuy, v))
              .toInt(),
          findMaximumProfit(prices, i + 1, k, buy, v));
    }
  }

  int maxProfit(List<int> prices) {
    int n = prices.length;
    // let v = new Array(n).fill(0).map(() => new Array(2).fill(-1))
    var v = List.filled(n, 0).map((e) => List.filled(2, -1)).toList();

    // buy = 1 because atmost one
    // transaction is allowed
    return findMaximumProfit(prices, 0, 1, 1, v);
  }
}

class D {
  int findMaximumProfit(int i, int k, List<int> prices, List<List<int>> dp) {
    if (i == prices.length) return 0;
    if (dp[i][k] != -1) return dp[i][k];
    int profit = 0;
    if (k == 1) {
      int buy = -prices[i] + findMaximumProfit(i + 1, 0, prices, dp);
      int notBuy = findMaximumProfit(i + 1, 1, prices, dp);
      profit = max(buy, notBuy);
    } else {
      int sell = prices[i] + findMaximumProfit(i + 1, 1, prices, dp);
      int notSell = findMaximumProfit(i + 1, 0, prices, dp);
      profit = max(sell, notSell);
    }

    return dp[i][k] = profit;
  }

  int maxProfit(List<int> prices) {
    int n = prices.length;
    List<List<int>> dp =
        List.filled(n, 0).map((e) => List.filled(2, -1)).toList();

    return findMaximumProfit(0, 1, prices, dp);
  }
}
