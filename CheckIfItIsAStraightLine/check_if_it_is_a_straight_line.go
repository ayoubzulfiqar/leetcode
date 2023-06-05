package main

import "math"

func checkStraightLine(coordinates [][]int) bool {
	dx := coordinates[1][1] - coordinates[0][1]
	dy := coordinates[1][0] - coordinates[0][0]
	for i := 2; i < len(coordinates); i++ {
		if dx*(coordinates[i][0]-coordinates[1][0]) != dy*(coordinates[i][1]-coordinates[1][1]) {
			return false
		}
	}
	return true
}

// Cross Manipulation
func checkStraightLine1(coordinates [][]int) bool {
	x0, y0 := coordinates[0][0], coordinates[0][1]
	x1, y1 := coordinates[1][0], coordinates[1][1]
	for _, point := range coordinates {
		x, y := point[0], point[1]
		if (x-x0)*(y1-y0) != (y-y0)*(x1-x0) {
			return false
		}
	}
	return true
}

func checkStraightLine2(coordinates [][]int) bool {
	var slope float64
	var c float64

	if coordinates[1][0] == coordinates[0][0] {
		slope = math.Inf(1)
		c = float64(coordinates[0][1]) - slope*float64(coordinates[0][0])
		for i := 2; i < len(coordinates); i++ {
			if coordinates[i][0] != coordinates[0][0] {
				return false
			}
		}
		return true
	}

	slope = float64(coordinates[1][1]-coordinates[0][1]) / float64(coordinates[1][0]-coordinates[0][0])
	c = float64(coordinates[0][1]) - slope*float64(coordinates[0][0])

	for i := 2; i < len(coordinates); i++ {
		if float64(coordinates[i][1])-slope*float64(coordinates[i][0]) != c {
			return false
		}
	}

	return true
}
