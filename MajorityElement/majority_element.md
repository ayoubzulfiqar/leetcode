# 🔥 Majority Element 🔥 || 2 Solutions || Simple Fast and Easy || with Explanation

## Solution - 1

```dart
class Solution {
// Runtime: 512 ms, faster than 58.33% of Dart online submissions for Majority Element.
// Memory Usage: 147.1 MB, less than 66.67% of Dart online submissions for Majority Element.

  int majorityElement(List<int> nums) {
    int n = nums.length;
    int majEle = nums[0];
    int count = 1;

    for (int i = 1; i < n; i++) {
      if (nums[i] == majEle) {
        count++;
      } else {
        count--;
        if (count == 0) {
          majEle = nums[i];
          count = 1;
        }
      }
    }

    return majEle;
  }
}
```

## Solution - 2

```dart
class Solution {
// Runtime: 505 ms, faster than 61.11% of Dart online submissions for Majority Element.
// Memory Usage: 146.7 MB, less than 94.44% of Dart online submissions for Majority Element.
  int majorityElement(List<int> nums) {
    int major = nums[0], count = 1;
    for (int i = 1; i < nums.length; i++) {
      if (count == 0) {
        count++;
        major = nums[i];
      } else if (major == nums[i]) {
        count++;
      } else
        count--;
    }
    return major;
  }
}
```
