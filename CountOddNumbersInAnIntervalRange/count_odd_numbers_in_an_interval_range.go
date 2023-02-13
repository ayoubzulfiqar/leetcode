package main

func countOdds1(low int, high int) int {

	return ((high + 1) / 2) - (low / 2)
}

func countOdds2(low int, high int) int {
	if (high & 1) == 0 {
		high--
	}
	if low > high {
		return 0
	}
	return ((high + 1) / 2) - (low / 2)
}

func countOdds3(low int, high int) int {
	var total int = high - low + 1
	if total%2 == 0 {
		return total / 2
	} else {
		if low%2 != 0 {
			return (total / 2) + 1

		}
	}
	return total / 2

}
