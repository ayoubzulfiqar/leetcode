# 🔥 3 Approaches 🔥 || Simple Fast and Easy || with Explanation

## Solution - 1 BRUTE FORCE

```dart
class Solution {
  int minDeletionSize(List<String> strs) {
    int answer = 0;
    for (int i = 0; i < strs[0].length; i++) {
      for (int j = 0; j < strs.length - 1; j++) {
        if (strs[j + 1].codeUnitAt(i) < strs[j].codeUnitAt(i)) {
          answer++;
          break;
        }
      }
    }
    return answer;
  }
}
```

## Solution - 2 O(n * m)

```dart
class Solution {
  int minDeletionSize(List<String> strs) {
    int deleted = 0;
    if (strs.length == 0) return deleted;
    int rowSize = strs[0].length;

    for (int col = 0; col < rowSize; col++) {
      if (!isSorted(strs, col)) deleted++;
    }

    return deleted;
  }

  bool isSorted(List<String> strs, int col) {
    int N = strs.length;
    int prev = 0;
    for (int i = 0; i < N; i++) {
      int c = strs[i].codeUnitAt(col);
      //If out of order
      if (c < prev) return false;
      //update prev
      prev = c;
    }

    return true; //In order the whole time
  }
}
```

## Solution - 3

```dart
import 'dart:collection';

class Solution {
  int minDeletionSize(List<String> strs) {
    HashSet<int> hashSET = HashSet();
    for (int j = 0; j < strs[0].length; j++) hashSET.add(j);
    for (int i = 1; i < strs.length; i++) {
      HashSet<int> tmp = HashSet();
      tmp.addAll(hashSET);
      for (int k in hashSET)
        if (strs[i].codeUnitAt(k) < strs[i - 1].codeUnitAt(k)) tmp.remove(k);
      hashSET = tmp;
    }
    return strs[0].length - hashSET.length;
  }
}
```
