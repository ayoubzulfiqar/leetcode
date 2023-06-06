package main

// func canMakeArithmeticProgression(arr []int) bool {
// 	length := len(arr)
// 	minVal := arr[0]
// 	maxVal := arr[0]

// 	for _, num := range arr {
// 		if num < minVal {
// 			minVal = num
// 		}
// 		if num > maxVal {
// 			maxVal = num
// 		}
// 	}

// 	diff := float64(maxVal-minVal) / float64(length-1)

// 	for i := 0; i < length; i++ {
// 		expected := float64(minVal) + float64(i)*diff
// 		found := false
// 		for _, num := range arr {
// 			if math.Abs(float64(num)-expected) < 1e-9 {
// 				found = true
// 				break
// 			}
// 		}
// 		if !found {
// 			return false
// 		}
// 	}

// 	return true
// }

func canMakeArithmeticProgression(arr []int) bool {
	seed := 1000001
	last := -seed

	for _, x := range arr {
		if x < seed {
			seed = x
		}
		if x > last {
			last = x
		}
	}

	diff := last - seed
	if diff == 0 {
		return true
	}
	if diff%(len(arr)-1) != 0 {
		return false
	}
	diff /= len(arr) - 1

	res := 0
	for i, x := range arr {
		index := x - seed
		if index%diff != 0 {
			return false
		}
		index /= diff
		res ^= i ^ index
	}

	return res == 0
}
