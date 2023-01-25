/*



-* 2359. Find Closest Node to Given Two Nodes *-

You are given a directed graph of n nodes numbered from 0 to n - 1, where each node has at most one outgoing edge.

The graph is represented with a given 0-indexed array edges of size n, indicating that there is a directed edge from node i to node edges[i]. If there is no outgoing edge from i, then edges[i] == -1.

You are also given two integers node1 and node2.

Return the index of the node that can be reached from both node1 and node2, such that the maximum between the distance from node1 to that node, and from node2 to that node is minimized. If there are multiple answers, return the node with the smallest index, and if no possible answer exists, return -1.

Note that edges may contain cycles.

 

Example 1:


Input: edges = [2,2,3,-1], node1 = 0, node2 = 1
Output: 2
Explanation: The distance from node 0 to node 2 is 1, and the distance from node 1 to node 2 is 1.
The maximum of those two distances is 1. It can be proven that we cannot get a node with a smaller maximum distance than 1, so we return node 2.
Example 2:


Input: edges = [1,2,-1], node1 = 0, node2 = 2
Output: 2
Explanation: The distance from node 0 to node 2 is 2, and the distance from node 2 to itself is 0.
The maximum of those two distances is 2. It can be proven that we cannot get a node with a smaller maximum distance than 2, so we return node 2.
 

Constraints:

n == edges.length
2 <= n <= 105
-1 <= edges[i] < n
edges[i] != i
0 <= node1, node2 < n


*/
import 'dart:math';

class A {
  int closestMeetingNode(List<int> edges, int node1, int node2) {
    int n = edges.length;
    int ans = -1;
    int minDist = 10000;
    List<int> dist1 = List.filled(n, 0);
    List<int> dist2 = List.filled(n, 0);
    List<bool> visited1 = List.filled(n, false);
    List<bool> visited2 = List.filled(n, false);
    dfs(node1, edges, dist1, visited1);
    dfs(node2, edges, dist2, visited2);

    for (int currentNode = 0; currentNode < n; currentNode++) {
      if (visited1[currentNode] &&
          visited2[currentNode] &&
          minDist > max(dist1[currentNode], dist2[currentNode])) {
        minDist = max(dist1[currentNode], dist2[currentNode]);
        ans = currentNode;
      }
    }
    return ans;
  }

  void dfs(int node, List<int> edges, List<int> distance, List<bool> visited) {
    visited[node] = true;
    int neighbor = edges[node];
    if (neighbor != -1 && !visited[neighbor]) {
      distance[neighbor] = distance[node] + 1;
      dfs(neighbor, edges, distance, visited);
    }
  }
}

class B {
  List<int> getDistanceArray(List<int> edges, int node) {
    List<int> distanceArray = List.filled(edges.length, -1);

    int distance = 0;
    while (node != -1 && distanceArray[node] == -1) {
      distanceArray[node] = distance++;
      node = edges[node];
    }
    return distanceArray;
  }

  int closestMeetingNode(List<int> edges, int node1, int node2) {
    List<int> distanceArray1 = getDistanceArray(edges, node1);
    List<int> distanceArray2 = getDistanceArray(edges, node2);

    int minDistance = 10000;
    int result = -1;

    for (int i = 0; i < edges.length; i++) {
      if (distanceArray1[i] == -1 || distanceArray2[i] == -1) continue;

      int distance = max(distanceArray1[i], distanceArray2[i]);
      if (distance < minDistance) {
        result = i;
        minDistance = distance;
      }
    }
    return result;
  }
}
