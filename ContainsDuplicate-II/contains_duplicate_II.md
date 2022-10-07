# 🔥 Contains Duplicate II 🔥 || 3 Solutions || Simple Fast and Easy || with Explanation

## Solution - 1

```dart
import 'dart:collection';

class Solution {
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
```

## Solution - 2

```dart
import 'dart:collection';

class Solution {
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

```

## Solution - 3

```dart
import 'dart:collection';

class Solution {
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
```
