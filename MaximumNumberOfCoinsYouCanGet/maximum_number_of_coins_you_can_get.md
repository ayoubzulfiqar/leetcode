# 🔥 9 - Solutions 🔥 || Simple Fast and Easy || with Explanation 😈

## Brute Force

```go

func maxCoins(piles []int) int {
	maxCoins := 0
	freq := make([]int, 100001)

	for _, i := range piles {
		freq[i]++
	}

	chances := len(piles) / 3
	turn := 1
	i := len(freq) - 1

	for chances != 0 {
		if freq[i] > 0 {
			if turn == 1 {
				turn = 0
			} else {
				maxCoins += i
				turn = 1
				chances--
			}

			freq[i]--
		} else {
			i--
		}
	}

	return maxCoins
}
```

## Heap (Priority Queue)

```go
type MaxHeap []int

func (h MaxHeap) Len() int           { return len(h) }
func (h MaxHeap) Less(i, j int) bool { return h[i] > h[j] }
func (h MaxHeap) Swap(i, j int)      { h[i], h[j] = h[j], h[i] }

func (h *MaxHeap) Push(x interface{}) {
	*h = append(*h, x.(int))
}

func (h *MaxHeap) Pop() interface{} {
	old := *h
	n := len(old)
	x := old[n-1]
	*h = old[0 : n-1]
	return x
}

type MinHeap []int

func (h MinHeap) Len() int           { return len(h) }
func (h MinHeap) Less(i, j int) bool { return h[i] < h[j] }
func (h MinHeap) Swap(i, j int)      { h[i], h[j] = h[j], h[i] }

func (h *MinHeap) Push(x interface{}) {
	*h = append(*h, x.(int))
}

func (h *MinHeap) Pop() interface{} {
	old := *h
	n := len(old)
	x := old[n-1]
	*h = old[0 : n-1]
	return x
}



func maxCoins(piles []int) int {
	minh := &MinHeap{}
	maxh := &MaxHeap{}
	heap.Init(minh)
	heap.Init(maxh)

	n := len(piles) / 3

	for i := 0; i < len(piles); i++ {
		heap.Push(minh, piles[i])
		heap.Push(maxh, piles[i])
	}

	res := 0

	for i := 0; i < n; i++ {
		heap.Pop(maxh)
		use := (*maxh)[0]
		heap.Pop(maxh)
		heap.Pop(minh)
		res += use
	}

	return res
}


```

## Sorting

```go
func maxCoins(piles []int) int {
	sort.Ints(piles)
	var n int = len(piles)
	var kt int = n / 3
	var i int = n - 2
	var ans int = 0

	for kt > 0 {
		kt--
		ans += piles[i]
		i = i - 2
	}
	return ans
}
```

## Merge Sort

```go
func maxCoins(piles []int) int {
	res := 0
	i := 1
	j := len(piles) - 1

	mergeSort(piles, 0, len(piles)-1)

	for i < j {
		res += piles[i]
		i += 2
		j--
	}

	return res
}

func mergeSort(arr []int, l, r int) {
	if l < r {
		m := (l + r) / 2
		mergeSort(arr, l, m)
		mergeSort(arr, m+1, r)
		merge(arr, l, m, r)
	}
}

func merge(arr []int, l, m, r int) {
	n1 := m - l + 1
	n2 := r - m

	L := make([]int, n1)
	R := make([]int, n2)

	for i := 0; i < n1; i++ {
		L[i] = arr[l+i]
	}
	for j := 0; j < n2; j++ {
		R[j] = arr[m+1+j]
	}

	i := 0
	j := 0
	k := l

	for i < n1 && j < n2 {
		if L[i] >= R[j] {
			arr[k] = L[i]
			i++
		} else {
			arr[k] = R[j]
			j++
		}
		k++
	}

	for i < n1 {
		arr[k] = L[i]
		i++
		k++
	}

	for j < n2 {
		arr[k] = R[j]
		j++
		k++
	}
}
```

## Binary Search

```go
func maxCoins(piles []int) int {
	sort.Ints(piles)

	s := 0
	e1 := len(piles) - 1
	e2 := len(piles) - 2

	ans := 0

	for s < e2 {
		ans += piles[e2]
		s++
		e1 -= 2
		e2 -= 2
	}

	return ans
}
```

## Greedy

```go
func maxCoins(piles []int) int {
	turns := len(piles) / 3

	sort.Sort(sort.Reverse(sort.IntSlice(piles)))

	return maxCoinsHelper(piles, turns)
}

func maxCoinsHelper(piles []int, turns int) int {
	if turns == 1 {
		return piles[1]
	}

	return piles[1] + maxCoinsHelper(piles[2:], turns-1)
}
```

## STL Sort

```go
func maxCoins(piles []int) int {
	sort.Ints(piles)

	ans := 0
	for i := len(piles)/3; i < len(piles); i += 2 {
		ans += piles[i]
	}
	return ans
}
```

## Counting Sort

```go
func maxCoins(piles []int) int {
	maxPile := 0
	for _, pile := range piles {
		if pile > maxPile {
			maxPile = pile
		}
	}

	counter := make([]int, maxPile+1)
	for _, a := range piles {
		counter[a]++
	}

	j := 0
	for i := 0; i < len(counter); i++ {
		for counter[i] > 0 {
			piles[j] = i
			j++
			counter[i]--
		}
	}

	ans := 0
	for i := len(piles)/3; i < len(piles); i += 2 {
		ans += piles[i]
	}
	return ans
}
```

## HashTable

```go

func maxCoins(piles []int) int {
	m := 0
	n := len(piles)

	for _, x := range piles {
		if x > m {
			m = x
		}
	}

	hash := make([]int, m+1)

	for _, x := range piles {
		hash[x]++
	}

	bobCoin := n / 3
	startIndex := 1

	for bobCoin > 0 {
		if hash[startIndex] > 0 {
			hash[startIndex]--
			bobCoin--
		} else {
			startIndex++
		}
	}

	i := m
	ans := 0
	receive := 0

	for i >= startIndex {
		if hash[i] > 0 {
			ans += receive * i
			receive = receive ^ 1
			hash[i]--
		} else {
			i--
		}
	}

	return ans
}
```

## [GitHub](https://github.com/ayoubzulfiqar/leetcode)
