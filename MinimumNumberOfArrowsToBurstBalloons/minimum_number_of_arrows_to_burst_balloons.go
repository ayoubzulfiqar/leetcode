package main

import "sort"

// func findMinArrowShots(points [][]int) int {
// 	if len(points) == 0 {
// 		return 0
// 	}

// 	sort.Slice(points, func(i, j int) bool {
// 		return points[i][1] < points[j][1]
// 	})
// 	var arrowPosition int = points[0][1]
// 	var arrowCount int = 1
// 	for i := 1; i < len(points); i++ {
// 		if arrowPosition >= points[i][0] {
// 			continue
// 		}
// 		arrowCount++
// 		arrowPosition = points[i][1]
// 	}
// 	return arrowCount

// }

func findMinArrowShots(points [][]int) int {
	// corner case
	if len(points) == 0 || len(points[0]) == 0 {
		return 0
	}

	// sort and get merger point
	sort.Slice(points, func(i, j int) bool {
		if points[i][0] != points[j][0] {
			return points[i][0] < points[j][0]
		} else {
			return points[i][1] < points[j][1]
		}
	})

	res := make([][]int, 0)
	for _, mid := range points {
		//mid[0] and mid[1]
		if len(res) == 0 {
			res = append(res, mid)
		} else {
			temp := res[len(res)-1]
			if mid[0] <= temp[1] {
				// value equal is represent interact each other
				temp[0] = max(temp[0], mid[0])
				temp[1] = min(temp[1], mid[1])
				res[len(res)-1] = temp
			} else {
				res = append(res, mid)
			}
		}
	}
	return len(res)
}

func max(a, b int) int {
	if a > b {
		return a
	}
	return b
}

func min(a, b int) int {
	if a < b {
		return a
	}
	return b
}
