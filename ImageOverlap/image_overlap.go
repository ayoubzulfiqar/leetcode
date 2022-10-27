package main

type tuple struct {
	x int
	y int
}

func max(x, y int) int {
	if x > y {
		return x
	}
	return y
}

func largestOverlap(A [][]int, B [][]int) int {
	var pA []tuple
	var pB []tuple
	for i := 0; i < len(A); i++ {
		for j := 0; j < len(A[0]); j++ {
			if A[i][j] == 1 {
				pA = append(pA, tuple{i, j})
			}
			if B[i][j] == 1 {
				pB = append(pB, tuple{i, j})
			}
		}
	}

	mp := make(map[tuple]int)
	ans := 0
	for _, a := range pA {
		for _, b := range pB {
			diff := tuple{a.x - b.x, a.y - b.y}
			mp[diff]++
			ans = max(ans, mp[diff])
		}
	}

	return ans
}

/*





func largestOverlap(A [][]int, B [][]int) int {
	aValues := make([]int, len(A))
	bValues := make([]int, len(B))
	for i, vs := range A {
		for j, v := range vs {
			if v == 1 {
				aValues[i] += 1 << j
			}
			if B[i][j] == 1 {
				bValues[i] += 1 << j
			}
		}
	}
	maxValue := 0
	// i: row offset
	// j: col offset
	for i := 0; i < len(A); i++ {
		for j := 0; j < len(A); j++ {
			current1, current2 := 0, 0
			for m := 0; m + i < len(A); m++ {
				current1 += getOne(aValues[m] & (bValues[i+m] >> j))
				current2 += getOne(bValues[m] & (aValues[i+m] >> j))
			}
			if current1 > maxValue {
				maxValue = current1
			}
			if current2 > maxValue {
				maxValue = current2
			}
		}
	}
	return maxValue
}

func getOne(v int) int {
	n := 0
	for v != 0 {
		if v & 0x1 == 1 {
			n++
		}
		v >>= 1
	}
	return n
}


-------------------------------------------------


func max(a, b int) int {
    if a < b {
        return b
    }
    return a
}

// over lap function finds the number 1's that are over lapping in the current subset.
func overlap(A, B [][]int, h, w int) int {
    n := len(A)
    counter := 0

    // again iterate over till row 'h'
    for i := 0; i < h; i++ {
        // iterate current row till column 'w'
        for j := 0; j < w; j++ {
            // check if current cell is a 1
            // and also check for same in 'A'
            // increment counter when both are true
            if B[i][j] == 1 && A[(n - h) + i][(n - w) + j] == 1 { counter++ }
        }
    }
    return counter
}

func largestOverlap(A [][]int, B [][]int) int {
    largestOverlapFound := 0
    // since the images are a square matrix take len of outer array.
    n := len(A)
    // iterate for all rows in the image
    for h := 1; h <= n; h++ {
        // iterate over all the columns in the current row of image
        for w := 1; w <= n; w++ {
            // over lap 'A' over 'B' and 'B' over 'A'.
            // select the largest overlap
            largest := max(overlap(B, A, h, w), overlap(A, B, h, w))
            // check if current over lap is the largest.
            // if so, update the largestOverlapFound variable.
            largestOverlapFound = max(largest, largestOverlapFound)
        }
    }
    return largestOverlapFound
}


*/
