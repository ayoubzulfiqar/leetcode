# 🔥 Dart 🔥 || Simple Fast and Easy || with Explanation

## Code -1

```dart
class Node {
  late int number;
  late List<int> blueCities;
  late List<int> redCities;

  Node(int number) {
    this.number = number;
    blueCities = [];
    redCities = [];
  }
}
```

```dart
class Solution {
  List<int> shortestAlternatingPaths(
      int n, List<List<int>> redEdges, List<List<int>> blueEdges) {
    HashMap<int, Node> hashMap = HashMap();
    for (int i = 0; i < n; i++) {
      hashMap[i] = Node(i);
    }
    for (List<int> redEdge in redEdges) {
      hashMap[redEdge[0]]?.redCities.add(redEdge[1]);
    }
    for (List<int> blueEdge in blueEdges) {
      hashMap[blueEdge[0]]?.blueCities.add(blueEdge[1]);
    }
    List<int> ans = List.filled(n, -1);
    List<List<bool>> visit =
        List.filled(n, false).map((e) => List.filled(2, false)).toList();
    Queue<List<int>> q = Queue();
    q.add([0, 0, -1]);
    ans[0] = 0;
    visit[0][1] = visit[0][0] = true;

    while (q.isNotEmpty) {
      List<int> element = q.first;
      int nodeNumber = element[0], steps = element[1], prevColor = element[2];

      for (int neighbor in hashMap[nodeNumber]!.redCities) {
        if (!visit[neighbor][0] && prevColor != 0) {
          if (ans[neighbor] == -1) ans[neighbor] = 1 + steps;
          visit[neighbor][0] = true;
          q.add([neighbor, 1 + steps, 0]);
        }
      }
      for (int neighbor in hashMap[nodeNumber]!.blueCities) {
        if (!visit[neighbor][1] && prevColor != 1) {
          if (ans[neighbor] == -1) ans[neighbor] = 1 + steps;
          visit[neighbor][1] = true;
          q.add([neighbor, 1 + steps, 1]);
        }
      }
    }
    return ans;
  }
}
```

## Code -2

```dart
class Solution {
  List<int> shortestAlternatingPaths(
      int n, List<List<int>> redEdges, List<List<int>> blueEdges) {
    // Two sets one for blu and another for red
    List<List<HashSet<int>>> graph =
        List.filled(2, 0).map((e) => List.filled(n, HashSet<int>())).toList();

    for (int i = 0; i < n; i++) {
      graph[0][i] = HashSet();
      graph[1][i] = HashSet();
    }
    // red edges in 0 - col
    for (List<int> re in redEdges) {
      graph[0][re[0]].add(re[1]);
    }
    // blu edges in 1 - col
    for (List<int> blu in blueEdges) {
      graph[1][blu[0]].add(blu[1]);
    }
    List<List<int>> res =
        List.filled(2, 0).map((e) => List.filled(n, 0)).toList();
    // Zero edge is always accessible to itself - leave it as 0
    for (int i = 1; i < n; i++) {
      res[0][i] = 2 * n;
      res[1][i] = 2 * n;
    }
    // Q entries are vert with a color (up to that point)
    Queue<List<int>> q = Queue();
    q.add([0, 1]); // or with blue
    q.add([0, 0]); // either with red
    while (q.isNotEmpty) {
      List<int> cur = q.first;
      int vert = cur[0];
      int color = cur[1];
      // No need to keep track of level up to now
      // only need to keep what color - and the length
      // is automatically derived from previous node
      for (int nxt in graph[1 - color][vert]) {
        if (res[1 - color][nxt] == 2 * n) {
          res[1 - color][nxt] = 1 + res[color][vert];
          q.add([nxt, 1 - color]);
        }
      }
    }
    List<int> ans = List.filled(n, 0);
    for (int i = 0; i < n; i++) {
      int t = min(res[0][i], res[1][i]);
      ans[i] = (t == 2 * n) ? -1 : t;
    }
    return ans;
  }
}
```
