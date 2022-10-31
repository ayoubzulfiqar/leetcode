package main

/*

bool isToeplitzMatrix(List<List<int>> matrix) {
    for (int i = 0; i < matrix.length - 1; i++) {
      for (int j = 0; j < matrix[0].length - 1; j++) {
        int ele = matrix[i][j];
        if (i < matrix.length - 1 &&
            j < matrix[0].length - 1 &&
            matrix[i + 1][j + 1] != ele) {
          return false;
        }
      }
    }
    return true;
  }
*/
func isToeplitzMatrix(matrix [][]int) bool {
	for i := 0; i < len(matrix)-1; i++ {
		for j := 0; j < len(matrix[0])-1; j++ {
			element := matrix[i][j]
			if i < len(matrix)-1 &&
				j < len(matrix[0])-1 &&
				matrix[i+1][j+1] != element {
				return false
			}
		}
	}
	return true
}
