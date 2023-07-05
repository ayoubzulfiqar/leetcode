package main

type DisjointSet struct {
	parent []int
	size   []int
}

func NewDisjointSet(n int) *DisjointSet {
	size := make([]int, n+1)
	parent := make([]int, n+1)

	for i := 0; i <= n; i++ {
		size[i] = 1
		parent[i] = i
	}

	return &DisjointSet{
		parent: parent,
		size:   size,
	}
}

func (ds *DisjointSet) findParent(node int) int {
	if ds.parent[node] == node {
		return node
	}
	ds.parent[node] = ds.findParent(ds.parent[node])
	return ds.parent[node]
}

func (ds *DisjointSet) unionBySize(u, v int) {
	pU := ds.findParent(u)
	pV := ds.findParent(v)

	if pU == pV {
		return
	}

	if ds.size[pU] < ds.size[pV] {
		ds.parent[pU] = pV
		ds.size[pV] += ds.size[pU]
	} else {
		ds.parent[pV] = pU
		ds.size[pU] += ds.size[pV]
	}
}

func longestSubarray(nums []int) int {
	n := len(nums)
	s := 0

	for _, x := range nums {
		s += x
	}
	if s == n {
		return s - 1
	}
	if s == 1 || s == 0 {
		return s
	}

	ds := NewDisjointSet(n)

	for i := 0; i < n-1; i++ {
		if nums[i] == 1 && nums[i+1] == 1 {
			if ds.findParent(i) != ds.findParent(i+1) {
				ds.unionBySize(i, i+1)
			}
		}
	}

	ans := 0
	for i := 1; i < n-1; i++ {
		if nums[i] == 0 {
			tSum := 0
			if nums[i-1] == 1 {
				tSum += ds.size[ds.findParent(i-1)]
			}
			if nums[i+1] == 1 {
				tSum += ds.size[ds.findParent(i+1)]
			}
			if tSum > ans {
				ans = tSum
			}
		}
	}

	if ans > ds.size[0] {
		return ans
	}
	return ds.size[0]
}
