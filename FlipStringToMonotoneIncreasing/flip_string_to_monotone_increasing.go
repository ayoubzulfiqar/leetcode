package main

// func minFlipsMonoIncr(s string) int {
// 	var answer int = 0
// 	var numberOfFlips = 0
// 	for i := 0; i < len(s); i++ {
// 		if s[i] == '0' {
// 			answer = min(numberOfFlips, answer+1)
// 		} else {
// 			numberOfFlips++
// 		}
// 	}
// 	return answer
// }

func min(a int, b int) int {
	if a < b {
		return a
	} else {
		return b
	}
}

func minFlipsMonoIncr(s string) int {
	var n int = len(s)
	var ans int = 100000
	var oneCount []int = make([]int, n)
	var zeroCount []int = make([]int, n)
	oneCount[0] = 0
	zeroCount[n-1] = 0

	for i := 1; i < n; i++ {
		if s[i-1] == '1' {
			oneCount[i] = oneCount[i-1] + 1
		} else {
			oneCount[i] = oneCount[i-1]
		}
		if s[n-i] == '0' {
			zeroCount[n-i-1] = zeroCount[n-i] + 1
		} else {
			zeroCount[n-i-1] = zeroCount[n-i]
		}
		for i := 0; i < n; i++ {
			ans = min(ans, zeroCount[i]+oneCount[i])
		}
	}
	return ans
}

/*

 int minFlipsMonoIncr(String s) {
    int n = s.length;
    int ans = 100000;
    List<int> oneCount = List.filled(n, 0);
    List<int> zeroCount = List.filled(n, 0);
    oneCount[0] = 0;
    zeroCount[n - 1] = 0;
    for (int i = 1; i < n; i++) {
      if (s[i - 1] == '1')
        oneCount[i] = oneCount[i - 1] + 1;
      else
        oneCount[i] = oneCount[i - 1];
      if (s[n - i] == '0')
        zeroCount[n - i - 1] = zeroCount[n - i] + 1;
      else
        zeroCount[n - i - 1] = zeroCount[n - i];
    }
    for (int i = 0; i < n; i++) {
      ans = min(ans, zeroCount[i] + oneCount[i]);
    }
    return ans;
  }
*/
