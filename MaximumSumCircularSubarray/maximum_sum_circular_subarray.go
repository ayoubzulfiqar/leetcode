package main

func maxSubarraySumCircular(nums []int) int {
	var totalSum int = 0
	var maxSum int = -30012
	var curMax int = 0
	var minSum int = 3012
	var curMin = 0
	for _, x := range nums {
		curMax = max(x, curMax+x)
		maxSum = max(maxSum, curMax)
		curMin = min(x, curMin+x)
		minSum = min(minSum, curMin)
		totalSum += x
	}
	if maxSum > 0 {
		return max(maxSum, totalSum-minSum)
	} else {
		return maxSum
	}
}

func max(a int, b int) int {
	if a > b {
		return a
	} else {
		return b
	}
}
func min(a int, b int) int {
	if a < b {
		return a
	} else {
		return b
	}
}

/*




 int totalSum = 0, maxSum = -30012, curMax = 0, minSum = 30012, curMin = 0;
    for (int x in nums) {
      curMax = max(x, curMax + x); //update the current max sub-array sum
      maxSum = max(maxSum, curMax); //update the overall max sub-array sum
      curMin = min(x, curMin + x); //update the current min sub-array sum
      minSum = min(minSum, curMin); //update the overall min sub-array sum
      totalSum += x;
    }
    return maxSum > 0 ? max(maxSum, totalSum - minSum) : maxSum;



*/
