/*


-* 350. Intersection of Two Arrays II *-

Given two integer arrays nums1 and nums2, return an array of their intersection. Each element in the result must appear as many times as it shows in both arrays and you may return the result in any order.



Example 1:

Input: nums1 = [1,2,2,1], nums2 = [2,2]
Output: [2,2]
Example 2:

Input: nums1 = [4,9,5], nums2 = [9,4,9,8,4]
Output: [4,9]
Explanation: [9,4] is also accepted.


Constraints:

1 <= nums1.length, nums2.length <= 1000
0 <= nums1[i], nums2[i] <= 1000


Follow up:

What if the given array is already sorted? How would you optimize your algorithm?
What if nums1's size is small compared to nums2's size? Which algorithm is better?
What if elements of nums2 are stored on disk, and the memory is limited such that you cannot load all elements into the memory at once?

*/

import 'dart:collection';

class A {
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

class B {
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

class C {
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

    // return List.copyOfRange(ans,0,count);
    return List.copyRange(ans, 0, [0, count]) as List<int>;
  }
}
