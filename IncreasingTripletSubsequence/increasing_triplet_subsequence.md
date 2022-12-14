# 🔥 Increasing Triplet Subsequence 🔥 || 6 Solutions || Simple Fast and Easy || with Explanation

## Solution - 1

```dart
class Solution {
// Runtime: 468 ms, faster than 100.00% of Dart online submissions for Increasing Triplet Subsequence.
// Memory Usage: 178.4 MB, less than 50.00% of Dart online submissions for Increasing Triplet Subsequence.
  bool increasingTriplet(List<int> nums) {
    int n = nums.length;

    // left_min[i] will store the minimum from left till ith

    List<int> leftMin = List.filled(n, 0);

    // right_max[i] will store the maximum from right till ith

    List<int> rightMax = List.filled(n, 0);

    // fill left_min array

    leftMin[0] = nums[0];

    for (int i = 1; i < n; i++) {
      leftMin[i] = min(leftMin[i - 1], nums[i]);
    }

    // fill right_max array

    rightMax[n - 1] = nums[n - 1];

    for (int i = n - 2; i >= 0; i--) {
      rightMax[i] = max(rightMax[i + 1], nums[i]);
    }

    // check that is there any element which has smaller element on left side and greater element on right side

    for (int i = 1; i < n - 1; i++) {
      if (leftMin[i - 1] < nums[i] && nums[i] < rightMax[i + 1]) {
        return true;
      }
    }

    return false;
  }
}
```

## Solution - 2 TLE O(n2)

```dart
class Solution {
  bool increasingTriplet(List<int> nums) {
    int n = nums.length;
    List<int> t = List.filled(n, 0);
    t[0] = 1;

    for (int i = 1; i < n; i++) {
      int temp = nums[i];
      int ans = 0;
      for (int j = 0; j < i; j++) {
        if (nums[j] < temp) {
          ans = max(ans, t[j]);
        }
      }
      t[i] = 1 + ans;
      if (t[i] >= 3) return true;
    }

    for (int it in t) {
      if (it >= 3) {
        return true;
      }
    }

    return false;
  }
}
```

## Solution - 3 O(n3)

```dart
class D {
  bool increasingTriplet(List<int> nums) {
    for (int i = 0; i < nums.length - 2; i++) {
      for (int j = i + 1; j < nums.length - 1; j++) {
        for (int k = j + 1; k < nums.length; k++) {
          if (nums[i] < nums[j] && nums[j] < nums[k]) {
            return true;
          }
        }
      }
    }
    return false;
  }
}
```

## Solution - 4

```dart
class Solution {

  bool increasingTriplet(List<int> nums) {
    List<int> prevSmallest = List.filled(nums.length,
        -1); // store first smallest value's index, initialize it with -1
    List<int> nextLargest = List.filled(nums.length,
        -1); // store first largest value's index, initialize it with -1

    for (int i = 1; i < nums.length; ++i) {
      // find first previous smallest value, traverse backward
      int j = i - 1;
      while (j >= 0) {
        if (nums[j] < nums[i]) {
          prevSmallest[i] = j; // Storing indexes
          break;
        }
        --j;
      }

      // find first next largest value, traverse backward
      j = i + 1;
      while (j < nums.length) {
        if (nums[i] < nums[j]) {
          nextLargest[i] = j; // Storing indexes
        }
        ++j;
      }

      // Check prev & next is not -1, compare values
      if ((prevSmallest[i] != -1 && nextLargest[i] != -1) &&
          nums[prevSmallest[i]] < nums[i] &&
          nums[i] < nums[nextLargest[i]]) return true;
    }

    return false;
  }
}
```

## Solution - 5

```dart
class Solution {
//  Runtime: 630 ms, faster than 50.00% of Dart online submissions for Increasing Triplet Subsequence.
// Memory Usage: 177.9 MB, less than 50.00% of Dart online submissions for Increasing Triplet Subsequence.
  bool increasingTriplet(List<int> nums) {
    List<int> prevSmallest = List.filled(nums.length,
        -1); // for storing first smallest value, initialize it with -1
    List<int> nextLargest = List.filled(nums.length,
        -1); // for storing first largest value, initialize it with -1

    prevSmallest[0] = nums[0]; // first element is smallest so far from start
    nextLargest[nums.length - 1] =
        nums[nums.length - 1]; // last element is largest so far from last

    for (int i = 1; i < nums.length; ++i) {
      prevSmallest[i] = min(prevSmallest[i - 1],
          nums[i]); // Store smallest value so far from start
    }

    for (int i = nums.length - 2; i >= 0; --i) {
      nextLargest[i] = max(
          nextLargest[i + 1], nums[i]); // Store largest value so far from last
    }

    for (int i = 1; i < nums.length - 1; ++i) {
      // Compare values
      if (prevSmallest[i] < nums[i] && nums[i] < nextLargest[i]) return true;
    }

    return false;
  }
}
```

## Solution - 6

```dart
class Solution {
// Runtime: 749 ms, faster than 50.00% of Dart online submissions for Increasing Triplet Subsequence.
// Memory Usage: 174.1 MB, less than 50.00% of Dart online submissions for Increasing Triplet Subsequence.
  bool increasingTriplet(List<int> nums) {
    int n = nums.length;

    // first will keep track of first element of triplet

    int first = double.maxFinite.toInt();

    // second will keep track of second element of triple

    int second = double.maxFinite.toInt();

    // second > first

    for (int i = 0; i < n; i++) {
      if (nums[i] <= first) {
        first = nums[i];
      } else if (nums[i] <= second) {
        second = nums[i];
      } else
        return true;
    }

    return false;
  }
}
```
