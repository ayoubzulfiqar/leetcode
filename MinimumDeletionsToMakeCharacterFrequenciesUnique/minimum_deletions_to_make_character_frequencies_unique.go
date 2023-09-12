package main

type DSU struct {
	par []int
}

func NewDSU(n int) *DSU {
	par := make([]int, n+1)
	for i := 0; i <= n; i++ {
		par[i] = i
	}
	return &DSU{par}
}

func (d *DSU) findPar(x int) int {
	if x == d.par[x] {
		return x
	}
	d.par[x] = d.findPar(d.par[x])
	return d.par[x]
}

func (d *DSU) merge(u, v int) {
	d.par[v] = u
}

func minDeletions(s string) int {
	// Using DSU
	// Think of this problem as a Job Sequencing Problem

	// First, store the frequency of all characters
	a := make([]int, 26)
	n := len(s)
	for i := 0; i < n; i++ {
		a[int(s[i]-'a')]++
	}

	// Find the maximum among all the frequencies
	maxi := 0
	for _, it := range a {
		if it > maxi {
			maxi = it
		}
	}

	// Make DSU of size - maximum
	d := NewDSU(maxi)
	cnt := 0 // cnt stores the answer

	for i := 0; i < 26; i++ {
		// Find the nearest available free slot for
		// this frequency (corresponding to its frequency)
		available := d.findPar(a[i])

		// If an available free slot is greater
		// than 0, then a free slot is available
		if available > 0 {
			// This slot is taken by this job 'i'
			// so we need to update the greatest(nearest)
			// free slot. Note that, in merge, we
			// make the first parameter as the parent of
			// the second parameter. So future queries
			// for availableSlot will return the maximum(nearest)
			// available slot in the set of
			// "availableSlot - 1"
			d.merge(d.findPar(available-1), available)
		}
		// We assign the nearest (greatest) frequency now
		// (frequency-assign slot) will be the number of
		// removed characters (answer)
		cnt += (a[i] - available)
	}
	return cnt
}
