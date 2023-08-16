# 🔥 Go - Heap 🔥 || Simple Fast and Easy || with Explanation 😈

## Intuition

The problem involves finding the maximum value within a sliding window of size `k` as it moves over an array of integers. This can be efficiently solved using a max-heap (priority queue) that stores pairs of indices and corresponding values. As the window slides, the heap helps in keeping track of the maximum value within the current window.

## Approach

1. Create a `Pair` struct that stores the index and value of an element.
2. Define a `PairHeap` type that implements heap functions (`Len`, `Less`, `Swap`, `Push`, `Pop`) for managing the priority queue of pairs. The heap is ordered by values in descending order. If values are equal, it's further ordered by index in ascending order.
3. Initialize an empty priority queue (`pq`) of type `PairHeap`.
4. Iterate through the array using two pointers `i` and `j`, where `j` represents the right end of the sliding window.
5. Add elements to the priority queue while incrementing `j`. If the window size is less than `k`, only `j` is incremented.
6. When the window size equals `k`, start processing:
   - Remove elements from the heap that are outside the current window range (i.e., their indices are less than `i`).
   - Peek at the max element in the heap (the root of the max-heap).
   - Store this max value in the `res` array at the corresponding index.
   - If the index of the max element is less than `i+1`, remove it from the heap.
   - Slide the window by incrementing `i` and `j`.
7. Continue this process until `j` reaches the end of the array.
8. Return the `res` array containing the maximum values within each sliding window.

## Time Complexity

- The max-heap operations (push and pop) take O(log k) time, where `k` is the window size.
- Since each element is pushed and popped from the heap at most once, the overall time complexity is O(n log k), where `n` is the length of the input array.

## Space Complexity

- The space complexity is O(k), as the priority queue (`pq`) stores at most `k` elements.

## Code

```go

import "container/heap"
 
type Pair struct {
 index, value int
}

type PairHeap []Pair

func (h PairHeap) Len() int           { return len(h) }
func (h PairHeap) Less(i, j int) bool { return h[i].value > h[j].value || (h[i].value == h[j].value && h[i].index < h[j].index) }
func (h PairHeap) Swap(i, j int)      { h[i], h[j] = h[j], h[i] }

func (h *PairHeap) Push(x interface{}) {
 *h = append(*h, x.(Pair))
}

func (h *PairHeap) Pop() interface{} {
 old := *h
 n := len(old)
 x := old[n-1]
 *h = old[0 : n-1]
 return x
}

func maxSlidingWindow(nums []int, k int) []int {
 res := make([]int, len(nums)-k+1)

 i, j, index := 0, 0, 0
 pq := &PairHeap{}
 heap.Init(pq)

 for j < len(nums) {
  pair := Pair{j, nums[j]}
  heap.Push(pq, pair)
  if j-i+1 < k {
   j++
  } else if j-i+1 == k {
   for (*pq)[0].index < i {
    heap.Pop(pq)
   }
   first := (*pq)[0]
   res[index] = first.value
   if first.index < i+1 {
    heap.Pop(pq)
   }
   i++
   j++
   index++
  }
 }

 return res
}
```

## [GitHub](https://github.com/ayoubzulfiqar/leetcode)
