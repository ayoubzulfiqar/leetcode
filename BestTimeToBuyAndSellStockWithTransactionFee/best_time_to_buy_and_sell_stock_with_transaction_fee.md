# 🔥 3 Solutions 🔥 || Simple Fast and Easy || with Explanation 😈

## Solution - 1

## Intuition

The intuition behind the solution is to keep track of the minimum cost to buy a stock at each day and the maximum profit that can be achieved by selling the stock at each day.

## Approach

Initialize two variables: buy and sell. Set buy to negative infinity and sell to zero. These variables will keep track of the maximum profit at each day.

Iterate through the prices of the stocks starting from the first day.

Update the buy variable by taking the maximum of its current value and the previous sell value minus the stock price. This represents the maximum profit after buying the stock.
buy = max(buy, sell - price)

Update the sell variable by taking the maximum of its current value and the previous buy value plus the stock price minus the transaction fee. This represents the maximum profit after selling the stock.
sell = max(sell, buy + price - fee)

After iterating through all the prices, the maximum profit will be stored in the sell variable.

Return the value of sell as the maximum profit.

## Complexity

### Time complexity

O(n)

### Space complexity

O(1)

```dart
class Solution {
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
```

## Solution - 2 -- Stack OverFLow (NOT Optimized)

```dart
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
```

## Solution - 3 - Optimized

```dart
class Solution {
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
```
