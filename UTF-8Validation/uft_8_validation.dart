/*

  -*  UTF-8 Validation *-


Given an integer array data representing the data, return whether it is a valid
UTF-8 encoding (i.e. it translates to a sequence of valid UTF-8 encoded characters).

A character in UTF8 can be from 1 to 4 bytes long, subjected to the following rules:

For a 1-byte character, the first bit is a 0, followed by its Unicode code.
For an n-bytes character, the first n bits are all one's, the n + 1 bit is 0,
followed by n - 1 bytes with the most significant 2 bits being 10.
This is how the UTF-8 encoding would work:

     Number of Bytes   |        UTF-8 Octet Sequence
                       |              (binary)
   --------------------+-----------------------------------------
            1          |   0xxxxxxx
            2          |   110xxxxx 10xxxxxx
            3          |   1110xxxx 10xxxxxx 10xxxxxx
            4          |   11110xxx 10xxxxxx 10xxxxxx 10xxxxxx
x denotes a bit in the binary form of a byte that may be either 0 or 1.

Note: The input is an array of integers. Only the least significant 8 bits of each integer is used to store the data. This means each integer represents only 1 byte of data.



Example 1:

Input: data = [197,130,1]
Output: true
Explanation: data represents the octet sequence: 11000101 10000010 00000001.
It is a valid utf-8 encoding for a 2-bytes character followed by a 1-byte character.


Example 2:

Input: data = [235,140,4]
Output: false
Explanation: data represented the octet sequence: 11101011 10001100 00000100.
The first 3 bits are all one's and the 4th bit is 0 means it is a 3-bytes character.
The next byte is a continuation byte which starts with 10 and that's correct.
But the second continuation byte does not start with 10, so it is invalid.


Constraints:

1 <= data.length <= 2 * 104
0 <= data[i] <= 255


*/

// class A {
//   final int bit_7_mask = 1 << 7;
//   final int bit_6_mask = 1 << 6;
//   final int bit_5_mask = 1 << 5;
//   final int bit_4_mask = 1 << 4;
//   final int bit_3_mask = 1 << 3;
//   bool validUtf8(List<int> data) {
//     int size = data.length;

//     int i = 0, count = 1;
//     int first, byteZ;

//     while (i < size) {
//       first = data[i++];
//       byteZ = getBites(first);

//       if (byteZ == -1) return false;

//       while (count < byteZ) {
//         count++;
//         if ((i == size) || (data[i++] < bit_7_mask)) return false;
//       }
//       count = 1;
//     }

//     return true;
//   }

//   int getBites(int first) {
//     // int i = 0;

//     if ((first & bit_7_mask) == 0)
//       return 1;
//     else if ((first & bit_6_mask) == 0)
//       return -1;
//     else if ((first & bit_5_mask) == 0)
//       return 2;
//     else if ((first & bit_4_mask) == 0)
//       return 3;
//     else if ((first & bit_3_mask) == 0) return 4;

//     return -1;
//   }
// }

// class B {
//   bool validUtf8(List<int> data) {
//     int remaining = 0;
//     // iterate each data and perform the following logic
//     for (int x in data) {
//       // case 1: there is no remaining segement left,
//       // then it means we should check the first segement of UTF-8 octet sequence
//       // i.e. 0xxxxxxx (for no of. bytes = 1)
//       // i.e. 110xxxxx (for no of. bytes = 2)
//       // i.e. 1110xxxx (for no of. bytes = 3)
//       // i.e. 11110xxx (for no of. bytes = 4)
//       if (remaining == 0) {
//         if ((x >> 5) == int.parse("0b110", radix: 16)) {
//           // case 1.1 - shift `x` 5 bits to the right
//           // i.e making the first (8 - 5) = 3 bits left
//           // e.g (110xxxxx >> 5) becomes 110 (in binary format)
//           // if it is 0b110,
//           // then it is only possible to form `110xxxxx 10xxxxxx`
//           // so we set remaining to 1 to look for `10xxxxxx` later
//           remaining = 1;
//         } else if ((x >> 4) == int.parse("0b1110", radix: 16)) {
//           // case 1.2 -  shift `x` 4 bits to the right
//           // i.e making the first (8 - 4) = 4 bits left
//           // e.g (1110xxxx >> 4) becomes 1110 (in binary format)
//           // if it is 0b1110,
//           // then it is only possible to form `1110xxxx 10xxxxxx 10xxxxxx`
//           // so we set remaining to 2 to look for `10xxxxxx 10xxxxxx` later
//           remaining = 2;
//         } else if ((x >> 3) == int.parse("0b11110", radix: 16)) {
//           // case 1.3 -  shift `x` 3 bits to the right
//           // i.e making the first (8 - 3) = 5 bits left
//           // e.g (11110xxx >> 5) becomes 11110 (in binary format)
//           // if it is 0b11110,
//           // then it is only possible to form `11110xxx 10xxxxxx 10xxxxxx 10xxxxxx`
//           // so we set remaining to 3 to look for `10xxxxxx 10xxxxxx 10xxxxxx` later
//           remaining = 3;
//         } else if ((x >> 7) != 0) {
//           // case 1.4 -  shift `x` 7 bits to the right
//           // i.e making the first (8 - 7) = 1 bit left
//           // e.g (0xxxxxxx >> 7) becomes 0 (in binary format)
//           // here we cover the last case which is when Number of Bytes = 1
//           // we need to make sure the first bit is 0
//           // otherwise, it is not valid
//           return false;
//         }
//       } else {
//         // case 2: check 10xxxxxx
//         // if we enter this part, that means it may be number of bytes 2, 3, or 4.
//         // based on the table in problem statement, we know what's left is just `10xxxxxx`
//         // therefore, we shift `x` 6 bits to the right
//         // i.e making the first (8 - 6) = 2 bits left
//         // e.g (10xxxxxx >> 6) becomes 10 (in binary format)
//         // if the first 2 bits are not 10 (in binary format), then it is not valid
//         if ((x >> 6) != int.parse("0b10", radix: 16))
//           return false;
//         // otherwise, this segement is ok so we decrease `remaining` by 1
//         else
//           remaining--;
//       }
//     }
//     // at the end, remaining will be 0 if data can represent the octet sequence
//     return remaining == 0;
//   }
// }

// class C {
//   bool validUtf8(List<int> data) {
//     int count = 0;
//     for (int i = 0; i < data.length; i++) {
//       int x = data[i];
//       if (count != 0) {
//         if ((x >> 5) == int.parse("0x0b110"))
//           count = 1;
//         else if ((x >> 4) == int.parse("0x0b1110"))
//           count = 2;
//         else if ((x >> 3) == int.parse("0x0b11110"))
//           count = 3;
//         else if ((x >> 7) != 0) return false;
//       } else {
//         if ((x >> 6) != int.parse("0x0b10")) return false;
//         count--;
//       }
//     }
//     return (count == 0);
//   }
// }

// class D {
//   bool validUtf8(List<int> data) {
//     int a = 0x0b0.toSigned(36);
//     int b = 0x0b110.toSigned(36);
//     int c = 0x0b1110.toSigned(36);
//     int d = 0x0b11110.toSigned(36);
//     int e = 0x0b10.toSigned(36);
//     int rbytes = 0;
//     for (int i in data) {
//       if (rbytes == 0) {
//         if ((i >> 7) == a) {
//           continue;
//         } else if ((i >> 5) == b) {
//           rbytes = 1;
//         } else if ((i >> 4) == c) {
//           rbytes = 2;
//         } else if ((i >> 3) == d) {
//           rbytes = 3;
//         } else
//           return false;
//       } else {
//         if ((i >> 6) == e) {
//           rbytes--;
//         } else {
//           return false;
//         }
//       }
//     }
//     return rbytes == 0;
//   }
// }

class E {
// Runtime: 526 ms, faster than 100.00% of Dart online submissions for UTF-8 Validation.
// Memory Usage: 143.7 MB, less than 100.00% of Dart online submissions for UTF-8 Validation.

  bool validUtf8(List<int> data) {
    int mask = 128, n = 0;
    for (int i = 0; i < data.length; i++) {
      if (n != 0) {
        if (calc(data[i]) != -1) return false;
        n--;
        continue;
      }
      n = (mask & data[i]) == 0 ? 0 : calc(data[i]) - 1;
      if (n < 0 || i + n >= data.length) return false;
      if (n > 0 && ((mask >> n + 1) & data[i]) != 0) return false;
    }
    return n == 0;
  }

  int calc(int val) {
    int n = 0;
    for (int mask = 128; (mask & val) != 0 && n != 4; n++) val = val << 1;
    return n == 1 ? -1 : n;
  }
}

class F {
// Runtime: 601 ms, faster than 100.00% of Dart online submissions for UTF-8 Validation.
// Memory Usage: 148.9 MB, less than 100.00% of Dart online submissions for UTF-8 Validation.

  bool validUtf8(List<int> data) {
    // converting into List of binary UFT - 8
    List<String> binary = data.map((e) {
      String b = "00000000" + e.toRadixString(2);
      return b.substring(b.length - 8);
    }).toList();
    // current UTF8 length
    int current = 0;
    // looping through whole binary length
    for (int i = 0; i < binary.length; i++) {
      // take the first byte based on index of the binary starting from 0
      // every element inside the binary we call byte
      int bytes = binary[i].indexOf('0');
      if (current == 0) {
        // skip the single byte character
        if (bytes == 0) {
          continue;
        }
        if (bytes > 4 || bytes < 2) {
          return false;
        }
        // set the remaining length
        current = bytes;
      } else {
        if (bytes != 1) {
          return false;
        }
      }
      current--;
    }
    return current == 0;
  }
}

class A {
// Runtime: 514 ms, faster than 100.00% of Dart online submissions for UTF-8 Validation.
// Memory Usage: 143.9 MB, less than 100.00% of Dart online submissions for UTF-8 Validation.
  int make(int n) {
    int ret = 0;
    for (int i = 7; i >= 2; i--) {
      if (n >> i == 1) {
        ret++;
        n -= 1 << i;
      } else
        break;
    }
    return ret;
  }

  // int making(int n) {
  //   String? s;
  //   var c;
  //   int i = 0;
  //   int ret = 0;
  //   for (; i < 8; i++) {
  //     c = '0' + (n % 2).toString();
  //     s = s! + c;
  //     n = n ~/ 2;
  //   }

  //   for (int i = 7; i >= 0; i--) {
  //     if (s![i] == '1')
  //       ret++;
  //     else
  //       break;
  //   }
  //   return ret;
  // }

  bool validUtf8(List<int> data) {
    for (int i = 0; i < data.length; i++) {
      data[i] = make(data[i]);
    }
    int i = 0, current;
    while (i < data.length) {
      current = data[i];
      if (current > 4 || current == 1) return false;
      i++;
      current--;
      while (current > 0) {
        if (i >= data.length) return false;
        if (data[i] != 1) return false;
        i++;
        current--;
      }
    }

    return true;
  }
}
