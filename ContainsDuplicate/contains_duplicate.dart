/*

 -* Contains Duplicate *-

Given an integer array nums, return true if any value appears at least twice in the array, and return false if every element is distinct.



Example 1:

Input: nums = [1,2,3,1]
Output: true
Example 2:

Input: nums = [1,2,3,4]
Output: false
Example 3:

Input: nums = [1,1,1,3,3,4,3,2,4,2]
Output: true


Constraints:

1 <= nums.length <= 105
-109 <= nums[i] <= 109


*/

class A {
// Brute Force
// Runtime: 2349 ms, faster than 10.54% of Dart online submissions for Contains Duplicate.
// Memory Usage: 173.3 MB, less than 23.00% of Dart online submissions for Contains Duplicate.
  bool containsDuplicate(List<int> nums) {
    if (nums.length == 0) return true;
    for (int i = 0; i < nums.length; i++) {
      for (int j = i + 1; j < nums.length; j++) {
        if (nums[i] == nums[j]) {
          return true;
        }
      }
    }
    return false;
  }
}

class B {
  // O(nlogn)
// Runtime: 716 ms, faster than 23.32% of Dart online submissions for Contains Duplicate.
// Memory Usage: 167.4 MB, less than 81.79% of Dart online submissions for Contains Duplicate.
  bool containsDuplicate(List<int> nums) {
    nums.sort();
    for (int i = 1; i < nums.length; i++) {
      if (nums[i - 1] == nums[i] || nums.length == 0) {
        return true;
      }
    }
    return false;
  }
}

class C {
  // Using SET O(n)
//   Runtime: 794 ms, faster than 16.93% of Dart online submissions for Contains Duplicate.
// Memory Usage: 172.5 MB, less than 30.99% of Dart online submissions for Contains Duplicate.
  bool containsDuplicate(List<int> nums) {
    if (nums.length == 0) return true;
    Set s = Set();
    for (var i = 0; i < nums.length; i++) {
      if (s.contains(nums[i])) {
        return true;
      }
      s.add(nums[i]);
    }
    return false;
  }
}

class D {
  bool containsDuplicate(List<int> nums) {
    Set<int> hs = Set(); //taken a HashSet
    for (int x in nums) {
      hs.add(x);
    } //added all the array elements in HashSet and HashSet will remove the Delicacy
    return hs.length !=
        nums.length; // if HashSet Size is not equal to array Length it means there were duplicate elements and if HashSet size and Array length is same then no Duplicates present
  }
}
