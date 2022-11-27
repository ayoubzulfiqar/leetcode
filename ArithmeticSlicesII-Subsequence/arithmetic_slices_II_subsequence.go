package main

import "math"

// func numberOfArithmeticSlices(nums []int) int {
// 	dic := map[[2]int]int{}
// 	var dfs func(int, int, int, []int, int) int
// 	dfs = func(i int, prev int, diff int, nums []int, out int) int {
// 		for j := i; j < len(nums); j++ {
// 			if nums[j]-prev == diff {
// 				k := [2]int{j, diff}
// 				if v, ok := dic[k]; ok {
// 					out += v
// 				} else {
// 					ret := dfs(j+1, nums[j], diff, nums, out+1)
// 					dic[k] = ret - out
// 					out = ret
// 				}
// 			}
// 		}
// 		return out
// 	}
// 	out := 0
// 	for i := 0; i < len(nums); i++ {
// 		for j := i + 1; j < len(nums); j++ {
// 			out = dfs(j+1, nums[j], nums[j]-nums[i], nums, out)
// 		}
// 	}
// 	return out
// }

/*

class C {
  int f(List<int> nums, int index, int curr, int prev, double dif) {
    int nr = 0;
    if (curr >= 3) {
      nr = 1; //if the current sequence has at least 3 elements, we count it
    }
    for (int i = index; i < nums.length; i++) {
      //check all posible numbers that could be included in the sequence
      double x = nums[i] - prev.toDouble();
      if (x == dif) {
        //"add" the number in the sequence
        nr = nr + f(nums, i + 1, curr + 1, nums[i], dif);
      }
    }
    return nr;
  }

  int numberOfArithmeticSlices(List<int> nums) {
    if (nums.length < 3) {
      return 0;
    }
    bool ok = true;
    int x = nums[0];
    for (int i = 1; i < nums.length; i++) {
      if (nums[i] != x) {
        ok = false;
        break;
      }
    }
    if (ok) {
      //if all numbers are equal
      //substract the combinations of n taken 1 and 2 from the total number of subsets
      //so we take all subsets with at least 3 elements
      int n = nums.length;
      int rez = (pow(2, n) - 1).toInt();
      rez = rez - n - n * (n - 1) ~/ 2;
      return rez;
    }
    int nr = 0;
    for (int i = 0; i < nums.length - 1; i++) {
      for (int j = i + 1; j < nums.length; j++) {
        //we take the first two elements of a subset
        //then the function searches for all subsets where the difference
        //between any 2 consecutive numbers is equal
        nr = nr + f(nums, j + 1, 2, nums[j], nums[j] - nums[i].toDouble());
      }
    }
    return nr;
  }
}


*/

func foo(nums []int, index int, current int, prev int, dif float64) int {
	var nR int = 0
	if current >= 3 {
		nR = 1
	}
	for i := index; i < len(nums); i++ {
		var x float64 = float64(nums[i] - prev)
		if x == dif {
			nR = nR + foo(nums, i+1, current+1, nums[i], dif)
		}
	}
	return nR
}
func numberOfArithmeticSlices(nums []int) int {
	var nR int = 0
	if len(nums) < 3 {
		return 0
	}
	var ok bool = true
	var x int = nums[0]
	for i := 1; i < len(nums); i++ {
		if nums[i] != x {
			ok = false
			break
		}
		if ok {
			var n int = len(nums)
			var rez int = int(math.Pow(2, float64(n)) - 1)
			rez = rez - n - n*(n-1)/2
			return rez
		}
		for i := 0; i < len(nums)-1; i++ {
			for j := i + 1; j < len(nums); j++ {
				nR = nR + foo(nums, j+1, 2, nums[j], float64(nums[j]-nums[i]))
			}
		}
	}
	return nR
}
