package main

//* Forward declaration of guess API.
//* @param  num   your guess
//* @return 	     -1 if num is higher than the picked number
//*			      1 if num is lower than the picked number
//*               otherwise return 0
func guess(num int) int

// func guessNumber(n int) int {
// 	var low int = 1
// 	var high int = n
// 	for low <= high {
// 		var mid int = low + (high-low)/2
// 		var g int = guess(mid)
// 		if g == 0 {
// 			return mid
// 		} else if g == -1 {
// 			high = mid - 1
// 		} else {
// 			low = mid + 1
// 		}
// 	}

// 	return -1
// }

func guessNumber(n int) int {
	return binarySearch(0, n)
}

func binarySearch(start, finish int) int {
	if start > finish {
		return -1
	}
	dot := (finish-start)/2 + start

	switch guess(dot) {
	case -1:
		return binarySearch(start, dot-1)
	case 1:
		return binarySearch(dot+1, finish)
	default:
		return dot
	}
}
