# 🔥 Strobo-Grammatic Number 🔥 || Simple Fast and Easy || with Explanation

## Explanation

1. For the first test case if we rotate “69” by 180 degrees, it’s the same.

2. For the second test case if we rotate “692” by 180 degrees, it’s not the same number.

## Approach Idea

- We need to determine what each digit becomes when rotated by 180 degrees. There are three possibilities for each digit:
- it becomes invalid
- it stays the same
- it becomes a different digit
- We’ll consider a digit to be rotatable if, and only if, that digit becomes a valid digit when rotated. If we think carefully, we can identify that 0, 1, 6, 8, 9 are rotatable as only these digits are valid when it is rotated upside down by 180 degrees. So if the number contains any digit other than these, we can easily say that it is not a strobogrammatic number. For other digits, we need to check if their rotation is the same as the number at its counterpart.
- Let N be the length of the input string.

### Time complexity: O(N)

 For each of the N digits in the string, we’re doing a single lookup and comparison.

### Space complexity: O(1)

 We are only using constant extra space. This is an in-place algorithm.

## Solution - 1

```dart
import 'dart:collection';

class Solution {
  bool isStrobogrammatic(String nums) {
    HashMap<String, String> dict = HashMap();
    dict['0'] = '0';
    dict['1'] = '1';
    dict['8'] = '8';
    dict["6"] = '9';
    dict['9'] = '6';
    int i = 0;
    int j = nums.length - 1;
    while (i <= j) {
      int f = nums.codeUnitAt(i);
      int b = nums.codeUnitAt(j);
      if (dict.containsKey(f) && dict.containsKey(b) && dict[f] == b) {
        i++;
        j--;
      } else {
        return false;
      }
    }
    return true;
  }
}
```

## Solution - 2

```dart
class Solution {
  bool isStrobogrammatic(String nums) {
    final Map<String, String> lut = {
      '0': "0",
      '1': '1',
      '6': '9',
      '8': '8',
      '9': '6'
    };
    for (int l = 0, r = nums.length - 1; l <= r; l++, r--) {
      if (lut.containsKey(nums[l]) ==
              lut.entries.toList().getRange(lut.length - 2, lut.length) ||
          lut[nums[l]] != nums[r]) {
        return false;
      }
    }
    return true;
  }
}
```

## Solution - 3

```dart
class Solution {
  bool isStrobogrammatic(String nums) {
    for (int i = 0, j = nums.length - 1; i <= j; i++, j--)
      if (!"00 11 88 696".contains(
        nums[i] + "" + nums[i],
      )) return false;
    return true;
  }
}
```

## Solution - 4

```dart
import 'dart:collection';

class Solution {
  bool isStrobogrammatic(String nums) {
    HashMap<String, String> map = HashMap();
    map['0'] = '0';
    map['1'] = '1';
    map['8'] = '8';
    map["6"] = '9';
    map['9'] = '6';
    if (nums.length == 0) return false;
    int left = 0, right = nums.length - 1;
    while (left <= right) {
      int c = nums.codeUnitAt(left);
      if (!map.containsKey(c) || map[c] != nums.codeUnitAt(right)) return false;
      left++;
      right--;
    }
    return true;
  }
}
```

## Disclaimer:-

- First of all i don't have a premium subscription
- Second of all this code is in DART language but you will get the general idea how to implement in other language

## [GitHub Link](https://github.com/ayoubzulfiqar/leetcode)
