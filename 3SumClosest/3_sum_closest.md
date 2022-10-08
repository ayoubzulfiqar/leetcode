# 🔥 3Sum Closest 🔥 || 3 Solutions || Simple Fast and Easy || with Explanation

## Solution - 1 Two Pointers O(nlogn)

```dart
class Solution {
  int threeSumClosest(List<int> nums, int target) {
    int ans = 1e6.toInt();
    int n = nums.length;

    nums.sort();
    for (int i = 0; i < n - 2; i++) {
      int j = i + 1, k = n - 1;
      while (j < k) {
        int sum = nums[i] + nums[j] + nums[k];
        if (sum == target)
          return target;
        else if (sum > target) {
          k--;
        } else {
          j++;
        }
        if ((sum - target).abs() < (ans - target).abs()) ans = sum;
      }
    }
    return ans;
  }
}
```

## Solution - 2 Recursive

```dart
class Solution {
  int getClose(int idx, int target, List<int> nums) {
    int n = nums.length, l = idx, r = n - 1;
    int resClosest = nums[idx] + nums[n - 1];

    while (l < r) {
      int curSum = nums[l] + nums[r];
      if (curSum == target) return target;
      if (curSum > target)
        r--;
      else
        l++;
      if ((target - curSum).abs() < (target - resClosest).abs())
        resClosest = curSum;
    }

    return resClosest;
  }

  int threeSumClosest(List<int> nums, int target) {
    nums.sort();
    int res = nums[0] + nums[1] + nums[2], n = nums.length;

    for (int i = 0; i < n - 2; i++) {
      int current = getClose(i + 1, target - nums[i], nums) + nums[i];
      if ((target - current).abs() < (target - res).abs()) res = current;
    }
    return res;
  }
}
```

## Solution - 3 Brute Force TLE

```dart
class Solution {
  int threeSumClosest(List<int> nums, int target) {
    int diff = 1e6.toInt();
    int ans = 0;
    for (int i = 0; i < nums.length; i++) {
      for (int j = i + 1; j < nums.length; j++) {
        for (int k = j + 1; k < nums.length; k++) {
          int val = nums[i] + nums[j] + nums[k];
          if ((val - target).abs() < diff) {
            diff = (val - target).abs();
            ans = val;
          }
        }
      }
    }
    return ans;
  }
}
```
