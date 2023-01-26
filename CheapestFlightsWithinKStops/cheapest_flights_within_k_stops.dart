/*


-* 787. Cheapest Flights Within K Stops *-


There are n cities connected by some number of flights. You are given an array flights where flights[i] = [fromi, toi, pricei] indicates that there is a flight from city fromi to city toi with cost pricei.

You are also given three integers src, dst, and k, return the cheapest price from src to dst with at most k stops. If there is no such route, return -1.

 

Example 1:


Input: n = 4, flights = [[0,1,100],[1,2,100],[2,0,100],[1,3,600],[2,3,200]], src = 0, dst = 3, k = 1
Output: 700
Explanation:
The graph is shown above.
The optimal path with at most 1 stop from city 0 to 3 is marked in red and has cost 100 + 600 = 700.
Note that the path through cities [0,1,2,3] is cheaper but is invalid because it uses 2 stops.
Example 2:


Input: n = 3, flights = [[0,1,100],[1,2,100],[0,2,500]], src = 0, dst = 2, k = 1
Output: 200
Explanation:
The graph is shown above.
The optimal path with at most 1 stop from city 0 to 2 is marked in red and has cost 100 + 100 = 200.
Example 3:


Input: n = 3, flights = [[0,1,100],[1,2,100],[0,2,500]], src = 0, dst = 2, k = 0
Output: 500
Explanation:
The graph is shown above.
The optimal path with no stops from city 0 to 2 is marked in red and has cost 500.
 

Constraints:

1 <= n <= 100
0 <= flights.length <= (n * (n - 1) / 2)
flights[i].length == 3
0 <= from-i, toi < n
from-i != toi
1 <= price-i <= 104
There will not be any multiple flights between two cities.
0 <= src, dst, k < n
src != dst


*/

import 'dart:collection';
import 'dart:math';

class A {
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

    // int[] -> [node, distance, moves] for every index
    // (a, b) -> a[1] - b[1]
    Queue<List<int>> pq = Queue()..toList().sort((a, b) => a[1] - b[1]);

    List<int> distance = List.filled(n, -1);

    List<int> maxMovesUpToNode = List.filled(n, double.maxFinite.toInt());

    // Initial mark
    distance[src] = 0;
    pq.add([src, 0, 0]);

    // Run Relaxation Algorithm
    while (pq.isNotEmpty) {
      // poll remove First
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

class B {
  int findCheapestPrice(
      int n, List<List<int>> flights, int src, int dst, int k) {
    // dp[i][j]: min cost to reach city j using at most i edges from src
    List<List<int>> dp = List.filled(k + 2, 0)
        .map((e) => List.filled(n, double.maxFinite.toInt()))
        .toList();

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
    // if dp[k + 1][dst] == INT_MAX, it means it is unreachable
    // else return the cost
    return dp[k + 1][dst] == double.maxFinite.toInt() ? -1 : dp[k + 1][dst];
  }
}
