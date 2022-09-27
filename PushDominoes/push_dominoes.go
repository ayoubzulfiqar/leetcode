package main

// func fall(l, c, r rune) rune {
// 	if c == '.' {
// 		if l == 'R' && r == 'L' {
// 			return '.'
// 		}
// 		if l == 'R' {
// 			return 'R'
// 		}
// 		if r == 'L' {
// 			return 'L'
// 		}
// 	}
// 	return c
// }

// func pushIteration(dominoes string) string {
// 	result := make([]rune, len(dominoes))
// 	if len(dominoes) == 1 {
// 		return dominoes
// 	}
// 	dominoesR := []rune(dominoes)
// 	for i := 0; i < len(dominoesR); i++ {
// 		switch i {
// 		case 0:
// 			result[i] = fall('.', dominoesR[i], dominoesR[i+1])
// 		case len(dominoes) - 1:
// 			result[i] = fall(dominoesR[i-1], dominoesR[i], '.')
// 		default:
// 			result[i] = fall(dominoesR[i-1], dominoesR[i], dominoesR[i+1])
// 		}
// 	}
// 	return string(result)
// }

// func pushDominoes(dominoes string) string {
// 	previousIteration := pushIteration(dominoes)
// 	for previousIteration != dominoes {
// 		previousIteration = dominoes
// 		dominoes = pushIteration(dominoes)
// 	}
// 	return dominoes
// }

func pushDominoes(dominoes string) string {
	var (
		buf = make([]int, len(dominoes))
		res = make([]byte, 0, len(buf))
		val = 0

		dot byte = 46
		r   byte = 82
		l   byte = 76
	)

	for i := 0; i < len(dominoes); i++ {
		if dominoes[i] == r {
			val = len(dominoes)
		} else if dominoes[i] == l {
			val = 0
		} else {
			val = max(val-1, 0)
		}

		buf[i] += val
	}

	val = 0
	for i := len(dominoes) - 1; i >= 0; i-- {
		if dominoes[i] == l {
			val = len(dominoes)
		} else if dominoes[i] == r {
			val = 0
		} else {
			val = max(val-1, 0)
		}

		buf[i] -= val
	}

	for i := 0; i < len(buf); i++ {
		if buf[i] < 0 {
			res = append(res, l)
		} else if buf[i] > 0 {
			res = append(res, r)
		} else {
			res = append(res, dot)
		}
	}

	return string(res)
}

func max(a, b int) int {
	if a > b {
		return a
	}

	return b
}
