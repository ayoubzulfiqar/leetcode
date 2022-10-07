/*

 -* Contains Duplicate II *-

Given an integer array nums and an integer k, return true if there are two distinct
indices i and j in the array such that nums[i] == nums[j] and abs(i - j) <= k.



Example 1:

Input: nums = [1,2,3,1], k = 3
Output: true
Example 2:

Input: nums = [1,0,1,1], k = 1
Output: true
Example 3:

Input: nums = [1,2,3,1,2,3], k = 2
Output: false


Constraints:

1 <= nums.length <= 105
-109 <= nums[i] <= 109
0 <= k <= 105


*/
import 'dart:collection';
import 'dart:math';

class A {
  bool containsNearbyDuplicate(List<int> nums, int k) {
    // error
    //sliding window with a hash-set
    Queue<int> q = Queue();
    HashSet<int> sets = HashSet();
    //preprocessing for 1st k elements
    for (int i = 0; i <= min(k, nums.length - 1); i++) {
      q.add(nums[i]);
      if (sets.contains(nums[i])) {
        return true;
      } else {
        sets.add(nums[i]);
      }
    }
    //process rest of the elements
    for (int i = k + 1; i < nums.length; i++) {
      sets.remove(q.remove);
      q.add(nums[i]);
      if (sets.contains(nums[i])) {
        return true;
      } else {
        sets.add(nums[i]);
      }
    }
    return false;
  }
}

class B {
// Runtime: 738 ms, faster than 66.67% of Dart online submissions for Contains Duplicate II.
// Memory Usage: 194.5 MB, less than 12.50% of Dart online submissions for Contains Duplicate II.
  bool containsNearbyDuplicate(List<int> nums, int k) {
    // Base case...
    if (nums.length < 2 || k == 0) return false;
    int i = 0;
    // Create a Hash Set for storing previous of k elements...
    HashSet<int> hashSet = HashSet<int>();
    // Traverse for all elements of the given array in a for loop...
    for (int j = 0; j < nums.length; j++) {
      // If duplicate element is present at distance less than equal to k, return true...
      if (!hashSet.add(nums[j])) {
        return true;
      }
      // If size of the Hash Set becomes greater than k...
      if (hashSet.length >= k + 1) {
        // Remove the last visited element from the set...
        hashSet.remove(nums[i++]);
      }
    }
    // If no duplicate element is found then return false...
    return false;
  }
}

class C {
// Runtime: 699 ms, faster than 75.00% of Dart online submissions for Contains Duplicate II.
// Memory Usage: 200.2 MB, less than 8.33% of Dart online submissions for Contains Duplicate II.
  bool containsNearbyDuplicate(List<int> nums, int k) {
    // HashSet to et unique pair of values
    HashSet<int> sets = HashSet();
    // looping through each and every element
    for (int i = 0; i < nums.length; ++i) {
      // if the HashSet have the value two pairs
      if (sets.contains(nums[i])) {
        // return true
        return true;
      }
      // than add into the set
      sets.add(nums[i]);
      // IF THE LENGTH IS GREATER THAN DISTINCT INDICES
      if (sets.length > k) {
        // than we will remove it from the set
        sets.remove(nums[i - k]);
      }
    }
    return false;
  }
}

class D {
// Runtime: 648 ms, faster than 87.50% of Dart online submissions for Contains Duplicate II.
// Memory Usage: 194.4 MB, less than 12.50% of Dart online submissions for Contains Duplicate II
  bool containsNearbyDuplicate(List<int> nums, int k) {
    int n = nums.length;
    HashSet<int> sets = HashSet();
    for (int i = 0; i < n; i++) {
      if (!sets.add(nums[i])) return true;
      if (sets.length > k) sets.remove(nums[i - k]);
    }
    return false;
  }
}
