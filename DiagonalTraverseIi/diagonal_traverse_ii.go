package main

func findDiagonalOrder(nums [][]int) []int {
	var res [][]int
	m, size := len(nums), 0

	for i := 0; i < m; i++ {
		n, x := len(nums[i]), i
		for j := 0; j < n; j++ {
			if len(res) == x {
				res = append(res, []int{})
			}
			res[x] = append(res[x], nums[i][j])
			x++
			size++
		}
	}

	ans := make([]int, size)
	idx := 0

	for i := 0; i < len(res); i++ {
		for j := len(res[i]) - 1; j >= 0; j-- {
			ans[idx] = res[i][j]
			idx++
		}
	}

	return ans
}
/*


func findDiagonalOrder(nums [][]int) []int {
	queue := list.New()
	queue.PushBack([2]int{0, 0})
	numRows := len(nums)
	var elems int

	for _, lst := range nums {
		elems += len(lst)
	}

	res := make([]int, elems)
	resIdx := 0

	for queue.Len() > 0 {
		size := queue.Len()

		for i := 0; i < size; i++ {
			next := queue.Remove(queue.Front()).([2]int)
			row, col := next[0], next[1]

			currentList := nums[row]
			if currentList[col] == math.MaxInt32 {
				continue
			}

			res[resIdx] = currentList[col]
			resIdx++

			currentList[col] = math.MaxInt32

			if row+1 < numRows && len(nums[row+1]) > col && nums[row+1][col] != math.MaxInt32 {
				queue.PushBack([2]int{row + 1, col})
			}

			if col+1 < len(currentList) && currentList[col+1] != math.MaxInt32 {
				queue.PushBack([2]int{row, col + 1})
			}
		}
	}

	return res
}


*/