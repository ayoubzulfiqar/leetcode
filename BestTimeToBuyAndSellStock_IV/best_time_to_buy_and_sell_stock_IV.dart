import 'dart:math';

// class A {
//   int maxProfit(int k, List<int> prices) {
//     if (k == 0) return 0;

//     List<int> buy = [k]; // buy[i]: min cost at (i + 1)-th time stock purchased
//     List<int> sell = [k]; // sell[i]: max revenue at (i + 1)-th time stock sold
//     //  Arrays.fill(buy, Integer.MIN_VALUE);
//     // Arrays.fill(sell, 0);
//     List.filled(prices.length, buy);
//     List.filled(0, sell);

//     for (int i in prices) {
//       buy[0] = max(buy[0], i * -1);
//       sell[0] = max(sell[0], buy[0] + i);
//       for (int j = 1; j < k; j++) {
//         // The i-th time buy & sell depends on the (i - 1)-th time buy & sell
//         buy[j] = max(buy[j], sell[j - 1] - i);
//         sell[j] = max(sell[j], buy[j] + i);
//       }
//     }
//     return sell[k - 1];
//   }
// }

// class B {
//   int maxProfit(int k, List<int> prices) {
//     int n = prices.length;
//     var dp = [n + 1][k + 1][3];

//     for (int index = n - 1; index >= 0; index--) {
//       for (int canBuy = 0; canBuy <= 1; canBuy++) {
//         for (int transactions = k; transactions > 0; transactions--) {
//           int profit = 0;
//           if (canBuy == 1) {
//             profit = max(profit, dp[index + 1][transactions][1]);
//             profit =
//                 max(profit, dp[index + 1][transactions][0] - prices[index]);
//           } else {
//             profit = max(profit, dp[index + 1][transactions][0]);
//             profit =
//                 max(profit, dp[index + 1][transactions - 1][1] + prices[index]);
//           }

//           dp[index][transactions][canBuy] = profit;
//         }
//       }
//     }

//     return dp[0][k][1];
//   }
// }

// class C {
//   int maxProfit(int k, List<int> prices) {
//      int transactions = k, n = prices.length;
//         Map<String, int> mapp = {};
//         return solve(prices, 0, transactions, 1, mapp);
//     }

//      int solve(List<int> prices, int index, int transactions, int canBuy, Map<String, int> map) {
//         if (index == prices.length) return 0;

//         if (transactions <= 0) return 0;

//         String KEY = ((index + ':' + transactions + ":") + canBuy) as String
//          ;

//         if (map.containsKey(KEY)) return map;

//         int profit = 0;
//         if (canBuy == 1) {
//             profit = Math.max(profit, solve(prices, index + 1, transactions, 1, map));
//             profit = Math.max(profit, solve(prices, index + 1, transactions, 0, map) - prices[index]);
//         } else {
//             profit = Math.max(profit, solve(prices, index + 1, transactions, 0, map));
//             profit = Math.max(profit, solve(prices, index + 1, transactions - 1, 1, map) + prices[index]);
//         }

//         map.put(KEY, profit);
//         return profit;
//   }
// }

// class D {
//   int maxProfit(int k, List<int> prices) {
//     var dp = [k + 1][prices.length];

//     return helper(k, prices, 0, dp);
//   }

//   int helper(int k, List<int> prices, int idx, var dp) {
//     if (k == 0 || idx == prices.length) return 0;
//     int maximum = 0;
//     if (dp[k][idx] == null) {
//       // don't buy at idx
//       maximum = max(maximum, helper(k, prices, idx + 1, dp));
//       // buy at idx and sell at j
//       for (int i = idx + 1; i < prices.length; i++) {
//         // skip if lose
//         if (prices[i] <= prices[idx]) continue;
//         maximum = max(maximum,
//             prices[i] - prices[idx] + helper(k - 1, prices, i + 1, dp));
//       }
//       dp[k][idx] = maximum;
//     }
//     return dp[k][idx];
//   }
// }

class E {
// 207 / 211 test cases passed.
// Status: Time Limit Exceeded
// Submitted: 0 minutes ago
// Last executed input:
// 7
// [48,12,60,93,97,42,25,64,17,56,85,93,9,48,52,42,58,85,81,84,69,36,1,54,23,15,72,15,11,94]
  int maxProfit(int k, List<int> prices) {
    int n = prices.length;

    return profit(k, prices, 1, 0, n);
  }

  //state  = 0 represents that we need to perform a buy operation
  //state = 1 represents that we have already bought a stock and we now need to sell it

  int profit(int k, List<int> prices, int state, int idx, int n) {
    if (idx == n || k == 0) return 0;
    if (state == 1) {
      int b = -prices[idx] + profit(k, prices, 0, idx + 1, n);
      int nb = profit(k, prices, 1, idx + 1, n);
      return max(b, nb);
    } else {
      int s = prices[idx] + profit(k - 1, prices, 1, idx + 1, n);
      int ns = profit(k, prices, 0, idx + 1, n);
      return max(s, ns);
    }
  }
}

class F {
// 179 / 211 test cases passed.
// Status: Time Limit Exceeded
// Submitted: 0 minutes ago
// Last executed input:
// 2
// [5,2,3,0,3,5,6,8,1,5]

  int maxProfit(int k, List<int> prices) {
    if (k >= prices.length / 2) {
      // Case of Problem 122. Best Time to Buy and Sell Stock II
      var maxProfit = 0;

      for (var i = 1; i < prices.length; i++)
        if (prices[i] > prices[i - 1]) maxProfit += prices[i] - prices[i - 1];

      return maxProfit;
    }
    var dp = List.filled(prices.length, k + 1)
        .map((e) => List.filled(prices.length, 0))
        .toList();
    // const dp = (k + 1).filled().map(() => List(prices.length).fill(0));

    for (var i = 1; i < dp.length; i++) {
      var maxDiff = -1 * prices[0]; // Money after buying a new stock.

      for (var j = 1; j < dp[0].length; j++) {
        dp[i][j] = max(
            dp[i][j - 1], prices[j] + maxDiff); // Profit after selling stock.
        maxDiff = max(maxDiff, dp[i - 1][j - 1] - prices[j]);
      }
    }

    return dp[k][prices.length - 1];
  }
}

class G {
// 207 / 211 test cases passed.
// Status: Time Limit Exceeded
// Submitted: 0 minutes ago
// Last executed input:
// 7
// [48,12,60,93,97,42,25,64,17,56,85,93,9,48,52,42,58,85,81,84,69,36,1,54,23,15,72,15,11,94]
  int maxProfit(int k, List<int> prices) {
    int f(int ind, int buy, int k, List<int> prices) {
      if (ind == prices.length || k == 0) return 0;

      int profit = 0;
      if (buy != 0) {
        profit = max(-prices[ind] + f(ind + 1, 0, k, prices),
            0 + f(ind + 1, 1, k, prices));
      } else {
        profit = max(prices[ind] + f(ind + 1, 1, k - 1, prices),
            0 + f(ind + 1, 0, k, prices));
      }

      return profit;
    }

    return f(0, 1, k, prices);
  }
}

class H {
  int maxProfit(int k, List<int> prices) {
    return 0;
  }
}


/* Golang Solution
type memkey struct {
		I         int
		Free      bool
		TransDone int
	}
	mem := make(map[memkey]int)
	makeMemKey := func(i int, free bool, transDone int) memkey {
		if k >= len(prices)/2 {
			return memkey{i, free, 0}
		} else {
			return memkey{i, free, transDone}
		}
	}
	var dp func(int, bool, int, int) int
	dp = func(i int, free bool, transDone int, out int) int {
		if i >= len(prices) {
			return out
		}
		if transDone >= k {
			return out
		}
		mk := makeMemKey(i, free, transDone)
		if _, ok := mem[mk]; ok {
			return out + mem[mk]
		}
		if free {
			former := out
			sell := dp(i+1, false, transDone+1, out+prices[i])
			keep := dp(i+1, true, transDone, out)
			out = max(sell, keep)
			mem[mk] = out - former
			return out
		}
		former := out
		buy := dp(i+1, true, transDone, out-prices[i])
		skip := dp(i+1, false, transDone, out)
		out = max(buy, skip)
		mem[mk] = out - former
		return out
	}
	return dp(0, false, 0, 0)
}

func max(a, b int) int {
	if a > b {
		return a
	} else {
		return b
	}
*/

/* Golang Solution

 if len(prices) == 0 {
        return 0
    }
    n := len(prices)

    if k > n / 2{
        return bf(prices)
    }

    dp := make([][]int, k+1)
    for i := 0; i < k+1; i++ {
        dp[i] = make([]int, n+1)
    }

    // dp[k][i] = max(dp[k][i-1], prices[i] - prices[j] + dp[k-1][j-1])
    for j := 1; j < k+1; j++ {
        min_price := prices[0]
        for i := 1; i < n+1; i++ {
            min_price = Min(min_price, prices[i-1]-dp[j-1][i-1])
            dp[j][i] = Max(dp[j][i-1], prices[i-1]-min_price)
        }
    }

    return dp[k][n]
}

func bf(prices []int) int {
    profit := 0
    for i:=1; i< len(prices); i++ {
        if prices[i]>prices[i-1] {
            profit += (prices[i]-prices[i-1])
        }
    }
    return profit
}

func Min(x, y int) int {
    if x < y {
        return x
    }
    return y
}

func Max(x, y int) int {
    if x > y {
        return x
    }
    return y
*/