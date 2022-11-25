# 🔥 Sum of Sub-array Minimums 🔥 || 3 Solutions || Simple Fast and Easy || with Explanation

## Solution - 1 MonoStack

### Monotonic stack

A function is said to be monotonic if it preserves a given order. A monotonically increasing function never decreases. Likewise, a monotonically decreasing function never increases.
Similarly, a monotonic stack contains elements that preserve a given order. A monotone increasing stack contains elements that never decrease. Likewise, a monotone decreasing stack contains elements that never increase.

[1,1,1,2,3,4,5,6,7,8,8,9,9,9,10] Monotone Increasing stack

[10,10,9,8,7,6,5,4,4,3,2,1,1,1] Monotone Decreasing stack

```dart
class Solution {
  int sumSubarrayMins(List<int> arr) {
    int res = 0;
    int sz = arr.length;
    int mod = 1000000007;
    List<int> ms = [-1];
    for (int i = 0; i <= sz; ++i) {
      while (ms.last != -1 && (i == sz || arr[i] <= arr[ms.last])) {
        int j = ms.last;
        ms.removeLast();
        res = (res + arr[j] * (j - ms.last) * (i - j)) % mod;
      }
      ms.add(i);
    }
    return res;
  }
}
```

## Solution - 2 Brute Force

optimization of above problem: time O(n^2)
in previous solution , we are creating sub-arrays from start to end.
now we will start creating sub-arrays from end to start .
we will create sub-arrays like end to end , end-1 to end , then end-2 to end .....start to end.In this process we are calculating min also.
so no need to calculate min individually

```dart
class Solution {
  int sumSubarrayMins(List<int> arr) {
    int res = 0;
    int n = arr.length;
    int mod = (1e9 + 7).toInt();
    for (int end = 0; end < n; end++) {
      for (int start = 0; start <= end; start++) {
        int mini = double.maxFinite.toInt();
        for (int i = start; i <= end; i++) mini = min(mini, arr[i]);
        res = (res + mini) % mod;
      }
    }
    return res;
  }
}
```

## Solution - 3 Queue

most Optimized solution: time O(n)

- for each element do :

1. use a stack to find no. of elements in between current element and smaller element(than current) on both left and right side. (Save them in array)
2. after finding above numbers , we will find number of sub-arrays for which current element is minimum (no of elements on left\*no of elements on right).
3. after finding no. of such sub-arrays multiply it with value of current element to get sum of minimum of all sub-arrays with current element as its minimum.
   Note: I know this solution is not intuitive...I also didn't think of this solution on first place.I came up with O(n^2) solution,
   then I took hints from youtube videos. (Not the code but some thinking).So its fine if you aren't able to solve this problem in first go.
   If you still not able to get it , dry run below code and you will able to it.

```dart
class Solution {
  int sumSubarrayMins(List<int> arr) {
    int n = arr.length;
    List<int> leftMin = List.filled(n,
        0); //store no.  elements between current element and left smaller element.
    List<int> rightMin = List.filled(n,
        0); //store no.  elements between current element and right smaller element.
    int mod = (1e9 + 7).toInt();
    Queue<int> ind = Queue();
    for (int i = 0; i < n; i++) {
      while (ind.isNotEmpty && arr[ind.last] > arr[i]) ind.removeLast();
      leftMin[i] = ind.isEmpty ? i + 1 : i - ind.last;
      ind.add(i);
    }
    ind = Queue();
    for (int i = n - 1; i >= 0; i--) {
      while (ind.isNotEmpty && arr[ind.last] >= arr[i]) ind.removeLast();
      rightMin[i] = ind.isEmpty ? n - i : ind.last - i;
      ind.add(i);
    }
    int res = 0;
    for (int i = 0; i < n; i++)
      res = (res + arr[i] * leftMin[i] * rightMin[i]) %
          mod; //finding sum of minimum of all possible sub-arrays with current element as minimum.
    return res;
  }
}
```
