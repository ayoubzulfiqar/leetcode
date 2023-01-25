# 🔥 100% FAST 🔥 || Simple Fast and Easy || with Explanation

## Solution - Depth First Search

## Approach

Traverse the graph from 'node1' and 'node2' to get the distance of each connected node, respectively in separate integer array.

Then, find and return the node that is with the minimum max distance from 'node1' and 'node2'.

## Complexity

### Time complexity: O(n)

where 'n' is the number of nodes in the graph.
We traverse the graph from 'node1' and 'node2' once, with the worst-case of traversing the whole graph.
Additionally, we check every node for their distance to 'node1' and 'node2'.

### Space complexity: O(n)

where 'n' is the number of nodes in the graph.
We created two arrays of size 'n' to record the distance of each node from 'node1' and 'node2' respectively.

```dart
class Solution {
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
```
