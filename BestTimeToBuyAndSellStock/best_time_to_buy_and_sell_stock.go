package main

func maxProfit(prices []int) int {
	var buy int = 0
	var maxProfit int = 0
	for i := 0; i < len(prices); i++ {
		if prices[i] < buy {
			buy = prices[i]
		} else if prices[i]-buy > maxProfit {
			maxProfit = prices[i] - buy
		}
	}

	return maxProfit
}
