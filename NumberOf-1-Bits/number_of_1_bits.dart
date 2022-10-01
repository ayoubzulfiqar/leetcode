/*


-* Number of 1 Bits *-


Write a function that takes an unsigned integer and returns the number of '1' bits it has (also known as the Hamming weight).

Note:

Note that in some languages, such as Java, there is no unsigned integer type. In this case, the input will be given as a signed integer type. It should not affect your implementation, as the integer's internal binary representation is the same, whether it is signed or unsigned.
In Java, the compiler represents the signed integers using 2's complement notation. Therefore, in Example 3, the input represents the signed integer. -3.


Example 1:

Input: n = 00000000000000000000000000001011
Output: 3
Explanation: The input binary string 00000000000000000000000000001011 has a total of three '1' bits.
Example 2:

Input: n = 00000000000000000000000010000000
Output: 1
Explanation: The input binary string 00000000000000000000000010000000 has a total of one '1' bit.
Example 3:

Input: n = 11111111111111111111111111111101
Output: 31
Explanation: The input binary string 11111111111111111111111111111101 has a total of thirty one '1' bits.


Constraints:

The input must be a binary string of length 32.


Follow up: If this function is called many times, how would you optimize it?


*/

class A {
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

class B {
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

class C {
  // Bit - Manipulation
  int hammingWeight(int nums) {
    int ans = 0;
    while (nums > 0) {
      nums = nums & (nums - 1);
      ans++;
    }
    return ans;
  }
}
