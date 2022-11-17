/*

-* 349. Intersection of Two Arrays *-


Given two integer arrays nums1 and nums2, return an array of their intersection. Each element in the result must be unique and you may return the result in any order.



Example 1:

Input: nums1 = [1,2,2,1], nums2 = [2,2]
Output: [2]
Example 2:

Input: nums1 = [4,9,5], nums2 = [9,4,9,8,4]
Output: [9,4]
Explanation: [4,9] is also accepted.


Constraints:

1 <= nums1.length, nums2.length <= 1000
0 <= nums1[i], nums2[i] <= 1000


*/

import 'dart:collection';

class A {
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

class B {
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

class C {
  List<int> intersection(List<int> nums1, List<int> nums2) {
    HashSet<int> hashSet = new HashSet();
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

class D {
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
