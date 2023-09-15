# 🔥 Go - Prim's Algorithm  & Kruskal's Algorithm 🔥 || Simple Fast and Easy || with Explanation 😈


## Explanation

This code implements an algorithm to find the minimum cost to connect all given points in a 2D plane. It uses the Manhattan distance (the sum of absolute differences in x and y coordinates) between points as the cost for connecting them.

The code first constructs an adjacency list representation of a graph where each node corresponds to a point, and edges represent the distances between points. It then uses Prim's algorithm, which is a greedy algorithm, to find the minimum spanning tree (MST) of this graph. The sum of distances in the MST is the minimum cost to connect all points.

Here's a step-by-step explanation:

1. **Data Structures**:
   - `Pair` struct: Represents a node and its distance.
   - `PairHeap` type: A custom data structure to implement a priority queue for `Pair` objects using Go's heap package.

2. **Adjacency List**:
   - Construct an adjacency list (`adjList`) to represent the graph. Each node (point) has a list of neighboring nodes (other points) along with their distances.

3. **Edge Calculation**:
   - Calculate the Manhattan distance between all pairs of points and add these distances as edges to the adjacency list. This step creates a fully connected graph.

4. **Initialization**:
   - Initialize a boolean array `visited` to keep track of visited nodes.
   - Initialize a priority queue (`pq`) with the initial node (node 0) and distance 0.

5. **Prim's Algorithm**:
   - Repeat until the priority queue is not empty:
     - Pop the node with the smallest distance from the priority queue.
     - If the node is already visited, skip it.
     - Mark the node as visited and add its distance to the total sum.
     - Explore neighboring nodes and add them to the priority queue if they haven't been visited yet.

6. **Result**:
   - The final `sum` contains the minimum cost to connect all points.

### Intuition and Approach

The intuition behind this code is to find the minimum cost to connect all given points by treating them as nodes in a graph. The approach involves constructing a fully connected graph with distances between all pairs of points and then using Prim's algorithm to find the minimum spanning tree, which represents the minimum cost to connect all points.

1. **Initialize Graph**: Create a graph where nodes represent points, and edges represent distances between points.

2. **Greedy Approach**: Use Prim's algorithm to greedily select the shortest edges while avoiding cycles to build a minimum spanning tree.

3. **Sum Distances**: Sum the distances of the edges in the minimum spanning tree to find the minimum cost.

### Time Complexity

- Constructing the adjacency list takes O(n^2) time, where n is the number of points.
- Prim's algorithm using a priority queue takes O(n^2 * log(n)) time in the worst case.
- Overall, the time complexity is O(n^2 * log(n)).

### Space Complexity

- The space complexity is O(n^2) for the adjacency list and O(n) for other data structures.
- Overall, the space complexity is O(n^2).

This code efficiently finds the minimum cost to connect all points in a 2D plane by leveraging Prim's algorithm and a priority queue data structure.

## Code - Prim's Algo
```go
import (
    "container/heap" // Importing the heap package for priority queue operations
    "math"           // Importing the math package for absolute value calculation
)

// Pair represents a node and its distance
type Pair struct {
    node     int // Node index
    distance int // Distance from the starting node
}

// PairHeap is a custom data structure to implement a priority queue for Pairs
type PairHeap []Pair

// Implementing the heap.Interface methods for PairHeap

// Len returns the number of elements in the heap
func (h PairHeap) Len() int { return len(h) }

// Less returns true if the element at index i has a smaller distance than the element at index j
func (h PairHeap) Less(i, j int) bool { return h[i].distance < h[j].distance }

// Swap swaps the elements at indices i and j in the heap
func (h PairHeap) Swap(i, j int) { h[i], h[j] = h[j], h[i] }

// Push adds a Pair to the heap
func (h *PairHeap) Push(x interface{}) {
    *h = append(*h, x.(Pair))
}

// Pop removes and returns the top element from the heap
func (h *PairHeap) Pop() interface{} {
    old := *h
    n := len(old)
    x := old[n-1]
    *h = old[0 : n-1]
    return x
}

// minCostConnectPoints finds the minimum cost to connect all points
func minCostConnectPoints(points [][]int) int {
    n := len(points) // Number of points

    // Create an adjacency list to represent the graph
    adjList := make([][]Pair, n)
    for i := 0; i < n; i++ {
        adjList[i] = make([]Pair, 0)
    }

    // Populate the adjacency list with distances between points
    for i := 0; i < n; i++ {
        for j := i; j < n; j++ {
            first := points[i]
            second := points[j]
            // Calculate the Manhattan distance between two points
            weight := int(math.Abs(float64(first[0]-second[0])) + math.Abs(float64(first[1]-second[1])))
            // Add the edge to the adjacency list (both directions)
            adjList[i] = append(adjList[i], Pair{j, weight})
            adjList[j] = append(adjList[j], Pair{i, weight})
        }
    }

    // Initialize visited array to keep track of visited nodes
    visited := make([]bool, n)

    // Initialize a priority queue (min-heap) for Pair objects with initial node 0 and distance 0
    pq := make(PairHeap, 0)
    heap.Init(&pq)
    pq = append(pq, Pair{0, 0})

    // Initialize a variable to keep track of the total sum of distances
    sum := 0

    // Prim's algorithm for finding minimum spanning tree
    for len(pq) > 0 {
        pair := heap.Pop(&pq).(Pair)
        node := pair.node
        dist := pair.distance

        // If the node is already visited, skip it
        if visited[node] {
            continue
        }

        // Mark the node as visited and add its distance to the sum
        visited[node] = true
        sum += dist

        // Explore neighboring nodes
        for _, adj := range adjList[node] {
            adjNode := adj.node
            adjDistance := adj.distance

            // If the neighboring node is not visited, add it to the priority queue
            if !visited[adjNode] {
                heap.Push(&pq, Pair{adjNode, adjDistance})
            }
        }
    }

    // Return the minimum cost to connect all points
    return sum
}
```

## Code - Kruskal's Algo

```go
import "sort"

// DSU represents the Disjoint-Set Union data structure
type DSU struct {
	parent []int // Parent array for disjoint set representation
	rank   []int // Rank array for optimization
}

// NewDSU initializes a new DSU with n nodes
func NewDSU(n int) *DSU {
	dsu := &DSU{
		parent: make([]int, n+1), // Initialize parent array
		rank:   make([]int, n+1), // Initialize rank array
	}
	// Initialize each node's parent to itself
	for i := 0; i <= n; i++ {
		dsu.parent[i] = i
	}
	return dsu
}

// findUpar finds the parent (representative) of a node with path compression
func (dsu *DSU) findUpar(node int) int {
	if node == dsu.parent[node] {
		return node
	}
	dsu.parent[node] = dsu.findUpar(dsu.parent[node]) // Path compression
	return dsu.parent[node]
}

// unionByrank performs union operation of two sets by rank
func (dsu *DSU) unionByrank(u, v int) {
	ulp_u := dsu.findUpar(u)
	ulp_v := dsu.findUpar(v)
	if ulp_u == ulp_v {
		return
	}
	if dsu.rank[ulp_u] < dsu.rank[ulp_v] {
		dsu.parent[ulp_u] = ulp_v
	} else if dsu.rank[ulp_v] < dsu.rank[ulp_u] {
		dsu.parent[ulp_v] = ulp_u
	} else {
		dsu.parent[ulp_v] = ulp_u
		dsu.rank[ulp_u]++
	}
}

// minCostConnectPoints finds the minimum cost to connect all points
func minCostConnectPoints(points [][]int) int {
	n := len(points)
	dsu := NewDSU(n)         // Initialize DSU with n nodes
	edges := make([][]int, 0) // Initialize a slice to store edges

	// Create edges by calculating distances between all pairs of points
	for i := 0; i < n; i++ {
		for j := i + 1; j < n; j++ {
			edge := []int{i, j, abs(points[i][0]-points[j][0]) + abs(points[i][1]-points[j][1])}
			edges = append(edges, edge)
		}
	}

	// Sort the edges by weight in ascending order
	sort.Slice(edges, func(i, j int) bool {
		return edges[i][2] < edges[j][2]
	})

	ans := 0
	// Process edges in ascending order of weight (Greedy Kruskal's algorithm)
	for _, edge := range edges {
		u := edge[0]
		v := edge[1]
		w := edge[2]
		if dsu.findUpar(u) == dsu.findUpar(v) {
			continue // Skip if adding this edge forms a cycle
		}
		ans += w
		dsu.unionByrank(u, v) // Union the two sets
	}
	return ans
}

// abs returns the absolute value of an integer
func abs(x int) int {
	if x < 0 {
		return -x
	}
	return x
}
```
