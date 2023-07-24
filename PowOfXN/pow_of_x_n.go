package main

/*


func solve(x float64, n int64) float64 {
	ans := 1.0
	for n > 0 {
		if n&1 == 1 {
			ans *= x
		}
		x *= x
		n >>= 1
	}
	return ans
}

func myPow(x float64, n int) float64 {
	if x == 1 {
		return 1
	}

	longN := int64(n)
	var ans float64
	if longN < 0 {
		ans = 1 / solve(x, -longN)
	} else {
		ans = solve(x, longN)
	}
	return ans
}

------------------------------------------------------Solution----------

func solve(x float64, n int64) float64 {
	if n == 0 {
		return 1.0 // power of 0 is 1
	}
	temp := solve(x, n/2)
	temp *= temp

	if n%2 == 0 {
		return temp
	} else {
		return temp * x
	}
}

func myPow(x float64, n int) float64 {
	if x == 1 {
		return 1
	}

	longN := int64(n)
	ans := solve(x, int64(longN))

	if longN < 0 {
		return 1 / ans
	}
	return ans
}


*/



// Iterative BitWise
func myPow(x float64, n int) float64 {
	if x == 1 {
		return 1
	}

	if n == 0 {
		return 1
	}

	if n < 0 {
		x = 1 / x
		n = -n
	}

	ans := 1.0
	for n > 0 {
		if n&1 == 1 {
			ans *= x
		}
		x *= x
		n >>= 1
	}

	return ans
}
