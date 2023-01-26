package main

import "math"

type Connection struct {
	city int
	cost int
}

type queue []Connection

func (q *queue) push(c Connection) {
	q1 := []Connection{c}
	*q = append(*q, q1...)
}

func (q *queue) pop() (bool, Connection) {

	if q.isEmpty() {
		return false, Connection{}
	} else {
		elem := (*q)[0]
		*q = (*q)[1:]
		return true, elem
	}
}

func (q queue) isEmpty() bool {
	return q.size() <= 0
}

func (q queue) size() int {
	return len(q)
}

func findCheapestPrice(n int, flights [][]int, src int, dst int, k int) int {

	minCost := math.MaxInt64

	fQueue := new(queue)
	fQueue.push(Connection{src, 0})

	maxStops := k + 1

	costOfFlights := make([][]int, n)
	for i := range costOfFlights {
		costOfFlights[i] = make([]int, n)
	}

	flightsMap := make(map[int][]int)
	for _, v := range flights {
		if _, ok := flightsMap[v[0]]; ok {
			flightsMap[v[0]] = append(flightsMap[v[0]], v[1])
		} else {
			flightsMap[v[0]] = []int{v[1]}
		}

		costOfFlights[v[0]][v[1]] = v[2]
	}

	cityPathCost := make([]int, n) // path cost from source
	for i := range cityPathCost {
		cityPathCost[i] = math.MaxInt64
	}

	cityPathCost[src] = 0

	for !fQueue.isEmpty() && maxStops >= 0 {

		size := fQueue.size()
		maxStops--

		for size > 0 {
			_, c := fQueue.pop()
			size--

			if c.city == dst {
				if minCost > c.cost {
					minCost = c.cost
				}
				continue
			}

			for _, v := range flightsMap[c.city] {

				newCost := c.cost + costOfFlights[c.city][v]

				if cityPathCost[v] > newCost {
					fQueue.push(Connection{v, newCost})
					cityPathCost[v] = newCost
				}
			}
		}
	}

	if minCost == math.MaxInt64 {
		minCost = -1
	}

	return minCost
}
