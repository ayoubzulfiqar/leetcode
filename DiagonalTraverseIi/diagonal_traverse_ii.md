# 🔥 Diagonal Traverse II 🔥 || Simple Fast and Easy || with Explanation 😈

## Intuition

The intuition behind this code is to traverse the 2D array diagonally and store the elements in a jagged array (slice of slices), where each inner slice represents a diagonal. After storing the elements, iterate over the jagged array in reverse order and add the elements to the result list.

## Approach

1. Initialize a jagged array (`res`) to store elements based on their diagonal indices and variables `m` and `size`.
2. Iterate through the input 2D array (`nums`) and calculate the diagonal index for each element.
3. Check if the jagged array already contains a slice for the current diagonal index. If not, create a new slice and add the element to it. If yes, append the element to the existing slice.
4. Iterate through the jagged array and its slices in reverse order.
5. For each diagonal, iterate through the slice of elements (in reverse order) and add them to the result list.
6. Return the final result list.

```go
func findDiagonalOrder(nums [][]int) []int {
	var res [][]int
	m, size := len(nums), 0

	// Traverse the 2D array and store elements in the jagged array
	for i := 0; i < m; i++ {
		n, x := len(nums[i]), i
		for j := 0; j < n; j++ {
			// Check if the jagged array needs a new slice for the current diagonal index
			if len(res) == x {
				res = append(res, []int{})
			}
			// Append the element to the slice corresponding to the current diagonal
			res[x] = append(res[x], nums[i][j])
			x++
			size++
		}
	}

	// Initialize the result list with the correct size
	ans := make([]int, size)
	idx := 0

	// Iterate through the jagged array in reverse order and populate the result list
	for i := 0; i < len(res); i++ {
		for j := len(res[i]) - 1; j >= 0; j-- {
			ans[idx] = res[i][j]
			idx++
		}
	}

	return ans
}
```

## Time Complexity

Let \(m\) be the number of rows and \(n\) be the maximum number of columns in the 2D array.

- The nested loops traverse each element of the 2D array, taking \(O(m \times n)\) time.
- The iteration over the jagged array and its slices takes \(O(m + n)\) time in the worst case.

Therefore, the overall time complexity is \(O(m \times n + m + n) \approx O(m \times n)\).

## Space Complexity

- The jagged array (`res`) stores elements based on diagonal indices, and in the worst case, it may store all elements. Therefore, the space complexity is \(O(m \times n)\).
- The result list (`ans`) stores the final diagonal order, and its space complexity is also \(O(m \times n)\).

The dominant factor is the space complexity of the jagged array, so the overall space complexity is \(O(m \times n)\).

## Solution - 2 Queue

**Intuition:**

The intuition behind this code is to perform a breadth-first traversal on the given 2D array, simulating a diagonal order traversal. A queue is used to keep track of the current position (row and column) being processed. The algorithm processes each element in the queue and updates the queue with the positions of its unprocessed neighbors.

**Approach:**

1. Initialize a queue (`queue`) to store the positions `[row, col]` to be processed and variables `numRows` and `elements`.
2. Iterate through the input 2D array (`nums`) and calculate the initial number of elements in the array (`elements`).
3. Initialize a result array (`res`) with the correct size.
4. While the queue is not empty, process each element in the queue, updating the result array and queue with the positions of unprocessed neighbors.
5. Return the final result array.

```go
func findDiagonalOrder(nums [][]int) []int {
	// Initialize a queue to store positions [row, col]
	queue := list.New()
	queue.PushBack([2]int{0, 0})
	numRows := len(nums)
	var elements int

	// Calculate the initial number of elements in the array
	for _, lst := range nums {
		elements += len(lst)
	}

	// Initialize the result array with the correct size
	res := make([]int, elements)
	resIdx := 0

	// While the queue is not empty, process each element
	for queue.Len() > 0 {
		size := queue.Len()

		for i := 0; i < size; i++ {
			// Dequeue the next position
			next := queue.Remove(queue.Front()).([2]int)
			row, col := next[0], next[1]

			currentList := nums[row]

			// Skip if the element has already been processed
			if currentList[col] == math.MaxInt32 {
				continue
			}

			// Update the result array with the current element
			res[resIdx] = currentList[col]
			resIdx++

			// Mark the current element as processed
			currentList[col] = math.MaxInt32

			// Enqueue the position of the unprocessed neighbor below (if exists)
			if row+1 < numRows && len(nums[row+1]) > col && nums[row+1][col] != math.MaxInt32 {
				queue.PushBack([2]int{row + 1, col})
			}

			// Enqueue the position of the unprocessed neighbor to the right (if exists)
			if col+1 < len(currentList) && currentList[col+1] != math.MaxInt32 {
				queue.PushBack([2]int{row, col + 1})
			}
		}
	}

	return res
}
```

**Time Complexity:**

Let \(m\) be the number of rows and \(n\) be the maximum number of columns in the 2D array.

- The nested loops traverse each element of the 2D array, taking \(O(m \times n)\) time.
- Each position is enqueued and dequeued once, taking \(O(m \times n)\) time in the worst case.

Therefore, the overall time complexity is \(O(m \times n + m \times n) \approx O(m \times n)\).

**Space Complexity:**

- The space complexity is dominated by the queue, which may store all positions in the worst case, leading to a space complexity of \(O(m \times n)\).
- The result array (`res`) also contributes to the space complexity, but it is of the same order as the queue.

The overall space complexity is \(O(m \times n)\).

## Solution - 3

**Intuition:**

The code aims to traverse a 2D array diagonally and collect elements in a specific order. It provides two approaches, one using a standard BFS approach with a queue, and another using an adjacency list to organize elements based on their diagonal indices.

**Approach:**

1. **BFS Approach (commented out):**
    - Initialize a queue with the starting position `[0, 0]` and an empty result array (`ans`).
    - Perform a standard BFS traversal:
        - Dequeue the front element `[i, j]` from the queue.
        - Add the element at `[i, j]` to the result array.
        - Enqueue the position `[i+1, j]` if `j == 0` and `i+1 < m`.
        - Enqueue the position `[i, j+1]` if `(i >= 0 && i < m)` and `(j+1 >= 0 && j+1 < len(nums[i]))`.
    - Return the result array.

2. **Adjacency List Approach:**
    - Calculate the maximum number of columns (`n`) among all rows.
    - Create an adjacency list (`adjList`) to store elements based on their diagonal indices.
    - Initialize an empty result array (`ans`).
    - Populate the adjacency list by iterating through the 2D array and adding elements to the corresponding diagonal.
    - Reverse each list in the adjacency list.
    - Traverse the adjacency list and add elements to the result array.
    - Return the result array.

**Time Complexity:**

Let \(m\) be the number of rows and \(n\) be the maximum number of columns in the 2D array.

- **BFS Approach:**
  - The nested loops traverse each element of the 2D array, taking \(O(m \times n)\) time.
  - Each position is enqueued and dequeued once, taking \(O(m \times n)\) time in the worst case.
  - Therefore, the overall time complexity is \(O(m \times n + m \times n) \approx O(m \times n)\).

- **Adjacency List Approach:**
  - The nested loops traverse each element of the 2D array, taking \(O(m \times n)\) time.
  - Reversing each list in the adjacency list takes \(O(m + n)\) time in the worst case.
  - Iterating through the adjacency list and adding elements to the result array takes \(O(m + n)\) time in the worst case.
  - Therefore, the overall time complexity is \(O(m \times n + m + n) \approx O(m \times n)\).

**Space Complexity:**

- **BFS Approach:**
  - The space complexity is dominated by the queue, which may store all positions in the worst case, leading to a space complexity of \(O(m \times n)\).
  - The result array (`ans`) also contributes to the space complexity, but it is of the same order as the queue.
  - The overall space complexity is \(O(m \times n)\).

- **Adjacency List Approach:**
  - The adjacency list (`adjList`) stores elements based on diagonal indices, and in the worst case, it may store all elements. Therefore, the space complexity is \(O(m \times n)\).
  - The result array (`ans`) stores the final diagonal order, and its space complexity is also \(O(m \times n)\).
  - The overall space complexity is \(O(m \times n)\).

```go
func findDiagonalOrder(nums [][]int) []int {
	m := len(nums)

	// Standard BFS Approach -> Level Order Traversal
	// queue := [][]int{{0, 0}}
	// var ans []int

	// for len(queue) > 0 {
	// 	i, j := queue[0][0], queue[0][1]
	// 	queue = queue[1:]

	// 	ele := nums[i][j]
	// 	ans = append(ans, ele)

	// 	if j == 0 && i+1 < m {
	// 		queue = append(queue, []int{i + 1, j})
	// 	}

	// 	if (i >= 0 && i < m) && (j+1 >= 0 && j+1 < len(nums[i])) {
	// 		queue = append(queue, []int{i, j + 1})
	// 	}
	// }

	// return ans

	// BFS 2nd Approach -> Creating adjacency list
	n := 0
	for _, i := range nums {
		if len(i) > n {
			n = len(i)
		}
	}
	adjList := make([][]int, m+n)
	var ans []int

	for i := 0; i < m; i++ {
		for j := 0; j < len(nums[i]); j++ {
			adjList[i+j] = append(adjList[i+j], nums[i][j])
		}
	}

	for i := 0; i < m+n; i++ {
		reverseSlice(adjList[i])
	}

	for i := 0; i < m+n; i++ {
		for j := 0; j < len(adjList[i]); j++ {
			ans = append(ans, adjList[i][j])
		}
	}

	return ans
}

func reverseSlice(slice []int) {
	i, j := 0, len(slice)-1
	for i < j {
		slice[i], slice[j] = slice[j], slice[i]
		i++
		j--
	}
}
```

## [GitHub](https://github.com/ayoubzulfiqar/leetcode)
