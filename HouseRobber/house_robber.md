# 🔥 House Robber 🔥 || 3 Approaches || Simple Fast and Easy || with Explanation

## Solution - 1

```dart
class Solution {
  int rob(List<int> nums) {
    //max money can get if rob current house
    int rob = 0;
    //max money can get if not rob current house
    int notRob = 0;
    for (int i = 0; i < nums.length; i++) {
      //if rob current value, previous house must not be robbed
      int curRob = notRob + nums[i];
      //if not rob ith house, take the max value of robbed (i-1)th house and not rob (i-1)th house
      notRob = max(notRob, rob);
      rob = curRob;
    }
    return max(rob, notRob);
  }
}
```

## Solution - 2

```dart
class Solution {
  int rob(List<int> nums) {
    int previous = 0;
    int last = 0;
    for (int current in nums) {
      last = max(previous + current, previous = last);
    }
    return last;
  }
}
```

## Solution - 3

```dart
import 'dart:collection';

class Solution {
  HashMap<int, int> map = HashMap();
  int rob(List<int> nums) {
    if (nums.length == 0) return 0;
    map[nums.length] = 0;
    return tryRob(nums, 0);
  }

  int tryRob(List<int> nums, int idx) {
    if (map.containsKey(idx)) return map[idx] ?? 0;

    late int maxi;
    if (nums.length - idx == 1) {
      maxi = nums[nums.length - 1];
      map[idx] = maxi;
    } else if (nums.length - idx == 2) {
      maxi = max(nums[nums.length - 1], nums[nums.length - 2]);
      map[idx] = maxi;
    } else {
      maxi = max(nums[idx] + tryRob(nums, idx + 2),
          nums[idx + 1] + tryRob(nums, idx + 3));
      map[idx] = maxi;
    }
    return maxi;
  }
}
```
