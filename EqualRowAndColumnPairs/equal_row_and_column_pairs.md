# 🔥 2 Solutions 🔥 || Simple Fast and Easy || with Explanation 😈

## Solution - 1

```dart
class Solution {
  List<List<int>> transpose(List<List<int>> gr) {
    final List<List<int>> gc = [].map((e) => <int>[]).toList();
    int n = gr.length;

    for (int i = 0; i < n; i++) {
      final List<int> v = <int>[];
      for (int j = 0; j < n; j++) {
        v.add(gr[j][i]); // column-wise pushing
      }
      gc.add(v);
    }

    return gc;
  }

  bool isListEqual(List<int> listOne, List<int> listTwo) {
    if (listOne.length != listTwo.length) {
      return false;
    }

    for (int i = 0; i < listOne.length; i++) {
      if (listOne[i] != listTwo[i]) {
        return false;
      }
    }

    return true;
  }

  int equalPairs(List<List<int>> gr) {
    final List<List<int>> gc = transpose(gr);
    final int n = gr.length;

    int ans = 0;
    for (int i = 0; i < n; i++) {
      for (int j = 0; j < n; j++) {
        if (isListEqual(gr[i], gc[j])) {
          ans++;
        }
      }
    }

    return ans;
  }
}
```

## Solution - 2

```dart
import 'dart:collection';

class Solution {
  int equalPairs(List<List<int>> grid) {
    int pair = 0;
    int temp = 0;
    int row = 0;

    while (temp <= grid.length - 1) {
      final HashMap<int, int> map = HashMap<int, int>();
      for (int j = 0; j < grid.length; j++) {
        map[j] = grid[row][j];
      }
      for (int i = 0; i < grid.length; i++) {
        int current = 0;
        for (int k = 0; k < grid.length; k++) {
          if (map[k] != grid[k][i]) {
            current = 0;
            break;
          } else {
            current = 1;
          }
        }
        pair += current;
      }
      row++;
      temp++;
    }
    return pair;
  }
}
```
