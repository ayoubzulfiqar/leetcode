# 🔥 100% FAST KADANE 🔥 || Simple Fast and Easy || with Explanation

## Approach

This problem is asking for the maximum possible sum of a non-empty sub-array of a given circular integer array.
A circular array means that the end of the array connects to the beginning of the array, so the next element of nums[i] is nums[(i + 1) % n] and the previous element of nums[i] is nums[(i - 1 + n) % n].
A sub-array may only include each element of the fixed buffer nums at most once.

One approach to solving this problem is to first find the maximum sub-array sum using the standard Kadane's algorithm, and then check if there's a better solution by finding the minimum sub-array sum and subtracting it from the total sum of the array.
This approach considers the case where the maximum sub-array sum is obtained from the sub-array that "wraps around" the circular array.

### Complexity

#### Time complexity:: O(n)

Because we are iterating through the array once and performing constant time operations inside the loop

#### Space complexity:: O(1)

Because we are using a constant amount of additional space to store the curMax, maxSum, curMin, minSum and totalSum variables.

## Code

```dart
class Solution {
  int maxSubarraySumCircular(List<int> nums) {
    int totalSum = 0, maxSum = -30012, curMax = 0, minSum = 30012, curMin = 0;
    for (int x in nums) {
      curMax = max(x, curMax + x); //update the current max sub-array sum
      maxSum = max(maxSum, curMax); //update the overall max sub-array sum
      curMin = min(x, curMin + x); //update the current min sub-array sum
      minSum = min(minSum, curMin); //update the overall min sub-array sum
      totalSum += x;
    }
    return maxSum > 0 ? max(maxSum, totalSum - minSum) : maxSum;
  }
}
```

## Code  - 2

```dart
class Solution {
  int kadane(List<int> nums) {
    int local = nums[0];
    int global = nums[0];
    for (int i = 1; i < nums.length; i++) {
      local = max(nums[i], local + nums[i]);
      global = max(global, local);
    }
    return global;
  }
  // case 1: max subarray sum in [0 .. n - 1]
  // i.e. kadane's algo
  // case 2. circular subarray in [0 .. |  n - 1 .. | .. 2 * n - 1]
  // i.e. total sum - min subarray sum in [0 .. n - 1]

  int maxSubarraySumCircular(List<int> nums) {
    int n = nums.length;
    // use kadane's algo to find out max sub array sum (case 1)
    int maxSubArraySum = kadane(nums);
    // handle cases like [-3,-2,-3]
    if (maxSubArraySum < 0) return maxSubArraySum;
    // calculate the total sum
    int totalSum = 0;
    // in order to use the same kadane function, we flip the sign
    for (int i = 0; i < n; i++) {
      totalSum += nums[i];
      nums[i] = -nums[i];
    }
    // use kadane's algo to find out min sub array sum
    int minSubArraySum = kadane(nums);
    // compare case 1 & case 2, take the max
    return max(maxSubArraySum, totalSum + minSubArraySum);
  }
}
```
