# 🔥 Dart 🔥 || 3 - Solutions || simple line by line explanation

## Solution - 1 Bit Manipulation

```dart
class Solution {

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
```

## Solution - 2

### Explanation

My initial answer ran in 514ms time 100.00% . With bit manipulation you can reduce this quite a lot.

So your number is a binary number with 8 bits. You want to record the number of ones from the left side without break

That is for example 111110000 has value 5.

Step 1: Convert your array of integers call them data in this manner.

Now you just need to follow [the rather annoying in my opinion] rules of UT8C characters

1: If ANY value in data is GREATER than 4 you are automatically false.
2. If you are at the beginning of a NEW UT8C character you CANNOT be 1 [by the rules] so return false if this is so.
3. If your value is say x at position i in your array data, then the UT8C character at position i has x bytes in it. So you need to move ahead x bytes in your array data. ALSO by the RULES of UT8C [which again I think are annoying] each one of the values in data along these x positions must be equal to ONE. So return false if this is not so.
4. Finally the last condition is that if you get EXACTLY to the end of the array following steps ONE through THREE then you return TRUE. If you go out of bounds by following steps ONE through THREE return FALSE.

And so this is it.

The time constraints are simply linear.

```dart
class Solution {
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
```

## Solution - 3

```dart
class Solution {
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
```
