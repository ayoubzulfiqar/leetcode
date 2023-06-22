package main

func maxProfit(prices []int, fee int) int {
	if len(prices) == 0 {
		return 0
	}

	n := len(prices)
	dp := make([][2]int, n)

	// Initialize base cases
	dp[0][0] = 0
	dp[0][1] = -prices[0]

	for i := 1; i < n; i++ {
		// Calculate the maximum profit when not holding a stock
		dp[i][0] = dp[i-1][0]
		if dp[i-1][1]+prices[i]-fee > dp[i][0] {
			dp[i][0] = dp[i-1][1] + prices[i] - fee
		}

		// Calculate the maximum profit when holding a stock
		dp[i][1] = dp[i-1][1]
		if dp[i-1][0]-prices[i] > dp[i][1] {
			dp[i][1] = dp[i-1][0] - prices[i]
		}
	}

	return dp[n-1][0]
}
