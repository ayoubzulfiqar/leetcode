package main

import "bytes"

func convert(s string, numRows int) string {
	if numRows == 1 {
		return s
	}
	rows := make([][]byte, numRows)
	curRow, step := 0, 1
	for i := range s {
		rows[curRow] = append(rows[curRow], s[i])
		curRow += step
		if curRow == 0 {
			step = 1
		} else if curRow == numRows-1 {
			step = -1
		}
	}

	var res bytes.Buffer
	for i := range rows {
		res.Write(rows[i])
	}
	return res.String()
}
