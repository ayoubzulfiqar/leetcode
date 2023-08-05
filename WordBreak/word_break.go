package main

type DisjointSet struct {
	roots []int
	rank  []int
}

func NewDisjointSet(n int) *DisjointSet {
	ds := &DisjointSet{
		roots: make([]int, n),
		rank:  make([]int, n),
	}
	for i := 0; i < n; i++ {
		ds.roots[i] = i
		ds.rank[i] = 0
	}
	return ds
}

func (ds *DisjointSet) find(x int) int {
	if ds.roots[x] == x {
		return x
	}
	s := []int{}
	for ds.roots[x] != x {
		s = append(s, x)
		x = ds.roots[x]
	}
	for len(s) > 0 {
		ds.roots[s[len(s)-1]] = x
		s = s[:len(s)-1]
	}
	return x
}

func (ds *DisjointSet) isConnected(x, y int) bool {
	return ds.find(x) == ds.find(y)
}

func (ds *DisjointSet) union(x, y int) {
	rX := ds.find(x)
	rY := ds.find(y)
	if rX == rY {
		return
	}
	if ds.rank[rX] > ds.rank[rY] {
		ds.roots[rY] = rX
	} else if ds.rank[rX] < ds.rank[rY] {
		ds.roots[rX] = rY
	} else {
		ds.roots[rY] = rX
		ds.rank[rX]++
	}
}

func wordBreak(s string, wordDict []string) bool {
	disjointSet := NewDisjointSet(len(s) + 1)
	for i := 0; i < len(wordDict); i++ {
		for j := 0; j < len(s); j++ {
			isValid := true
			for k := 0; k < len(wordDict[i]); k++ {
				if j+k >= len(s) {
					isValid = false
					break
				}
				if wordDict[i][k] != s[j+k] {
					isValid = false
					break
				}
			}
			if isValid {
				disjointSet.union(j, j+len(wordDict[i]))
			}
		}
	}
	return disjointSet.isConnected(0, len(s))
}
