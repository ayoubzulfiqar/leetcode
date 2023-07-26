package main

import "math"

func isPossible(dist []int, speed int, hour float64) bool {
	var ans float64
	for i := 0; i < len(dist); i++ {
		d := float64(dist[i]) / float64(speed)
		if i != len(dist)-1 {
			ans += math.Ceil(d)
		} else {
			ans += d
		}
		if ans > hour {
			return false
		}
	}
	return ans <= hour
}

func minSpeedOnTime(dist []int, hour float64) int {
	i := 1
	j := int(1e7)
	var minSpeed = -1 // Initialize minSpeed to -1
	for i <= j {
		mid := i + (j-i)/2
		if isPossible(dist, mid, hour) {
			minSpeed = mid
			j = mid - 1
		} else {
			i = mid + 1
		}
	}
	return minSpeed
}

/*
import "math"

func minSpeedOnTime(dist []int, hour float64) int {
	n := len(dist)
	if hour <= float64(n-1) {
		return -1
	}
	l, r := 1, int(1e7)
	for l < r {
		mid := l + (r-l)/2
		time := 0.0
		for i := 0; i < n-1; i++ {
			time += math.Ceil(float64(dist[i]) / float64(mid))
		}
		time += float64(dist[n-1]) / float64(mid)

		if time <= hour {
			r = mid
		} else {
			l = mid + 1
		}
	}
	return l
}
*/
func ceil(x, y int) int {
	div, rem := x/y, x%y
	if rem > 0 {
		div++
	}
	return div
}
