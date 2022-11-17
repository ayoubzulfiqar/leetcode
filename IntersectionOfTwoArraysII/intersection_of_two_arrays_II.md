# 🔥 Intersection of Two Arrays II 🔥 || 3 Approaches || Simple Fast and Easy || with Explanation

## Solution - 1

```dart
import 'dart:collection';

class Solution {
  List<int> intersect(List<int> nums1, List<int> nums2) {
    if (nums1.isEmpty ||
        nums2.isEmpty ||
        nums1.length == 0 ||
        nums2.length == 0) return [];
    HashMap<int, int> map = HashMap();
    List<int> result = [];
    for (int number in nums1)
      if (map.containsKey(number))
        map[number] = map[number]! + 1;
      else
        map[number] = 1;
    for (int number in nums2) {
      if (map.containsKey(number) && map[number]! > 0) {
        result.add(number);
        int freq = map[number]!;
        freq--;
        map[number] = freq;
      }
    }
    return listToArray(result);
  }

  List<int> listToArray(List<int> list) {
    List<int> result = List.filled(list.length, 0);
    for (int i = 0; i < list.length; i++) {
      result[i] = list.elementAt(i);
    }
    return result;
  }
}
```

## Solution - 2

```dart
class Solution {
  List<int> intersect(List<int> nums1, List<int> nums2) {
    nums1.sort();
    nums2.sort();
    List<int> res = [];
    int left = 0, right = 0;
    while (left < nums1.length && right < nums2.length) {
      if (nums1[left] == nums2[right]) {
        res.add(nums1[left]);
        left++;
        right++;
      } else if (nums1[left] < nums2[right]) {
        left++;
      } else
        right++;
    }
    return res;
  }
}
```

## Solution - 3

```dart
class Solution {
  List<int> intersect(List<int> nums1, List<int> nums2) {
    List<int> arr = List.filled(1001, 0);
    List<int> ans = List.filled(1001, 0);
    int count = 0;
    for (int i in nums1) {
      arr[i]++;
    }
    for (int i in nums2) {
      if (arr[i] > 0) {
        ans[count++] = i;
        arr[i]--;
      }
    }
    return List.copyRange(ans, 0, [0, count]) as List<int>;
  }
}
```
