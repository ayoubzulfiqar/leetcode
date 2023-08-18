package main

func maximalNetworkRank(n int, roads [][]int) int {
	degrees := make([]int, n)
	for _, road := range roads {
		a := road[0]
		b := road[1]
		degrees[a]++
		degrees[b]++
	}

	maxDegree := 0
	secondMaxDegree := 0
	for _, degree := range degrees {
		if degree < secondMaxDegree {
			continue
		}
		secondMaxDegree = degree
		if secondMaxDegree > maxDegree {
			temp := secondMaxDegree
			secondMaxDegree = maxDegree
			maxDegree = temp
		}
	}

	isCandidate := make([]bool, n)
	candidateCount := 0
	king := -1
	for i := 0; i < n; i++ {
		if degrees[i] == secondMaxDegree {
			isCandidate[i] = true
			candidateCount++
		}
		if maxDegree > secondMaxDegree && degrees[i] == maxDegree {
			king = i
		}
	}

	if maxDegree == secondMaxDegree {
		// Case 1: We have multiple candidates with the same max degrees.
		if candidateCount > maxDegree+1 {
			return maxDegree * 2
		}
		connectionCount := 0
		for _, road := range roads {
			a := road[0]
			b := road[1]
			if isCandidate[a] && isCandidate[b] {
				connectionCount++
			}
		}
		if connectionCount < candidateCount*(candidateCount-1)/2 {
			return maxDegree * 2
		}
		return maxDegree*2 - 1
	}

	// Case 2: We have a single max degree (king) and multiple second max degree candidates.
	connectionCount := 0
	for _, road := range roads {
		a := road[0]
		b := road[1]
		if a != king && b != king {
			continue
		}
		if isCandidate[a] || isCandidate[b] {
			connectionCount++
		}
	}
	if connectionCount < candidateCount {
		return maxDegree + secondMaxDegree
	}
	return maxDegree + secondMaxDegree - 1
}
