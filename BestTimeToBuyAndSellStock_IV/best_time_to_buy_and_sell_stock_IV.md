# Golang Solution

```go
 func maxProfit(k int, prices []int) int {

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
}
```
