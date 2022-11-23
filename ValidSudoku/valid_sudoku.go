package main

func isValidPlacement(board [][]byte, number byte, row int, column int) bool {
	return !isNumberInRow(board, number, row, column) &&
		!isNumberInColumn(board, number, row, column) &&
		!isNumberInBox(board, number, row, column)
}
func isNumberInBox(board [][]byte, number byte, row int, column int) bool {
	var boxRow int = row - row%3
	var boxColumn int = column - column%3
	for i := boxRow; i < boxRow+3; i++ {
		for j := boxColumn; j < boxColumn+3; j++ {
			if row != i && column != j && board[i][j] == number {
				return true
			}
		}
	}
	return false
}

func isNumberInColumn(board [][]byte, number byte, row int, column int) bool {
	for i := 0; i < 9; i++ {
		if row != i && board[i][column] == number {
			return true
		}
	}
	return false
}

func isNumberInRow(board [][]byte, number byte, row int, column int) bool {
	for i := 0; i < 9; i++ {

		if column != i && board[row][i] == number {
			return true
		}
	}
	return false
}

func isValidSudoku(board [][]byte) bool {
	for row := 0; row < 9; row++ {
		for column := 0; column < 9; column++ {
			if board[row][column] != '.' &&
				!isValidPlacement(board, board[row][column], row, column) {
				return false
			}
		}
	}
	return true
}
