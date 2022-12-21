# 🔥 Possible Bipartition 🔥 || 3 Approaches || Simple Fast and Easy || with Explanation

## Solution - 1 Depth First Search

```dart
class Solution {
  bool possibleBipartition(int n, List<List<int>> dislikes) {
    List<List<int>> graph =
        List.filled(n, 0).map((e) => List.filled(n, 0)).toList();
    for (List<int> d in dislikes) {
      graph[d[0] - 1][d[1] - 1] = 1;
      graph[d[1] - 1][d[0] - 1] = 1;
    }
    List<int> group = List.filled(n, 0);
    for (int i = 0; i < n; i++) {
      if (group[i] == 0 && !depthFirstSearch(graph, group, i, 1)) {
        return false;
      }
    }
    return true;
  }

  bool depthFirstSearch(
      List<List<int>> graph, List<int> group, int index, int g) {
    group[index] = g;
    for (int i = 0; i < graph.length; i++) {
      if (graph[index][i] == 1) {
        if (group[i] == g) {
          return false;
        }
        if (group[i] == 0 && !depthFirstSearch(graph, group, i, -g)) {
          return false;
        }
      }
    }
    return true;
  }
}
```

## Solution - 2 Breadth First Search

```dart
import 'dart:collection';

class Solution {
  bool possibleBipartition(int n, List<List<int>> dislikes) {
    int len = dislikes.length;
    if (len < 2) return true;
    List<int> color = List.filled(n + 1, 0);
    List<List<int>> graph = [];
    for (int i = 0; i <= n; i++) {
      List<int> tmp = [];
      graph.add(tmp);
    }
    for (int i = 0; i < len; i++) {
      int m = dislikes[i][0];
      int n = dislikes[i][1];
      graph[m].add(n);
      graph[n].add(m);
    }
    for (int i = 1; i <= n; i++) {
      if (color[i] == 0) {
        color[i] = 1;
        Queue<int> q = Queue();
        q.add(i);
        while (q.isNotEmpty) {
          int cur = q.removeFirst();
          for (int j in graph[cur]) {
            if (color[j] == 0) {
              color[j] = color[cur] == 1 ? 2 : 1;
              q.add(j);
            } else {
              if (color[j] == color[cur]) return false;
            }
          }
        }
      }
    }
    return true;
  }
}
```

## Solution - 3 Memoization

```dart
import 'dart:collection';

class Solution {
  HashMap<int, List<int>> map = HashMap();
  bool possibleBipartition(int n, List<List<int>> dislikes) {
    for (List<int> dis in dislikes) {
      if (map[dis[0]] == null) map[dis[0]] = [];
      map[dis[0]]?.add(dis[1]);
      if (map[dis[1]] == null) map[dis[1]] = [];
      map[dis[1]]?.add(dis[0]);
    }
    List<int> colors = List.filled(n + 1, 0);
    for (int i = 1; i <= n; i++) {
      if (map[i] == null) continue;
      if (colors[i] == 0 && !helper(i, colors, 1)) return false;
    }
    return true;
  }

  bool helper(int index, List<int> colors, int color) {
    if (colors[index] != 0) return color == colors[index];
    int len = map[index]!.length;
    colors[index] = color;
    for (int i = 0; i < len; i++) {
      if (!helper(map[index]![i], colors, -1 * color)) return false;
    }
    return true;
  }
}
```
