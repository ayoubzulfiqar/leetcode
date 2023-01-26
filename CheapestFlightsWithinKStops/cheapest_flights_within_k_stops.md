# 🔥 2 Approaches 🔥 || Simple Fast and Easy || with Explanation

```dart

class Solution {
  int findCheapestPrice(
      int n, List<List<int>> flights, int src, int dst, int k) {
    // dp[i][j]: min cost to reach city j using at most i edges from src
    List<List<int>> dp =
        List.filled(k + 2, 0).map((e) => List.filled(n, double.maxFinite.toInt())).toList();

        

    // base case
    for (int i = 0; i <= k + 1; i++) dp[i][src] = 0;
    // iterate each stop
    for (int i = 1; i <= k + 1; i++) {
      // iterate each flight
      for (List<int> f in flights) {
        int from = f[0], to = f[1], cost = f[2];
        // ensure city `from` is reachable
        if (dp[i - 1][from] != double.maxFinite.toInt()) {
          // from + cost -> to
          dp[i][to] = min(dp[i][to], dp[i - 1][from] + cost);
        }
      }
    }
    // if dp[k + 1][dst] == double.maxFinite.toInt(), it means it is unreachable
    // else return the cost
    return dp[k + 1][dst] == double.maxFinite.toInt() ? -1 : dp[k + 1][dst];
  }
}
```

## Solution - 2

```dart
import 'dart:collection';

class Solution {
  int findCheapestPrice(
      int n, List<List<int>> flights, int src, int dst, int k) {
    // Build graph
    // node -> [[neighbor,distance]]
    HashMap<int, List<List<int>>> graph = HashMap();
    for (int i = 0; i < n; i++) graph[i] = [];

    for (List<int> flight in flights) {
      int u = flight[0];
      int v = flight[1];
      int w = flight[0];

      graph[u]?.add([v, w]);
    }

    // List<int> -> [node, distance, moves] for every index
    Queue<List<int>> pq = Queue()..toList().sort((a, b) => a[1] - b[1]);

    List<int> distance = List.filled(n, -1);

    List<int> maxMovesUpToNode = List.filled(n, double.maxFinite.toInt());

    // Initial mark
    distance[src] = 0;
    pq.add([src, 0, 0]);

    // Run Relaxation Algorithm
    while (pq.isNotEmpty) {
      List<int> element = pq.removeFirst();
      int node = element[0];
      int dis = element[1];
      int moves = element[2];

      if (maxMovesUpToNode[node] < moves) continue;
      maxMovesUpToNode[node] = moves;

      for (List<int> edge in graph[node] ?? []) {
        int neighbor = edge[0], weight = edge[1];

        int neighborNewDistance = weight + dis;
        if (distance[neighbor] == -1 ||
            neighborNewDistance < distance[neighbor]) {
          distance[neighbor] = neighborNewDistance;
        }
        // If we have moves left.
        if (k != moves) {
          pq.add([neighbor, neighborNewDistance, moves + 1]);
        }
      }
    }

    return distance[dst];
  }
}
```
