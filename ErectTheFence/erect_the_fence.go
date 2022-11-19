package main

import "sort"

func outerTrees(trees [][]int) [][]int {
	if len(trees) == 1 {
		return trees
	}

	upper, lower := make([][]int, 0), make([][]int, 0)

	sort.Slice(trees, func(q, p int) bool {
		if trees[q][0]-trees[p][0] == 0 {
			return trees[q][1] < trees[p][1]
		}

		return trees[q][0] < trees[p][0]
	})

	for i := 0; i < len(trees); i++ {
		for len(lower) >= 2 && orientation(lower[len(lower)-2], lower[len(lower)-1], trees[i]) > 0 {
			lower = lower[:len(lower)-1]
		}
		for len(upper) >= 2 && orientation(upper[len(upper)-2], upper[len(upper)-1], trees[i]) < 0 {
			upper = upper[:len(upper)-1]
		}
		lower = append(lower, trees[i])
		upper = append(upper, trees[i])
	}

	result := make([][]int, 0)

loop:
	for _, set := range append(upper, lower...) {
		for _, res := range result {
			if set[0] == res[0] && set[1] == res[1] {
				continue loop
			}
		}
		result = append(result, set)
	}

	return result
}

func orientation(p, q, r []int) int {
	return (r[1]-q[1])*(q[0]-p[0]) - (q[1]-p[1])*(r[0]-q[0])
}

//--------------------------

// import "sort"

// func outerTrees(points [][]int) [][]int {
// 	if len(points) <= 1 {
// 		return points
// 	}

// 	bm := bottomLeft(points)
// 	sort.Slice(points, func(i int, j int) bool {
// 		diff := orientation(bm, points[i], points[j])
// 		if diff == 0 {
// 			return distance(bm, points[i]) < distance(bm, points[j])
// 		} else {
// 			return diff < 0
// 		}
// 	})

// 	i := len(points) - 1
// 	for i >= 0 && orientation(bm, points[len(points)-1], points[i]) == 0 {
// 		i--
// 	}

// 	j, k := i+1, len(points)-1
// 	for j < k {
// 		points[j], points[k] = points[k], points[j]
// 		j++
// 		k--
// 	}

// 	stack := [][]int{points[0], points[1]}

// 	for p := 2; p < len(points); p++ {
// 		top := stack[len(stack)-1]
// 		stack = stack[:len(stack)-1]
// 		for orientation(stack[len(stack)-1], top, points[p]) > 0 {
// 			top = stack[len(stack)-1]
// 			stack = stack[:len(stack)-1]
// 		}
// 		stack = append(stack, top)
// 		stack = append(stack, points[p])
// 	}
// 	return stack
// }

// func bottomLeft(points [][]int) []int {
// 	res := points[0]
// 	for _, v := range points {
// 		if v[1] < res[1] {
// 			res = v
// 		}
// 	}
// 	return res
// }

// func orientation(p []int, q []int, r []int) int {
// 	return (q[1]-p[1])*(r[0]-q[0]) - (q[0]-p[0])*(r[1]-q[1])
// }

// func distance(p []int, q []int) int {
// 	return (p[0]-q[0])*(p[0]-q[0]) + (p[1]-q[1])*(p[1]-q[1])
// }
