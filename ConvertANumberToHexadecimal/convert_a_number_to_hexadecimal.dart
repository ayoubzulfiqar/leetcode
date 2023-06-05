/*

-* 405. Convert a Number to Hexadecimal *-

Given an integer num, return a string representing its hexadecimal representation. For negative integers, two’s complement method is used.

All the letters in the answer string should be lowercase characters, and there should not be any leading zeros in the answer except for the zero itself.

Note: You are not allowed to use any built-in library method to directly solve this problem.

 

Example 1:

Input: num = 26
Output: "1a"
Example 2:

Input: num = -1
Output: "ffffffff"
 

Constraints:

-231 <= num <= 231 - 1


*/
String toHexString(int num) {
  if (num == 0) {
    return "0";
  }

  int n = num.toUnsigned(32);
  final String ref = "0123456789abcdef";

  String result = "";

  while (n != 0) {
    result = ref[n & 0xF] + result;
    n >>= 4;
  }

  return result;
}

String toHex(int num) {
  return (num < 0)
      ? (num.toUnsigned(32)).toRadixString(16)
      : num.toRadixString(16);
}

extension ToHex on int {
  String toHexString(int num) {
    if (num == 0) {
      return "0";
    }

    int n = num.toUnsigned(32);
    final String ref = "0123456789abcdef";

    String result = "";

    while (n != 0) {
      result = ref[n & 0xF] + result;
      n >>= 4;
    }

    return result;
  }
}
