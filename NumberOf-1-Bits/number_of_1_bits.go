package main

/*
 int c = 0;
    while (nums != 0) {
      nums = (nums - 1 & nums);
      c++;
    }
    return c;
  }
*/
func hammingWeight(num uint32) int {
	var ret int
	for i := 0; i < 32; i++ {
		if num%2 == 1 {
			ret++
		}
		num /= 2
	}
	return ret
}
