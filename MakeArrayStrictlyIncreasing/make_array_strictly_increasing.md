# 🔥 2 Solutions 🔥 || Simple Fast and Easy || with Explanation 😈

## Solution - 1

```dart
import 'dart:collection';

class Solution {
  // Used for dp memoization
  HashMap<List<int>, int> map = HashMap();

  int makeArrayIncreasing(List<int> arr1, List<int> arr2) {
    // Used for finding the upper value of arr2
    SplayTreeMap<int, int> m = SplayTreeMap();
    for (int x in arr2) {
      m[x] = m.containsKey(x) ? m[x]! + 1 : 1;
    }
    map.clear();
    return find(0, arr1, -1, arr2, m) == 1e9.toInt()
        ? -1
        : find(0, arr1, -1, arr2, m);
  }

  int find(int i, List<int> arr1, int prev, List<int> arr2,
      SplayTreeMap<int, int> m) {
    if (i >= arr1.length) {
      return 0;
    }
    List<int> l1 = [i, prev];
    // If prev state is already present, just return it
    if (map.containsKey(l1)) return map[l1]!;
    // Calculating upper value
    int? higher = m.firstKeyAfter(prev);
    int res = 1e9.toInt();
    if (prev < arr1[i]) {
      res = res < find(i + 1, arr1, arr1[i], arr2, m)
          ? res
          : find(i + 1, arr1, arr1[i], arr2, m);
    }
    // If upper bound is present in arr2, then replace and increment the count
    if (higher != null) {
      res = res < 1 + find(i + 1, arr1, higher, arr2, m)
          ? res
          : 1 + find(i + 1, arr1, higher, arr2, m);
    }
    List<int> l2 = [i, prev];
    map[l2] = res;
    return res;
  }
}
```

## Solution - 2

```dart
class Solution {
  int makeArrayIncreasing(List<int> arr1, List<int> arr2) {
    int n = arr1.length;

    arr2.sort();
    List<int> uniqueArr2 = [];
    for (int i = 0; i < arr2.length; i++) {
      if (i + 1 < arr2.length && arr2[i] == arr2[i + 1]) {
        continue;
      }
      uniqueArr2.add(arr2[i]);
    }
    arr2 = uniqueArr2;

    List<int> newArr1 = List.filled(n + 2, 0);
    for (int i = 0; i < n; i++) {
      newArr1[i + 1] = arr1[i];
    }
    newArr1[n + 1] = (pow(2, 31).toInt() - 1);
    newArr1[0] = -pow(2, 31).toInt();
    arr1 = newArr1;

    List<int> dp = List.filled(n + 2, pow(2, 31).toInt() - 1);
    dp[0] = 0;
    for (int i = 1; i < n + 2; i++) {
      for (int j = 0; j < i; j++) {
        if (arr1[j] < arr1[i] && dp[j] != pow(2, 31) - 1) {
          int change = check(arr1, arr2, j, i);
          if (change >= 0) {
            dp[i] = min(dp[i], dp[j] + change);
          }
        }
      }
    }
    return dp[n + 1] == pow(2, 31) - 1 ? -1 : dp[n + 1];
  }

  int check(List<int> arr1, List<int> arr2, int start, int end) {
    if (start + 1 == end) {
      return 0;
    }
    int min = arr1[start];
    int max = arr1[end];
    int idx = arr2.indexOf(min);
    if (idx < 0) {
      idx = -idx - 1;
    } else {
      idx = idx + 1;
    }

    int maxCount = end - start - 1;
    int endIdx = idx + maxCount - 1;
    if (endIdx < arr2.length && arr2[endIdx] < max) {
      return maxCount;
    } else {
      return -1;
    }
  }
}
```
