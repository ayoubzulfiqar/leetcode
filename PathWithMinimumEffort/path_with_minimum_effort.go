package main

import (
	"container/heap"
)

// Create a struct to represent a cell's coordinates and effort
type Cell struct {
	x      int
	y      int
	effort int
}

// Define changes in x and y coordinates for each direction

var (
	dy = [4]int{1, 0, 0, -1}
	dx = [4]int{0, 1, -1, 0}
)

// Function to find the minimum effort path
func minimumEffortPath(heights [][]int) int {
	rows, cols := len(heights), len(heights[0])

	// Create a 2D slice to store effort for each cell
	effort := make([][]int, rows)
	for i := range effort {
		effort[i] = make([]int, cols)
	}

	// Initialize effort for each cell to maximum value
	for i := 0; i < rows; i++ {
		for j := 0; j < cols; j++ {
			effort[i][j] = 1 << 31 // Initialize with maximum int value
		}
	}

	// Priority queue to store {effort, {x, y}}
	pq := make(PriorityQueue, 0)
	heap.Init(&pq)
	pq.Push(&Cell{0, 0, 0}) // Start from the top-left cell
	effort[0][0] = 0        // Initial effort at the starting cell

	for pq.Len() > 0 {
		current := heap.Pop(&pq).(*Cell)
		cost := current.effort

		x, y := current.x, current.y

		// Skip if we've already found a better effort for this cell
		if cost > effort[x][y] {
			continue
		}

		// Stop if we've reached the bottom-right cell
		if x == rows-1 && y == cols-1 {
			return cost
		}

		// Explore each direction (up, down, left, right)
		for i := 0; i < 4; i++ {
			newX, newY := x+dx[i], y+dy[i]

			// Check if the new coordinates are within bounds
			if newX < 0 || newX >= rows || newY < 0 || newY >= cols {
				continue
			}

			// Calculate new effort for the neighboring cell
			newEffort := max(effort[x][y], abs(heights[x][y]-heights[newX][newY]))

			// Update effort if a lower effort is found for the neighboring cell
			if newEffort < effort[newX][newY] {
				effort[newX][newY] = newEffort
				heap.Push(&pq, &Cell{newX, newY, newEffort})
			}
		}
	}
	return effort[rows-1][cols-1] // Minimum effort for the path to the bottom-right cell
}

// PriorityQueue is a priority queue of *Cell.
type PriorityQueue []*Cell

func (pq PriorityQueue) Len() int           { return len(pq) }
func (pq PriorityQueue) Less(i, j int) bool { return pq[i].effort < pq[j].effort }
func (pq PriorityQueue) Swap(i, j int)      { pq[i], pq[j] = pq[j], pq[i] }

func (pq *PriorityQueue) Push(x interface{}) {
	item := x.(*Cell)
	*pq = append(*pq, item)
}

func (pq *PriorityQueue) Pop() interface{} {
	old := *pq
	n := len(old)
	item := old[n-1]
	*pq = old[0 : n-1]
	return item
}

// Helper function to find the maximum of two integers
func max(a, b int) int {
	if a > b {
		return a
	}
	return b
}

// Helper function to find the absolute value of an integer
func abs(x int) int {
	if x < 0 {
		return -x
	}
	return x
}
/*



// Create a struct to represent coordinates
type Coordinate struct {
	x, y int
}

// Define changes in x and y coordinates for each direction
var directionsX = [4]int{0, 1, -1, 0}
var directionsY = [4]int{1, 0, 0, -1}

// Function to perform depth-first search (DFS)
func dfs(x, y, limitEffort int, heights [][]int, visited [][]bool) {
	if visited[x][y] {
		return
	}
	visited[x][y] = true

	// Stop if we've reached the bottom-right cell
	if x == len(heights)-1 && y == len(heights[0])-1 {
		return
	}

	// Explore each direction (up, down, left, right)
	for i := 0; i < 4; i++ {
		newX, newY := x+directionsX[i], y+directionsY[i]

		// Check if the new coordinates are within bounds
		if newX < 0 || newX >= len(heights) || newY < 0 || newY >= len(heights[0]) {
			continue
		}

		// Go to the next cell if the effort is within the limit
		newEffort := abs(heights[x][y] - heights[newX][newY])
		if newEffort <= limitEffort {
			dfs(newX, newY, limitEffort, heights, visited)
		}
	}
}

// Function to find the minimum effort path
func minimumEffortPath(heights [][]int) int {
	numRows, numCols := len(heights), len(heights[0])

	// Initialize visited array
	visited := make([][]bool, numRows)
	for i := range visited {
		visited[i] = make([]bool, numCols)
	}

	// Bound for our binary search
	lowerLimit, upperLimit := 0, 1_000_000

	for lowerLimit < upperLimit {
		mid := (upperLimit + lowerLimit) / 2
		for _, row := range visited {
			for j := range row {
				row[j] = false
			}
		}

		dfs(0, 0, mid, heights, visited)

		if visited[numRows-1][numCols-1] {
			upperLimit = mid
		} else {
			lowerLimit = mid + 1
		}
	}

	return lowerLimit
}

// Helper function to find the absolute value of an integer
func abs(x int) int {
	if x < 0 {
		return -x
	}
	return x
}
Pt

*/