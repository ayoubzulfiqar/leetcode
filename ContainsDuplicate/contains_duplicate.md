# 🔥 Contains Duplicate 🔥 || 3 Solution || Simple Fast and Easy || with Explanation

## Solution - 1 Brute Force

```dart
class Solution {
// Runtime: 2349 ms, faster than 10.54% of Dart online submissions for Contains Duplicate.
// Memory Usage: 173.3 MB, less than 23.00% of Dart online submissions for Contains Duplicate.
  bool containsDuplicate(List<int> nums) {
    // if the length is 0
    if (nums.length == 0) return true;
    // looping through each element in the array
    for (int i = 0; i < nums.length; i++) {
        // inner loop to iterate through the next value
      for (int j = i + 1; j < nums.length; j++) {
        // if they are same than true
        if (nums[i] == nums[j]) {
          return true;
        }
      }
    }
    // else false
    return false;
  }
}
```

## Solution - 2 O(nlogn)

```dart
class Solution {
// Runtime: 716 ms, faster than 23.32% of Dart online submissions for Contains Duplicate.
// Memory Usage: 167.4 MB, less than 81.79% of Dart online submissions for Contains Duplicate.
  bool containsDuplicate(List<int> nums) {
    // sorting to arrange every element in a list
    nums.sort();
    // looping through each and every element
    for (int i = 1; i < nums.length; i++) {
        // if i - 1 is index so index is same as value than true
      if (nums[i - 1] == nums[i] || nums.length == 0) {
        return true;
      }
    }
    // else false
    return false;
  }
}
```

## Solution - 3 SET O(n)

```dart
class Solution {
//   Runtime: 794 ms, faster than 16.93% of Dart online submissions for Contains Duplicate.
// Memory Usage: 172.5 MB, less than 30.99% of Dart online submissions for Contains Duplicate.
  bool containsDuplicate(List<int> nums) {
    // if it empty
    if (nums.length == 0) return true;
    // set to store our value
    Set s = Set();
    // looping through each element
    for (int i = 0; i < nums.length; i++) {
        // set have pairs value so if both of the are same than it' true
      if (s.contains(nums[i])) {
        return true;
      }
      // adding the list value inside the set
      s.add(nums[i]);
    }
    // if not found return false
    return false;
  }
}
```
