# 🔥 Dart || Missing Ranges ||Simple Fast Easy || with Explanation

```dart
class Solution {
  List<String> findMissingRanges(List<int> nums, int lower, int upper) {
    // array to add ranges
    List<String> result = [];
    // start at lower - 1 for edge case where lower === nums[0]
    int previous = lower - 1;
    // loop for nums.length times so we can compare the last value with upper
    for (int i = 0; i <= nums.length; i++) {
      // current number to compare to prev
      // when i === nums.length we will compare prev = nums[nums.length-1] and upper
      // the upper+1 is to account for nums[nums.length-1]===upper
      int current = (i < nums.length) ? nums[i] : upper + 1;
      // check if we need to add a range to the array
      if (previous + 1 <= current - 1) {
        // if equal then add any of the numbers to the array
        // if < than, then add the range string to the array
        result.add(previous + 1 == current - 1
            ? '${previous + 1}'
            : '${previous + 1}->${current - 1}');
      }
      // set prev to compare in the next iteration
      previous = current;
    }
    return result;
  }
}
```
