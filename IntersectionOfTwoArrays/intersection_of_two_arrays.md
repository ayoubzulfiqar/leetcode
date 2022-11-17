# 🔥 Intersection of Two Arrays 🔥 || 4 Approaches || Simple Fast and Easy || with Explanation

## Solution - 1

```dart
import 'dart:collection';

class Solution {
  List<int> intersection(List<int> nums1, List<int> nums2) {
    HashSet<int> hashSet = HashSet();
    nums1.sort();
    nums2.sort();
    int i = 0;
    int j = 0;
    while (i < nums1.length && j < nums2.length) {
      if (nums1[i] < nums2[j]) {
        i++;
      } else if (nums1[i] > nums2[j]) {
        j++;
      } else {
        hashSet.add(nums1[i]);
        i++;
        j++;
      }
    }
    List<int> result = List.filled(hashSet.length, 0);
    int k = 0;
    for (int number in hashSet) {
      result[k++] = number;
    }
    return result;
  }
}
```

## Solution - 2

```dart
import 'dart:collection';

class Solution {
  List<int> intersection(List<int> nums1, List<int> nums2) {
    HashSet hashSet = HashSet();
    for (int i = 0; i < nums1.length; i++) {
      hashSet.add(nums1[i]);
    }
    List<int> arr = [];
    for (int i = 0; i < nums2.length; i++) {
      if (hashSet.contains(nums2[i])) {
        arr.add(nums2[i]);
        hashSet.remove(nums2[i]);
      }
    }
    return arr;
  }
}
```

## Solution - 3

```dart
import 'dart:collection';

class Solution {
  List<int> intersection(List<int> nums1, List<int> nums2) {
    HashSet<int> hashSet = HashSet();
    nums2.sort();
    for (int number in nums1) {
      if (binarySearch(nums2, number)) {
        hashSet.add(number);
      }
    }
    int i = 0;
    List<int> result = List.filled(hashSet.length, 0);
    for (int number in hashSet) {
      result[i++] = number;
    }
    return result;
  }

  bool binarySearch(List<int> nums, int target) {
    int low = 0;
    int high = nums.length - 1;
    while (low <= high) {
      int mid = low + (high - low) ~/ 2;
      if (nums[mid] == target) {
        return true;
      }
      if (nums[mid] > target) {
        high = mid - 1;
      } else {
        low = mid + 1;
      }
    }
    return false;
  }
}
```

## Solution - 4

```dart
class Solution {
  List<int> intersection(List<int> nums1, List<int> nums2) {
    List<int> result = [];
    if (nums1.isEmpty || nums2.isEmpty) return result;

    nums1.sort();
    nums2.sort();

    for (int i = 0, j = 0; i < nums1.length && j < nums2.length;) {
      if (nums1[i] == nums2[j]) {
        int size = result.length;
        i++;
        j++;
        if (size != 0 && result.elementAt(size - 1) == nums1[i - 1]) continue;
        result.add(nums1[i - 1]);
      } else if (nums1[i] < nums2[j])
        i++;
      else
        j++;
    }
    return result;
  }
}
```
