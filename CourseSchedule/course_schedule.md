#

## Topological Sort

```dart
import 'dart:collection';

class Solution {
  bool canFinish(int numCourses, List<List<int>> prerequisites) {
    final List<int> answer = [];
    final Map<int, List<int>> map = Map();
    final List<int> result = List<int>.filled(numCourses, 0);

    for (final List<int> x in prerequisites) {
      map[x[1]] = [...map[x[1]] ?? [], x[0]];
      result[x[0]]++;
    }

    final Queue<int> q = Queue<int>();
    for (int i = 0; i < numCourses; i++) {
      if (result[i] == 0) {
        q.add(i);
      }
    }

    while (q.isNotEmpty) {
      final int fr = q.removeFirst();
      answer.add(fr);

      for (final int x in map[fr] ?? []) {
        result[x]--;
        if (result[x] == 0) {
          q.add(x);
        }
      }
    }

    return answer.length == numCourses;
  }
}
```
