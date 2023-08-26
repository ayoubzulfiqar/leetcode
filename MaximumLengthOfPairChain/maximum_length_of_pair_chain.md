
# 🔥 GO-  Greedy Graph Matrix & BucketSort & TopoSort  🔥 || Simple Fast and Easy || with Explanation 😈

## Code - Greedy Graph Matrix

### Explanation

This code is designed to find the length of the longest chain of pairs in the given list of pairs. A pair is represented as `[a, b]`, where `a` is the starting value and `b` is the ending value.

The code first sorts the input pairs based on their ending values in ascending order. Then, it iterates through the sorted pairs and keeps track of the last selected pair's ending value (`pairEnd`). It increments a counter (`count`) whenever it encounters a pair whose starting value is greater than `pairEnd`, indicating that a new chain can be formed.

Finally, the code returns the value of the `count`, which represents the length of the longest chain.

### Intuition and Approach

- **Intuition**: Sorting the pairs based on their ending values and then greedily selecting pairs that form a valid chain.

- **Approach**:
  1. Sort the input pairs based on their ending values in ascending order.
  2. Initialize a counter `count` to keep track of the chain length and a variable `pairEnd` to keep track of the ending value of the last selected pair.
  3. Iterate through the sorted pairs starting from the second pair:
     - If the current pair's starting value is greater than `pairEnd`, increment `count` and update `pairEnd` to the ending value of the current pair.
  4. Return the value of `count` as the length of the longest chain.

### Space Complexity

- The space complexity of this solution is O(1) since it only uses a constant amount of additional space for variables like `count` and `pairEnd`.

### Time Complexity

- The most time-consuming operation is the sorting of the pairs, which takes O(n * log n) time complexity, where n is the number of pairs.
- The subsequent loop through the sorted pairs has a linear time complexity of O(n).
- Therefore, the overall time complexity of the solution is O(n * log n), dominated by the sorting step.

```go
import "sort"

func findLongestChain(pairs [][]int) int {
 sort.Slice(pairs, func(i, j int) bool {
  return pairs[i][1] < pairs[j][1]
 })

 count := 1
 pairEnd := pairs[0][1]

 for i := 1; i < len(pairs); i++ {
  if pairs[i][0] > pairEnd {
   count++
   pairEnd = pairs[i][1]
  }
 }

 return count
}
```

## Code - Topo Sort

### Explanation

This code is designed to find the length of the longest chain of pairs in the given list of pairs. Each pair is represented as `[a, b]`, where `a` is the starting value and `b` is the ending value.

The code constructs a directed graph where each node represents a pair. An edge exists from pair `i` to pair `j` if the ending value of pair `i` is strictly less than the starting value of pair `j`.

The code performs a topological sorting of the graph and calculates the longest chain length using dynamic programming.

### Intuition and Approach

- **Intuition**: Construct a directed graph where pairs are nodes and edges represent valid connections between pairs. Perform topological sorting and dynamic programming to find the longest chain.

- **Approach**:
  1. Construct a directed graph where nodes represent pairs and edges exist if one pair can be followed by another pair in a valid chain.
  2. Calculate in-degrees for each node (pair) to identify nodes that can be the starting point of a chain.
  3. Perform topological sorting using a queue. For each node processed, update the distance (length of the chain) for its adjacent nodes.
  4. Keep track of the maximum chain length during the traversal.
  5. Return the maximum chain length + 1.

### Space Complexity

- The space complexity of this solution is O(n^2), where n is the number of pairs. It uses space for the adjacency list, in-degree array, queue, and distance array.

### Time Complexity

- The nested loops that construct the adjacency list have a time complexity of O(n^2).
- The topological sorting step involves processing each node once and each edge once, resulting in a linear time complexity of O(n^2).
- Overall, the time complexity of the solution is O(n^2), where n is the number of pairs.

```go
func findLongestChain(pairs [][]int) int {
 n := len(pairs)
 inDegree := make([]int, n)
 adj := make([][]int, n)
 for i := range adj {
  adj[i] = []int{}
 }

 for i := 0; i < n; i++ {
  for j := 0; j < n; j++ {
   if pairs[i][1] < pairs[j][0] {
    adj[i] = append(adj[i], j)
    inDegree[j]++
   }
  }
 }

 q := []int{}
 for i := 0; i < n; i++ {
  if inDegree[i] == 0 {
   q = append(q, i)
  }
 }

 distance := make([]int, n)
 for i := range distance {
  distance[i] = 0
 }

 for len(q) > 0 {
  node := q[0]
  q = q[1:]

  for _, i := range adj[node] {
   inDegree[i]--
   if distance[i] < 1+distance[node] {
    distance[i] = 1 + distance[node]
   }
   if inDegree[i] == 0 {
    q = append(q, i)
   }
  }
 }

 maxValue := 0
 for _, val := range distance {
  if val > maxValue {
   maxValue = val
  }
 }

 return maxValue + 1
}
```

## Code - Bucket Sort

### Explanation

This code is designed to find the length of the longest chain of pairs in the given list of pairs. Each pair is represented as `[a, b]`, where `a` is the starting value and `b` is the ending value.

The code employs a greedy approach to solve the problem. It processes the pairs to create a timeline of pairs' starting and ending values and then counts the length of the longest chain based on this timeline.

### Intuition and Approach

- **Intuition**: Create a timeline of pairs' starting and ending values and count the length of the longest chain based on this timeline.

- **Approach**:
  1. Initialize a timeline array of length 2001 to store pairs' starting values based on their ending values.
  2. Iterate through each pair:
     - Convert starting and ending values by adding 1000 to shift them to non-negative indices in the timeline array.
     - Update the `max` value to keep track of the highest ending value.
     - Update the timeline by storing the maximum starting value for the given ending value.
  3. Initialize variables `l` for counting the chain length and `k` for tracking the current time value.
  4. Iterate through the timeline from 0 to the maximum ending value `max`:
     - If the starting value in the timeline is greater than `k`, increment the chain length `l` and update `k`.
  5. Return the value of `l`, which represents the length of the longest chain.

### Space Complexity

- The space complexity of this solution is O(1) since it uses a constant amount of additional space for variables like `max`, `timeline`, `l`, and `k`.

### Time Complexity

- The time complexity of this solution is O(n), where n is the number of pairs. The loops for constructing the timeline and calculating the chain length both iterate through the list of pairs once.
- The loop for calculating the chain length is bounded by the maximum ending value `max`, which is constant.
- Therefore, the overall time complexity is linear, O(n).

```go
func findLongestChain(pairs [][]int) int {
 max := 0
 timeline := make([]int, 2001)
 
 for _, pair := range pairs {
  s := pair[0] + 1000
  f := pair[1] + 1000
  if f > max {
   max = f
  }
  if timeline[f] < s {
   timeline[f] = s
  }
 }
 
 l := 0
 k := 0
 for i := 0; i <= max; i++ {
  if timeline[i] > k {
   l++
   k = i
  }
 }
 
 return l
}
```

## [GitHub](https://github.com/ayoubzulfiqar/leetcode)
