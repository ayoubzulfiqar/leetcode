package main

func isInterleave(s1 string, s2 string, s3 string) bool {
	m, n, k := len(s1), len(s2), len(s3)
	if m+n != k {
		return false
	}

	dp1 := 1
	for i := 1; i <= n; i++ {
		if s2[i-1] == s3[i-1] && dp1&1 == 1 {
			dp1 = (dp1 << 1) + 1
		} else {
			dp1 = dp1 << 1
		}
	}

	for j := 1; j <= m; j++ {
		dp2 := 0
		if s1[j-1] == s3[j-1] && dp1&(1<<n) != 0 {
			dp2 = 1
		}
		for i := 1; i <= n; i++ {
			if (s1[j-1] == s3[j+i-1] && dp1&(1<<(n-i)) != 0) ||
				(s2[i-1] == s3[j+i-1] && dp2&1 == 1) {
				dp2 = (dp2 << 1) + 1
			} else {
				dp2 = dp2 << 1
			}
		}
		dp1 = dp2
	}

	return dp1&1 == 1
}
