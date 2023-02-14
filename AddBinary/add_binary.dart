/*

  -* Add Binary *-

  Given two binary strings a and b, return their sum as a binary string.



Example 1:

Input: a = "11", b = "1"
Output: "100"


Example 2:

Input: a = "1010", b = "1011"
Output: "10101"


Constraints:

1 <= a.length, b.length <= 104
a and b consist only of '0' or '1' characters.
Each string does not contain leading zeros except for the zero itself.


*/

void main() {
  final a = "11";
  final b = "1";
  final e = E().addBinary(a, b);
  print(e);
}

// class A {
//   String addBinary(String a, String b) {
//     String result = "";
//     int aCount = a.length - 1;
//     int bCount = b.length;
//     int carry = 0;
//     while (aCount >= 0 || bCount >= 0) {
//       var totalSum = carry;
//       if (aCount >= 0) {
//         // totalSum += a[aCount--] - '0';
//         aCount -= 1;
//       } else if (bCount >= 0) {
//         totalSum += b[bCount] as int;
//         bCount -= 1;
//       }
//       result = (totalSum % 2).toString() + result;
//       carry = totalSum ~/ 2;
//     }
//     if (carry > 0) {
//       result = (1).toString() + result;
//     }
//     return result;
//   }
// }

// class B {
//   String addBinary(String a, String b) =>
//       (BigInt.parse(a, radix: 2) + BigInt.parse(b, radix: 2)).toRadixString(2);
// }

// class C {
//   int stringToInt(var s) {
//     if (s == '0')
//       return 0;
//     else if (s == '1') return 1;
//     return 1;
//   }

//   String addBinary(String a, String b) {
//     // error "0" input "10" output
//     String ans = "";
//     int alen = a.length - 1;
//     int blen = b.length - 1;
//     int carry = 0;
//     int reslen = 0;
//     int tmp = 0;
//     while (alen >= 0 || blen >= 0) {
//       if (alen >= 0 && blen >= 0) {
//         tmp = stringToInt(a[alen]) + stringToInt(b[blen]) + carry;
//         // cout<<tmp<<" ";
//         alen--;
//         blen--;
//       } else if (alen >= 0) {
//         tmp = stringToInt(a[alen]) + carry;
//         alen--;
//       } else if (blen >= 0) {
//         tmp = stringToInt(b[blen]) + carry;
//         blen--;
//       }
//       if (tmp == 0) {
//         ans = "0" + ans;
//         carry = 0;
//       } else if (tmp == 1) {
//         ans = "1" + ans;
//         carry = 0;
//       } else if (tmp == 2) {
//         ans = "0" + ans;
//         carry = 1;
//       } else if (tmp == 3) {
//         ans = "1" + ans;
//         carry = 1;
//       }
//       // cout<<"ans:"<<ans<<endl;
//     }

//     if (carry == "0") return ans;

//     return ans;
//   }
// }

// class D {
//   String addBinary(String a, String b) {
//     sum(String a, String b) {
//       int j = b.length - 1;
//       int carry = 0;
//       int temp;
//       var result = '';

//       for (var i = a.length - 1; i >= 0; i--) {
//         if (j >= 0) {
//           temp = int.parse(a[i] + b[j] + carry.toString());
//           j--;
//         } else {
//           temp = int.parse(a[i] + carry.toString());
//         }

//         if (temp == 2) {
//           result = '0' + result;
//           carry = 1;
//         } else if (temp == 3) {
//           result = '1' + result;
//           carry = 1;
//         } else {
//           // error here
//           result = (temp + int.parse(result)) as String;
//           carry = 0;
//         }
//       }
//       if (carry == 1) {
//         result = '1' + result;
//       }
//       return result;
//     }

//     return a.length > b.length ? sum(a, b) : sum(b, a);
//   }
// }

class E {
  // void swap(var a, var b) {
  //   var tmp = a;
  //   a = b;
  //   b = tmp;
  // }

  String reverseStr(String str) {
    final int n = str.length;
    // for (int i = 0; i < n / 2; i++) swap(str[i], str[n - i - 1]);
    final StringBuffer sb = StringBuffer();
    for (int i = 0; i < n / 2; i++) {
      sb.writeCharCode(str.codeUnitAt(i));
      //sb.write(str[i], str[n - i - 1]);
    }
    return sb.toString();
  }

  String addBinary(String a, String b) {
    String sum = "";

    if (a.length < b.length) {
      String temp = a;
      a = b;
      b = temp;
    }
    var carry = '0';
    int k = 0;
    int j = b.length - 1;
    for (int i = a.length - 1; i >= 0; i--) {
      if (j >= 0) {
        if (a[i] == '0' && b[j] == '0' && carry == '0') {
          sum = sum + '0';
          carry = '0';
          j--;
        } else if (a[i] == '0' && b[j] == '1' && carry == '0') {
          sum = sum + '1';
          carry = '0';
          j--;
        } else if (a[i] == '1' && b[j] == '0' && carry == '0') {
          sum = sum + '1';
          carry = '0';
          j--;
        } else if (a[i] == '1' && b[j] == '1' && carry == '0') {
          sum = sum + '0';
          carry = '1';
          j--;
        } else if (a[i] == '0' && b[j] == '0' && carry == '1') {
          sum = sum + '1';
          carry = '0';
          j--;
        } else if (a[i] == '0' && b[j] == '0' && carry == '1') {
          sum = sum + '1';
          carry = '0';
          j--;
        } else if (a[i] == '1' && b[j] == '0' && carry == '1') {
          sum = sum + '0';
          carry = '1';
          j--;
        } else if (a[i] == '0' && b[j] == '1' && carry == '1') {
          sum = sum + '0';
          carry = '1';
          j--;
        } else if (a[i] == '1' && b[j] == '1' && carry == '1') {
          sum = sum + '1';
          carry = '1';
          j--;
        }
      } else {
        if (carry == '0')
          sum = sum + a[i];
        else {
          if (a[i] == '1') {
            sum = sum + '0';
            carry = '1';
          } else {
            sum = sum + carry;
            carry = '0';
          }
        }
      }
    }
    if (carry == '1') sum = sum + '1';
    reverseStr(sum);
    return sum;
  }
}

class F {
// Runtime: 622 ms, faster than 7.69% of Dart online submissions for Add Binary.
// Memory Usage: 146.4 MB, less than 46.15% of Dart online submissions for Add Binary.
  String addBinary(String a, String b) {
    /*
    First  we have to make sure the length of the both string is not same
    On second case we have to make sure that the length of the first string is larger than the second string
    than we will  populate the both strings values and join them
    */
    if (a.length != b.length) {
      if (a.length > b.length) {
        b = List.filled(a.length - b.length, (0)).join('') + b;
      } else {
        a = List.filled(b.length - a.length, (0)).join('') + a;
      }
    }
    String sum = '';
    String rem = '0';
    // looping through the index value if it's equal and larger we will decrement
    for (int index = a.length - 1; index >= 0; index--) {
      // conditions of all cases and assignments of values
      if (rem == '0') {
        if (a[index] == '1' && b[index] == '1') {
          sum = '0' + sum;
          rem = '1';
        } else if (a[index] == '0' && b[index] == '0')
          sum = '0' + sum;
        else
          sum = '1' + sum;
      } else {
        if (a[index] == '1' && b[index] == '1') {
          sum = '1' + sum;
          rem = '1';
        } else if (a[index] == '0' && b[index] == '0') {
          sum = '1' + sum;
          rem = '0';
        } else {
          sum = '0' + sum;
          rem = '1';
        }
      }
    }
    return rem == '1' ? '1' + sum : sum;
  }
}
