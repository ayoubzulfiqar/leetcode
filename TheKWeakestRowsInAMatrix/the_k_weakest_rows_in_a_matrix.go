package main

func kWeakestRows(mat [][]int, k int) []int {
	countStore := make([]int, len(mat))
	for i := 0; i < len(mat); i++ {
		count := 0
		for j := 0; j < len(mat[0]); j++ {
			if mat[i][j] == 1 {
				count++
			}
		}
		countStore[i] = count
	}

	result := make([]int, k)
	indexer := 0

	for k > 0 {
		minIndex := 0
		for i := 0; i < len(countStore); i++ {
			if countStore[i] < countStore[minIndex] {
				minIndex = i
			}
		}
		result[indexer] = minIndex
		indexer++
		countStore[minIndex] = 101 // Assuming max row count is 100
		k--
	}
	return result
}
