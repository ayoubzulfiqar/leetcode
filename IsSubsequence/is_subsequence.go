package main

// 1
// func isSubsequence(s string, t string) bool {
// 	if len(s) > len(t) {
// 		return false
// 	}
// 	var j int = 0
// 	for i := 0; i < len(t) && j < len(s); i++ {
// 		if s[j] == t[i] {
// 			j++
// 		}
// 	}
// 	if j == len(t) {
// 		return true
// 	}
// 	return false
// }

// 2

// func isSubString(s string, t string, m int, n int) bool {
// 	if m == 0 {
// 		return true
// 	}
// 	if n == 0 {
// 		return false
// 	}
// 	if s[m-1] == t[n-1] {
// 		return isSubString(s, t, m-1, n-1)
// 	}
// 	return isSubString(s, t, m, n-1)
// }
// func isSubsequence(s string, t string) bool {
// 	if isSubString(s, t, len(s), len(t)) {
// 		return true
// 	}

// 	return false
// }

// 3

func isSubsequence(s string, t string) bool {
	var p int = 0
	var q int = 0
	for p < len(s) {
		for q < len(t) {
			if s[p] == t[q] {
				break
			}
			q++
		}
		if q == len(t) {
			return false
		}
		p++
		q++
	}
	return true
}

/*

 bool isSubsequence(String s, String t) {
    int p1 = 0;
    int p2 = 0;
    while (p1 < s.length) {
      while (p2 < t.length) {
        if (s[p1] == t[p2]) break;
        p2++;
      }
      if (p2 == t.length) return false;
      p1++;
      p2++;
    }
    return true;
  }

*/
