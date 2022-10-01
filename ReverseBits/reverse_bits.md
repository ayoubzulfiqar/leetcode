# 🔥 Reverse Bits 🔥 || 3 Solutions || Simple Fast and Easy || with Explanation

## Solution - 1 Divide and Conquer

```dart
class Solution {
   // It reverses the bits of a 32-bit unsigned integer.
  // Args:
  //  nums (int): 1010 1010 1010 1010 1010 1010 1010 1010
  //
  // Returns:
  //  The number of bits that are different between two numbers.
  int reverseBits(int nums) {
    nums = ((nums & 0xffff0000) >>> 16) | ((nums & 0x0000ffff) << 16);
    nums = ((nums & 0xff00ff00) >>> 8) | ((nums & 0x00ff00ff) << 8);
    nums = ((nums & 0xf0f0f0f0) >>> 4) | ((nums & 0x0f0f0f0f) << 4);
    nums = ((nums & 0xcccccccc) >>> 2) | ((nums & 0x33333333) << 2);
    nums = ((nums & 0xaaaaaaaa) >>> 1) | ((nums & 0x55555555) << 1);

    return nums;
  }
```

## Solution - 2 - Bit Manipulation - Brute Force

In this approach , First you will initialize result(k) with 0.
   As we have 32 bits in 32 bit unsigned integer(n) so we can ran loop 32 times. In each iteration ,
   we will left shift one bit of our current result and then we do n&1 so that we can know that whether
   we have 0 or 1 as first (right most ) bit .
   Now we can update our result with the equation k=(k|(n&1)) and also we update our number(n) by right shifting of one bit of it . After 32 iteration we can find that we have result k as reversed bit of number n.

```dart
class Solution {
  int reverseBits(int nums) {
    int ans = 0;

    /// Getting the bits of the number.
    for (int i = 31; i >= 0; i--) {
      ans |= (nums & 1) << i;
      nums = nums >> 1;
    }
    return ans;
  }
}
```

## Solution - 3

- Store All bits in a List in reverse Manner
- Add All bits to number

```dart
class Solution {
  int reverseBits(int nums) {
    // List<int> bits = List.empty(growable: true);
    List<int> bits = [];

    /// Getting the bits of the number.
    for (int i = 0; i < 32; i++) {
      bits.add(nums & 1);
      nums = nums >> 1;
    }

    /// Reversing the bits.
    for (int x in bits) {
      nums = nums << 1;
      if (x == 0) {
        nums = nums | 1;
      }
    }

    return nums;
  }
}
```

## Bonus Solution - Golang

```go
// Runtime: 0 ms, faster than 100.00% of Go online submissions for Reverse Bits.
// Memory Usage: 2.5 MB, less than 99.52% of Go online submissions for Reverse Bits.
func reverseBits(num uint32) uint32 {
	num = (num >> 16) | (num << 16)
	num = ((num & 0xff00ff00) >> 8) | ((num & 0x00ff00ff) << 8)
	num = ((num & 0xf0f0f0f0) >> 4) | ((num & 0x0f0f0f0f) << 4)
	num = ((num & 0xcccccccc) >> 2) | ((num & 0x33333333) << 2)
	num = ((num & 0xaaaaaaaa) >> 1) | ((num & 0x55555555) << 1)
	return num
}
```

## Disclaimer:-

### This Solution is not available in DART Programing language with is a bummer. Hurts my feeling. But as a man we should implement it no matter what. We are not bunch of wussies who gonna skip it if it's not available in one language we love. Instead we will conquer the sea and rivers and cross the mountains so see what's lies beyond our horizons

## [GitHub Link](https://github.com/ayoubzulfiqar/leetcode)
