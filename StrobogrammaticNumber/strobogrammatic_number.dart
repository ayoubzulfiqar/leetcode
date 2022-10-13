/*


 -* Strobo-Grammatic Number *-

 A strobogrammatic number is a number that looks the same when rotated 180 degrees (looked at upside down).

Write a function to determine if a number is strobogrammatic. The number is represented as a string.

For example, the numbers "69", "88", and "818" are all strobogrammatic.

*/

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

class B {
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

class C {
  bool isStrobogrammatic(String nums) {
    for (int i = 0, j = nums.length - 1; i <= j; i++, j--)
      if (!"00 11 88 696".contains(
        nums[i] + "" + nums[i],
      )) return false;
    return true;
  }
}

class D {
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
