package main

func new21Game(n, k, maxPts int) float64 {
	// Corner cases
	if k == 0 {
		return 1.0
	}
	if n >= k-1+maxPts {
		return 1.0
	}

	// dp[i] is the probability of getting point i.
	dp := make([]float64, n+1)

	probability := 0.0 // dp of N or less points.
	windowSum := 1.0   // Sliding required window sum
	dp[0] = 1.0

	for i := 1; i <= n; i++ {
		dp[i] = windowSum / float64(maxPts)

		if i < k {
			windowSum += dp[i]
		} else {
			probability += dp[i]
		}

		if i-maxPts >= 0 {
			windowSum -= dp[i-maxPts]
		}
	}

	return probability
}

//=================

// import (
// 	"math"
// )

// type CircularBuffer struct {
// 	data []float64
// 	mask uint
// }

// func NewCircularBuffer(minSize int) *CircularBuffer {
// 	size := 1 << bitLen(minSize)
// 	mask := uint(size - 1)
// 	data := make([]float64, size)
// 	return &CircularBuffer{
// 		data: data,
// 		mask: mask,
// 	}
// }

// func (cb *CircularBuffer) Get(index int) float64 {
// 	return cb.data[index&int(cb.mask)]
// }

// func (cb *CircularBuffer) Set(index int, value float64) {
// 	cb.data[index&int(cb.mask)] = value
// }

// func (cb *CircularBuffer) Capacity() int {
// 	return len(cb.data)
// }

// func bitLen(minSize int) int {
// 	return 32 - clz(minSize)
// }

// func clz(x int) int {
// 	if x <= 0 {
// 		return 32
// 	}
// 	return 31 - int(math.Log2(float64(x)))
// }

// func new21Game(n, k, maxPts int) float64 {
// 	if k == 0 || n-k+1 >= maxPts {
// 		return 1.0
// 	}

// 	kFactor := 1.0 / float64(maxPts)
// 	if maxPts+1 >= n {
// 		return math.Pow(1+kFactor, float64(k-1)) / float64(maxPts) * (float64(n-k) + 1)
// 	}

// 	dp := NewCircularBuffer(maxPts + 1)
// 	dp.Set(0, 1.0)
// 	sum := 1.0

// 	for i := 1; i < k; i++ {
// 		dp.Set(i, sum*kFactor)
// 		sum += dp.Get(i) - dp.Get(i-maxPts)
// 	}

// 	answer := 0.0
// 	for i := k; i <= n; i++ {
// 		answer += sum * kFactor
// 		sum -= dp.Get(i - maxPts)
// 	}

// 	return answer
// }

// /*

//  */
