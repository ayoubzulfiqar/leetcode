package main

// Time Complexity: O(N)
// Space Complexity: O(1)

// the idea is to use bit manipulation to set the current number based on the previous number
// for example,
// n = 1, ans = 0b1
// n = 2 (10), we need to shift 2 bits of the previous ans to the left and add `n`
// i.e. 1 -> 100 (shift 2 bits to the left) -> 110 (set `10`). ans = 0b110
// n = 3 (11), we need to shift 2 bits of the previous ans to the left and add `n`
// i.e 110 -> 11000 (shift 2 bits to the left) -> 11011 (set `11`). ans = 0b11011
// n = 4 (100), we need to shift 3 bits of the previous ans to the left and add `n`
// i.e. 11011 -> 11011000 (shift 3 bits to the left) -> 11011100 (set `100). ans = 0b11011100
// so now we can see a pattern here
// we need to shift `l` bits of the previous ans to the left and add the current `i`
// how to know `l`? it is not difficult to see `x` only increases when we meet power of 2

func concatenatedBinary(n int) int {
	// `l` is the bit length to be shifted
	ans, l, M := 0, 0, 1_000_000_007
	for i := 1; i <= n; i++ {
		// i & (i - 1) means removing the rightmost set bit
		// e.g. 100100 -> 100000
		//      000001 -> 000000
		//      000000 -> 000000
		// after removal, if it is 0, then it means it is power of 2
		// as all power of 2 only contains 1 set bit
		// if it is power of 2, we increase the bit length `l`
		if i&(i-1) == 0 {
			l += 1
		}
		// (ans << l) means shifting the original answer `l` bits to th left
		// (x | i) means  using OR operation to set the bit
		// e.g. 0001 << 3 = 0001000
		// e.g. 0001000 | 0001111 = 0001111
		ans = ((ans << l) | i) % M
	}
	return ans
}

// ------------------------------------------------------------

// func concatenatedBinary(n int) int {
//     mod := int(math.Pow(10, 9)) + 7
//     num := 0
//     length := 0
//     for i := 1; i <= n; i++ {
//         if int(math.Pow(2, float64(int(math.Log(float64(i)) / math.Log(2))))) == i {
//             length++
//         }
//         num <<= length
//         num += i
//         num %= mod
//     }
//     return num
// }

// ------------------------------------------------------------

// func concatenatedBinary(n int) int {
//     ans := 1

//     current, count := 2, 1
//     for i := 2; i <= n; i++ {
//         if i == current {
//             current <<= 1
//             count++
//         }

//         // so i is count bit
//         ans <<= count
//         ans += i
//         ans %= 1_000_000_007
//     }

//     return ans
// }
// ------------------------------------------------------------
// func concatenatedBinary(n int) int {
//     length, res, mod := 0, 0, 1000000007

//     for i:=1; i<=n; i++ {
//         if i & (i-1) == 0 {
//             length++
//         }
//         res = (res << length | i) % mod
//     }
//     return res
// }
