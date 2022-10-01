# 🔥 Number of 1 Bits 🔥 || 3 Solutions || Simple Fast and Easy || with Explanation

## Solution - 1

```dart
class Solution {
  List<int> table = List.filled(256, 0);
  bool flag = true;
  void initialize() {
    // storing or preprocessing set bits of numbers
    // from 0 to 255 into lookup table
    table[0] = 0;
    for (int i = 1; i < 256; i++) {
      table[i] = (i & 1) + table[i ~/ 2];
    }
  }

  /// We are using a lookup table to count the number of 1's in a byte. We are then adding the number of
  /// 1's in each byte to get the total number of 1's in the 32 bit integer
  ///
  /// Args:
  ///   nums (int): the number to be checked
  ///
  /// Returns:
  ///   The number of 1's in the binary representation of the number.
  int hammingWeight(int nums) {
    if (flag == true) {
      initialize();
      flag = false;
    }

    int res = 0;

    res = table[nums & 0xff];
    nums = nums >> 8; //right shift by 8

    res = res + table[nums & 0xff];
    nums = nums >> 8;

    res = res + table[nums & 0xff];
    nums = nums >> 8;

    res = res + table[nums & 0xff];

    return res;
  }
}
```

## Solution - 2

```dart
class Solution {
  // It counts the number of 1's in the binary representation of a number.
  //
  // Args:
  //   nums (int): the number to be checked
  //
  // Returns:
  //   The number of 1's in the binary representation of the number.
  int hammingWeight(int nums) {
    int c = 0;

    /// A bitwise operation.
    while (nums != 0) {
      nums = (nums - 1 & nums);
      c++;
    }
    return c;
  }
}
```

## Solution - 3 Bit - Manipulation

We can see that if we do [n & (n - 1)] we will be reducing a one bit from the number.
e.g. 1001 & 1000 = 1000, 110 & (101) = 100.
we can actually use this here.
in this case iterations required will be equal to number of set bits in a number.

```dart
class Solution {
  //
  int hammingWeight(int nums) {
    int ans = 0;
    while (nums > 0) {
      nums = nums & (nums - 1);
      ans++;
    }
    return ans;
  }
}
```

## Bonus Solution - Golang

```go
// Runtime: 0 ms, faster than 100.00% of Go online submissions for Number of 1 Bits.
// Memory Usage: 1.8 MB, less than 94.85% of Go online submissions for Number of 1 Bits.
func hammingWeight(num uint32) int {
  return bits.OnesCount32(num)
}
```

## Disclaimer:-

This Solution is not available in DART Programing language with is a bummer. Hurts my feeling. But as a man we should implement it no matter what. We are not bunch of wussies who gonna skip it if it's not available in one language we love. Instead we will conquer the sea and rivers and cross the mountains so see what's lies beyond our horizons.
