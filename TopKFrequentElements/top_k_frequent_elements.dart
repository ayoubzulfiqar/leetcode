/*
347. Top K Frequent Elements




Given an integer array nums and an integer k, return the k most frequent elements. You may return the answer in any order.

 

Example 1:

Input: nums = [1,1,1,2,2,3], k = 2
Output: [1,2]
Example 2:

Input: nums = [1], k = 1
Output: [1]
 

Constraints:

1 <= nums.length <= 105
-104 <= nums[i] <= 104
k is in the range [1, the number of unique elements in the array].
It is guaranteed that the answer is unique.
 

Follow up: Your algorithm's time complexity must be better than O(n log n), where n is the array's size.



*/

import 'dart:collection';

class A {
  List<int> topKFrequent(List<int> words, int k) {
    final HashMap<int, int> hashMap = HashMap<int, int>();

    for (final int word in words) {
      if (hashMap[word] == null) {
        hashMap[word] = 1;
      } else {
        hashMap[word] = hashMap[word]! + 1;
      }
    }

    final List<MapEntry<int, int>> sortedHashMap =
        hashMap.entries.toList(growable: true)
          ..sort((a, b) {
            if (a.value.compareTo(b.value) == 0) {
              return a.key.compareTo(b.key);
            }
            return b.value.compareTo(a.value);
          });

    return sortedHashMap.sublist(0, k).map((e) => e.key).toList();
  }
}
