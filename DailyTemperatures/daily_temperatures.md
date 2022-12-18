# 🔥 Daily Temperatures 🔥 || 3 Approaches || Simple Fast and Easy || with Explanation

## Explanation

### Idea

First, make a monotonic stack  for calculating the next greater element:

Then we will traverse the temperatures array and perform the following operations for every index i:

If the stack is not empty, then we will store the index presently at the top of the stack in a variable index. If the temperature on the ith  day is strictly greater than that at the index'th day, then we will update the ans[i] with index-i days as we have found a  temperature higher than the current day. The index is removed from the stack i.e perform a pop operation on the stack.
The above step continues till the temperature at the ith  day is strictly lesser than that at the index'th day.
If the above steps continue, we will update the ans array at positions less than i.
In the end, we will push the current iteration i into the stack.
Finally, we get the answer array with the number of days we have to wait to get a higher temperature for the current days.

#### - Time Complexity

The time complexity of the above code is O(n).

#### - Space Complexity

The space complexity of the above code is O(n).

## Solution - 1

```dart
class Solution {
  List<int> dailyTemperatures(List<int> temperatures) {
    List<int> res = List.filled(temperatures.length, 0);
    for (int i = temperatures.length - 2; i >= 0; i--) {
      int next = i + 1;
      while (
          next < temperatures.length && temperatures[next] <= temperatures[i]) {
        if (res[next] == 0) {
          next = temperatures.length;
          break;
        }
        next += res[next];
      }
      if (next < temperatures.length) {
        res[i] = next - i;
      }
    }
    return res;
  }
}
```

## Solution - 2

```dart
class Solution {
  // TLE
  List<int> dailyTemperatures(List<int> temperatures) {
    List<int> ar = List.filled(temperatures.length, 0);
    if (temperatures.length == 1) {
      ar[0] = 0;
    } else {
      for (int x = 0; x < temperatures.length; x++) {
        int p = 0;
        for (int y = x + 1; y < temperatures.length; y++) {
          if (temperatures[x] < temperatures[y]) {
            ar[x] = (y - x).abs();
            p++;
            break;
          }
        }
        if (p == 0) {
          ar[x] = 0;
        }
      }
    }
    return ar;
  }
}
```

## Solution - 3

```dart
class Solution {
  List<int> dailyTemperatures(List<int> temperatures) {
    if (temperatures.isEmpty || temperatures.length == 0) {
      return [0];
    }
    int n = temperatures.length;
    List<int> res = List.filled(temperatures.length, 0);
    List<int> stack = [];
    for (int j = n - 1; j >= 0; j--) {
      while (stack.isNotEmpty && temperatures[stack.last] <= temperatures[j])
        stack.removeLast();
      res[j] = stack.isEmpty ? 0 : stack.last - j;
      stack.add(j);
    }
    return res;
  }
}
```
