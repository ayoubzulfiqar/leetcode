package main

// func trap(height []int) int {
// 	total := 0
// 	left := 0
// 	right := len(height) - 1
// 	leftMax, rightMax := 0, 0

// 	for left < right {
// 		if height[left] <= height[right] {
// 			if height[left] < leftMax {
// 				total += leftMax - height[left]
// 			} else {
// 				leftMax = height[left]
// 			}
// 			left++
// 		} else {
// 			if height[right] < rightMax {
// 				total += rightMax - height[right]
// 			} else {
// 				rightMax = height[right]
// 			}
// 			right--
// 		}
// 	}
// 	return total
// }

// func min(a, b int) int {
// 	if a < b {
// 		return a
// 	}
// 	return b
// }

// func max(a, b int) int {
// 	if a > b {
// 		return a
// 	}
// 	return b
// }
// func trap(height []int) int {
// 	n := len(height)
// 	res := 0
// 	maxFromLeft := make([]int, n)
// 	maxFromRight := make([]int, n)
// 	for i := 1; i < n; i++ {
// 		maxFromLeft[i] = max(maxFromLeft[i-1], height[i-1])
// 	}
// 	for j := n - 2; j >= 0; j-- {
// 		maxFromRight[j] = max(maxFromRight[j+1], height[j+1])
// 	}
// 	for i := 1; i < n-1; i++ {
// 		if height[i] < maxFromLeft[i] && height[i] < maxFromRight[i] {
// 			res += min(maxFromLeft[i], maxFromRight[i]) - height[i]
// 		}
// 	}
// 	return res
// }

func trap(height []int) int {
	maxIdx := 0
	for i := 1; i < len(height); i++ {
		if height[i] > height[maxIdx] {
			maxIdx = i
		}
	}

	currentMax, ans := height[0], 0
	for i := 1; i < maxIdx; i++ {
		if height[i] > currentMax {
			currentMax = height[i]
		} else {
			ans += currentMax - height[i]
		}
	}

	currentMax = height[len(height)-1]
	for i := len(height) - 2; i > maxIdx; i-- {
		if height[i] > currentMax {
			currentMax = height[i]
		} else {
			ans += currentMax - height[i]
		}
	}

	return ans
}
