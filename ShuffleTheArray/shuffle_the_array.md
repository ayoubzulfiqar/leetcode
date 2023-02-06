# 🔥 3 Approaches 🔥 || Simple Fast and Easy || with Explanation

## Intuition

Reshuffle the given array nums of length 2n into a new array such that the first element of the new array is the first element of the original array, the second element of the new array is the (n+1)th element of the original array, and so on.

## Approach

The solution uses a loop to iterate n times, and in each iteration, it pushes the ith element of nums and the (i + n) the Element of nums into the ans array. After the loop, it returns the ans array as the final result.

## Complexity

Time complexity: O(n)
Space complexity: O(n)

## Code - 1

```dart
class Solution {
  List<int> shuffle(List<int> nums, int n) {
    List<int> ans = List.filled(2 * n, 0);
    for (int i = 0; i < n; i++) {
      ans[2 * i] = nums[i];
      ans[2 * i + 1] = nums[i + n];
    }
    return ans;
  }
}
```

## Intuition

Moves each element in the array to its target position. Repeat the process for the replaced element.

## Approach

For each element in the array, move it to its final position, then repeat the process for the replaced element. Multiply the value in the position by -1 so we know when to stop the process (completed the cycle in the graph).

Then iterate over each element to restore the original value.

## Complexity

Time complexity: O(n)

Space complexity: O(1)

## Code - 2

```dart
class Solution {
  List<int> shuffle(List<int> nums, int n) {
    nums[0] *= -1;

    for (int i = 1; i < nums.length; i++) {
      int j = i;
      int currentNumber = nums[i];
      while (nums[j] > 0) {
        int target;
        if (j < n) {
          target = j * 2;
        } else {
          target = (j - n) * 2 + 1;
        }
        int temp = nums[target];
        nums[target] = currentNumber;
        currentNumber = temp;
        nums[j] *= -1;
        j = target;
      }
    }
    for (int i = 0; i < nums.length; i++) {
      nums[i] = (nums[i]).abs();
    }

    return nums;
  }
}
```

## Code - 3 Two Pointer

```dart
class Solution {
  List<int> shuffle(List<int> nums, int n) {
    int first = 0, second = n, max = 1001;
    for (int i = 0; i < 2 * n; i++) {
      if (i % 2 == 0)
        nums[i] = (nums[first++] % max) * max + nums[i];
      else
        nums[i] = (nums[second++] % max) * max + nums[i];
    }
    for (int i = 0; i < 2 * n; i++) nums[i] ~/= max;
    return nums;
  }
}
```

### Disclaimer:-

This Solution is not available in DART Programing language with is a bummer. Hurts my feeling. But as a man we should implement it no matter what. We are not bunch of wussies who gonna skip it if it's not available in one language we love. Instead we will conquer the sea and rivers and cross the mountains so see what's lies beyond our horizons.
