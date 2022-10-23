# 🔥 Set Mismatch 🔥 || 5 Solutions || Simple Fast and Easy || with Explanation

## Approach

### Idea

`(Note: I've added another solution that has a better space complexity at O(1) extra space vs. the original solution below at O(N) extra space, but it does so at the cost of an extra iteration through nums, though the time complexity remains O(N). Skip down to the Alternate Idea section for the breakdown.)`

- For this problem, we can take advantage of some math, because one thing we know about a sequence of numbers from 1 to N is that their sum should equal the Nth triangular number (N * (N + 1) / 2).

- Since the only difference between the ideal array ranging from 1 to N and our input array nums is the duplicated number, that means that the difference between the sum of nums and the Nth triangular number is the same as the difference between our duplicated number (dupe) and the missing number.

- We can easily find the duplicated number by utilizing a boolean array (seen) to keep track of which numbers have already been seen. While iterating through nums, whenever we come across a number for the second time, that number must be our dupe. We can also use this iteration to find the difference in the sums.

- Then we can just return the dupe and the sum difference applied to the dupe to identify the missing number.

## Solution - 1

```dart
import 'dart:collection';

class Solution {
// Runtime: 723 ms, faster than 100.0% of Dart online submissions for Set Mismatch.
// Memory Usage: 164.9 MB, less than 50.00% of Dart online submissions for Set Mismatch.

  List<int> findErrorNums(List<int> nums) {
    int dup = 0, miss = 0;
    HashSet<int> hashset = HashSet();

    // find duplicate using set
    for (int i = 0; i < nums.length; ++i) {
      if (hashset.contains(nums[i])) dup = nums[i];
      hashset.add(nums[i]);
    }

    // find missing
    for (int i = 1; i <= nums.length; ++i) {
      if (hashset.contains(i) == false) {
        miss = i;
        break;
      }
    }

    return [dup, miss];
  }
}
```

## Solution - 2

```dart
class Solution {
// Runtime: 632 ms, faster than 100.0% of Dart online submissions for Set Mismatch.
// Memory Usage: 150.3 MB, less than 100.00% of Dart online submissions for Set Mismatch.
  List<int> findErrorNums(List<int> nums) {
    int n = nums.length;
    int i = 0;

    while (i < n) {
      int idx = nums[i] - 1;

      if (nums[i] != nums[idx]) {
        int temp = nums[i];
        nums[i] = nums[idx];
        nums[idx] = temp;
      } else {
        ++i;
      }
    }

    for (i = 0; i < n; ++i) {
      if (nums[i] != i + 1) {
        return [nums[i], i + 1];
      }
    }

    return [];
  }
}
```

## Solution - 3

### The idea is based on

(1 ^ 2 ^ 3 ^ .. ^ n) ^ (1 ^ 2 ^ 3 ^ .. ^ n) = 0

- Suppose we change 'a' to 'b', then all but 'a' and 'b' are XORed exactly 2 times. The result is then
0 ^ a ^ b ^ b ^ b = a ^ b
- Let c = a ^ b, if we can find 'b' which appears 2 times in the original array, 'a' can be easily calculated by a = c ^ b.

```dart
class Solution {
// Runtime: 369 ms, faster than 100.00% of Dart online submissions for Set Mismatch.
// Memory Usage: 159.3 MB, less than 50.00% of Dart online submissions for Set Mismatch.
  List<int> findErrorNums(List<int> nums) {
    List<int> ans = List.filled(2, 0);
    for (int i = 0; i < nums.length; i++) {
      int val = (nums[i]).abs();
      ans[1] ^= (i + 1) ^ val;
      if (nums[val - 1] < 0)
        ans[0] = val;
      else
        nums[val - 1] = -nums[val - 1];
    }
    ans[1] ^= ans[0];
    return ans;
  }
}
```

## Solution - 4

```dart
class Solution {
  List<int> findErrorNums(List<int> nums) {
    int n = nums.length;
    List<int> arr = List.filled(n + 1, 0);
    List<int> vec = List.empty(growable: true);

    for (int i in nums) {
      arr[i]++;
    }

    for (int i = 1; i < n + 1; i++) {
      if (arr[i] > 1) vec.add(i);
    }
    for (int i = 1; i < n + 1; i++) {
      if (arr[i] == 0) vec.add(i);
    }
    return vec;
  }
}
```

## Solution - 5

```dart
class D {
  List<int> findErrorNums(List<int> nums) {
    nums.sort();
    List<int> b = List.filled(nums.length + 1, 0);
    int x = 0;
    int y = 0;
    // int c = 1;
    for (int i = 0; i < nums.length; i++) {
      b[nums[i]] = b[nums[i]] + 1;
    }
    for (int i = 1; i < b.length; i++) {
      if (b[i] == 0) {
        y = i;
      }
      if (b[i] == 2) {
        x = i;
      }
    }
    return [x, y];
  }
}
```
