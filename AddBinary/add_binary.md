# ✅ Dart | Add Binary | Simple and Fast

## Solution - 1

```dart
class Solution {
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
```
