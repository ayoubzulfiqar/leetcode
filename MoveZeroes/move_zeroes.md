# 🔥 Move Zeroes 🔥 || 3 Approaches || Simple Fast and Easy || with Explanation

## Solution - 1

```dart
class Solution {
  void moveZeroes(List<int> nums) {
    int zero = 0;

    for (int index = 0; index < nums.length; index++) {
      if (nums[index] == 0) {
        zero++;
      } else if (zero > 0) {
        int tempBall = nums[index];
        nums[index] = 0;
        nums[index - zero] = tempBall;
      }
    }
  }
}
```

## Solution - 2

```dart
class Solution {
  void moveZeroes(List<int> nums) {
    int index = 0;
    for (int i = 0; i < nums.length; i++) {
      nums[index++] = nums[i];
    }
    while (index < nums.length) {
      nums[index] = 0;
      index++;
    }
  }
}
```

## Solution - 3

```dart
class Solution {
  void moveZeroes(List<int> nums) {
    int left = 0;
    int right = 1;
    while (left < nums.length && right < nums.length) {
      if (nums[left] == 0 && nums[right] != 0) {
        int temp = nums[left];
        nums[left] = nums[right];
        nums[right] = temp;
      } else if (nums[left] == 0 && nums[right] == 0) {
        right++;
      } else if (nums[left] != 0) {
        left++;
        right++;
      } else {
        left++;
      }
    }
  }
}
```
