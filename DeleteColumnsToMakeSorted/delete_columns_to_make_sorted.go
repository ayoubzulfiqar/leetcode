package main

// func minDeletionSize(strs []string) int {
// 	var count int = 0
// 	if len(strs) <= 1 {
// 		return 0
// 	}
// 	for i := 0; i < len(strs[0]); i++ {
// 		for j := 0; j < len(strs)-1; j++ {
// 			if strs[j+1][i] < strs[j][i] {
// 				count++
// 				break
// 			}
// 		}
// 	}
// 	return count
// }

func minDeletionSize(strs []string) int {
	var deleted int = 0
	if len(strs) == 0 {
		return deleted
	}
	var rowSize int = len(strs[0])
	for col := 0; col < rowSize; col++ {
		if !isSorted(strs, col) {
			deleted++
		}
	}
	return deleted
}

func isSorted(strs []string, col int) bool {
	var size int = len(strs)
	var previous byte = 0
	for i := 0; i < size; i++ {
		var c byte = strs[i][col]
		if c < previous {
			return false
		}
		previous = c

	}
	return true
}

/*

  int minDeletionSize(List<String> strs) {
    int deleted = 0;
    if (strs.length == 0) return deleted;
    int rowSize = strs[0].length;

    for (int col = 0; col < rowSize; col++) {
      if (!isSorted(strs, col)) deleted++;
    }

    return deleted;
  }

  bool isSorted(List<String> strs, int col) {
    int N = strs.length;
    int prev = 0;
    for (int i = 0; i < N; i++) {
      int c = strs[i].codeUnitAt(col);
      //If out of order
      if (c < prev) return false;
      //update prev
      prev = c;
    }

    return true; //In order the whole time
  }
*/
