# 🔥 Minimum Average Difference 🔥 || 3 Approaches || Simple Fast and Easy || with Explanation

## Solution - 1 Greedy

```dart
class Solution {
  int minimumAverageDifference(List<int> nums) {
    // if there is only one element then itself would be the ans (index 0).
    if (nums.length == 1) return 0;

    // finding total sum of vector (using int int to prevent overflow)
    int sum = 0;
    for (int a in nums) {
      sum += a;
    }

    //initially left side sum will be zero and right side sum will be total sum
    int leftSum = 0;
    int rightSum = sum;

    // this will be used to keep track of minimum
    int avgDiff;
    int mini = -1;
    int minIndex = -1;
    int n = nums.length;

    for (int i = 0; i < n - 1; i++) {
      // increasing left sum and decreasing right sum
      leftSum += nums[i];
      rightSum -= nums[i];

      // finding avgDiff ,  (here (n-i-1) represents element count in right part, ans (i+1) in left part)
      avgDiff = ((leftSum ~/ (i + 1)) - (rightSum ~/ (n - i - 1))).abs();

      //updating mini
      if (mini == -1) {
        mini = avgDiff;
        minIndex = i;
      } else if (mini > avgDiff) {
        mini = avgDiff;
        minIndex = i;
      }
    }

    // check for last element
    avgDiff = sum ~/ n;
    if (mini > avgDiff) {
      mini = avgDiff;
      minIndex = n - 1;
    }
    return minIndex;
  }
}
```

## Solution - 2

```dart
class Solution {
  int minimumAverageDifference(List<int> nums) {
    int n = nums.length;

    int sum = 0;
    for (int num in nums) sum += num;

    int minDiff = double.maxFinite.toInt();
    int leftSum = 0;
    int rightSum = sum;
    int ans = 0;

    for (int i = 0; i < n; i++) {
      leftSum += nums[i];
      rightSum -= nums[i];
      int lAvg = leftSum ~/ (i + 1);
      int rAvg = (n - 1 - i) != 0 ? rightSum ~/ (n - 1 - i) : rightSum;
      int diff = (lAvg - rAvg).abs();
      if (diff == 0) return i;
      if (diff < minDiff) {
        minDiff = diff;
        ans = i;
      }
    }

    return ans;
  }
}
```

## Solution - 3

```dart
class Solution {
  int minimumAverageDifference(List<int> nums) {
    int ans = 0, n = nums.length, mi = double.maxFinite.toInt();
    // since we need the sum for first i + 1 and last n - i - 1 elements
    // we can pre-calculate it first
    // it is called prefix sum and suffix sum
    List<int> pref = List.filled(n, 0);
    // prev[0] is the first element
    pref[0] = nums[0];
    // starting from i = 1, pref[i] is the sum + the current element
    for (int i = 1; i < n; i++) pref[i] = pref[i - 1] + nums[i];
    // then we can iterate each number
    for (int i = 0; i < n; i++) {
      // now we know the prefix sum
      // the suffix sum is simply pref[n - 1] - pref[i]
      int k = ((pref[i] ~/ (i + 1)) -
              ((pref[n - 1] - pref[i]) ~/ max(n - i - 1, 1)))
          .abs();
      // check the min and update ans
      if (k < mi) {
        mi = k;
        ans = i;
      }
    }
    return ans;
  }
}
```
