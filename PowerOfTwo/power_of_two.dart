/*

 -* Power of Two *-

 Given an integer n, return true if it is a power of two. Otherwise, return false.

An integer n is a power of two, if there exists an integer x such that n == 2x.



Example 1:

Input: n = 1
Output: true
Explanation: 20 = 1
Example 2:

Input: n = 16
Output: true
Explanation: 24 = 16
Example 3:

Input: n = 3
Output: false


Constraints:

-231 <= n <= 231 - 1


Follow up: Could you solve it without loops/recursion?

*/

class A {
  // Bit Manipulation
  bool isPowerOfTwo(int n) {
    return n > 0 && ((n & (n - 1)) == 0);
  }
}

class B {
  // Iterative
  bool isPowerOfTwo(int n) {
    if (n <= 0) return false;
    while (n % 2 == 0) n ~/= 2;
    return n == 1;
  }
}

class C {
  bool isPowerOfTwo(int n) {
    return n > 0 && (n == 1 || (n % 2 == 0 && isPowerOfTwo(n ~/ 2)));
  }
}

class D {
  // TLC
  bool isPowerOfTwo(int n) {
    return n > 0 && (1073741824 % n == 0);
  }
}
// class Solution {
//   // TLC
//   bool isPowerOfTwo(int n) {
//   return  HashSet((1, 2, 4, 8, 16, 32, 64, 128, 256, 512, 1024, 2048, 4096, 8192, 16384, 32768, 65536, 131072, 262144, 524288, 1048576, 2097152, 4194304, 8388608,16777216, 33554432, 67108864, 134217728, 268435456, 536870912, 1073741824)).contains(n);
//   }
// }
