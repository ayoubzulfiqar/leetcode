# 🔥 100% FAST 🔥 || Simple Fast and Easy || with Explanation

```dart
import 'dart:collection';

class SummaryRanges {
  HashMap<int, int> front = HashMap();
  HashMap<int, int> back = HashMap();
  HashSet<int> set = HashSet();
  SummaryRanges() {}

  void addNum(int value) {
    if (set.contains(value)) {
      return;
    }

    if (back.containsKey(value - 1) && front.containsKey(value + 1)) {
      int st = back[value - 1] ?? 0;
      int end = front[value + 1] ?? 0;
      front.remove(value + 1);
      front.remove(st);
      back.remove(end);
      back.remove(value - 1);
      front[st] = end;
      back[end] = st;
    } else if (front.containsKey(value + 1)) {
      int end = front[value + 1] ?? 0;
      front.remove(value + 1);
      back.remove(end);
      front[value] = end;
      back[end] = value;
    } else if (back.containsKey(value - 1)) {
      int st = back[value - 1] ?? 0;
      front.remove(st);
      back.remove(value - 1);
      front[st] = value;
      back[value] = st;
    } else {
      front[value] = value;
      back[value] = value;
    }
    set.add(value);
  }

  List<List<int>> getIntervals() {
    int n = front.length;
    List<List<int>> ans =
        List.filled(n, 0).map((e) => List.filled(2, 0)).toList();
    int i = 0;
    for (MapEntry<int, int> e in front.entries) {
      int p = e.key;
      int q = e.value;
      ans[i][0] = p;
      ans[i][1] = q;
      i++;
    }
    return ans;
  }
}

```

```dart
import 'dart:collection';

class SummaryRanges {
  late HashSet<int> dataSet;
  SummaryRanges() {
    this.dataSet = HashSet();
  }

  void addNum(int value) {
    dataSet.add(value);
  }

  List<List<int>> getIntervals() {
    List<List<int>> intervals = <int>[].map((e) => <int>[]).toList();

    int startI = -1, endI = -1;
    for (int n in dataSet) {
      if (startI == -1) {
        startI = n;
        endI = n;
      } else if (n == endI + 1) {
        endI = n;
      } else {
        intervals.add([startI, endI]);
        endI = n;
        startI = n;
      }
    }
    intervals.add([startI, endI]);
    return intervals;
  }
}
```
