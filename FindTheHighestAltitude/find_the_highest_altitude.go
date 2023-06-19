package main

func largestAltitude(gain []int) int {
	var maxAltitude int = 0
	var currentAltitude int = 0

	for i := 0; i < len(gain); i++ {
		currentAltitude += gain[i]
		maxAltitude = max(maxAltitude, currentAltitude)
	}
	return maxAltitude

}

func max(first int, second int) int {
	if first > second {
		return first
	}
	return second
}
