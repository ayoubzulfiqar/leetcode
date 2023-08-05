package main

var visited [][]bool
var n, m int

func exist(board [][]string, word string) bool {
	n = len(board)
	m = len(board[0])
	visited = make([][]bool, n)
	for i := range visited {
		visited[i] = make([]bool, m)
	}

	for i := 0; i < n; i++ {
		for j := 0; j < m; j++ {
			if board[i][j] == word[0:1] {
				if valid(i, j, 0, board, word) {
					return true
				}
			}
		}
	}
	return false
}

func valid(i, j, count int, board [][]string, word string) bool {
	if i < 0 || i >= n || j < 0 || j >= m {
		return false
	}

	if visited[i][j] {
		return false
	}

	if word[count:count+1] != board[i][j] {
		return false
	}

	if count == len(word)-1 {
		return true
	}

	visited[i][j] = true
	count++

	if valid(i+1, j, count, board, word) ||
		valid(i, j+1, count, board, word) ||
		valid(i-1, j, count, board, word) ||
		valid(i, j-1, count, board, word) {
		return true
	}

	visited[i][j] = false
	return false
}
