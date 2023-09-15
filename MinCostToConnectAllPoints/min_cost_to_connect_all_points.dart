/* 


-* 1584. Min Cost to Connect All Points *-


 You are given an array points representing integer coordinates of some points on a 2D-plane, where points[i] = [xi, yi].

The cost of connecting two points [xi, yi] and [xj, yj] is the manhattan distance between them: |xi - xj| + |yi - yj|, where |val| denotes the absolute value of val.

Return the minimum cost to make all points connected. All points are connected if there is exactly one simple path between any two points.

 

Example 1:


Input: points = [[0,0],[2,2],[3,10],[5,2],[7,0]]
Output: 20
Explanation: 

We can connect the points as shown above to get the minimum cost of 20.
Notice that there is a unique path between every pair of points.
Example 2:

Input: points = [[3,12],[-2,5],[-4,1]]
Output: 18
 

Constraints:

1 <= points.length <= 1000
-106 <= xi, yi <= 106
All pairs (xi, yi) are distinct.


*/

class Solution {
  // Function to find the index of the minimum key in 'key' list that is not yet included in MST
  int minKey(List<bool> inMST, List<int> key) {
    int minIndex = 0;
    int minVal = 4000001; // Use 'max-Value'
    // Loop through all vertices to find the minimum key
    for (int i = 0; i < key.length; i++) {
      // Check if the vertex is not in MST and its key is smaller than the current minimum value
      if (!inMST[i] && key[i] < minVal) {
        minIndex = i;
        minVal = key[i];
      }
    }
    return minIndex; // Return the index of the minimum key
  }

  // Function to calculate the minimum spanning tree (MST) of a given 'graph' with 'V' vertices
  int minimumSpanningTree(List<List<int>> graph, int V) {
    final List<int> key = List<int>.filled(
        V, 4000001); // Initialize key values for all vertices to be infinity
    final List<bool> inMST = List<bool>.filled(
        V, false); // Initialize all vertices as not included in MST
    key[0] = 0; // Start with the first vertex as the source

    // Loop through V-1 vertices (all except the first one)
    for (int count = 1; count <= V - 1; count++) {
      final int u =
          minKey(inMST, key); // Find the vertex with the minimum key not in MST
      inMST[u] = true; // Include the selected vertex in MST

      // Update the key values of adjacent vertices
      for (int v = 0; v < V; v++) {
        // If there is an edge from 'u' to 'v', 'v' is not in MST, and the edge weight is smaller than 'key[v]'
        if (graph[u][v] != 0 && !inMST[v] && graph[u][v] < key[v]) {
          key[v] = graph[u][v]; // Update the key value of 'v'
        }
      }
    }

    int cost = 0;
    for (int i in key) {
      cost +=
          i; // Calculate the sum of key values, which represents the minimum cost of MST
    }
    return cost; // Return the minimum cost of MST
  }

  // Function to calculate the minimum cost to connect all points using Prim's Algorithm
  int minCostConnectPoints(List<List<int>> points) {
    final int n = points.length;
    final List<List<int>> graph = List.generate(
      n,
      (i) => List<int>.filled(n, 0),
    ); // Create a 2D matrix 'graph' to represent the distances between points

    // Calculate the Manhattan distance (md) between all pairs of points and populate the 'graph' matrix
    for (int i = 0; i < n - 1; i++) {
      for (int j = i + 1; j < n; j++) {
        final List<int> p1 = points[i];
        final List<int> p2 = points[j];
        int md = (p1[0] - p2[0]).abs() +
            (p1[1] - p2[1]).abs(); // Calculate Manhattan distance
        graph[i][j] =
            md; // Store the distance in both directions since it's an undirected graph
        graph[j][i] = md;
      }
    }

    return minimumSpanningTree(graph,
        n); // Find and return the minimum cost of connecting all points using MST
  }
}



class A {
late  List<int> parent;
late  List<int> rank;

  int find(int x) {
    if (x == parent[x]) return x;
    return parent[x] = find(parent[x]);
  }

  void union(int x, int y) {
    int xParent = find(x);
    int yParent = find(y);

    if (xParent == yParent) return;

    if (rank[xParent] > rank[yParent]) {
      parent[yParent] = xParent;
    } else if (rank[xParent] < rank[yParent]) {
      parent[xParent] = yParent;
    } else {
      parent[xParent] = yParent;
      rank[yParent]++;
    }
  }

  int kruskal(List<List<int>> vec) {
    int sum = 0;
    for (var temp in vec) {
      int u = temp[0];
      int v = temp[1];
      int wt = temp[2];

      int parentU = find(u);
      int parentV = find(v);

      if (parentU != parentV) {
        union(u, v);
        sum += wt;
      }
    }

    return sum;
  }

  int minCostConnectPoints(List<List<int>> points) {
    int V = points.length;
    parent = List<int>.generate(V, (i) => i);
    rank = List<int>.filled(V, 0);

    List<List<int>> vec = [];

    for (int i = 0; i < V; i++) {
      for (int j = i + 1; j < V; j++) {
        int x1 = points[i][0];
        int y1 = points[i][1];

        int x2 = points[j][0];
        int y2 = points[j][1];

        int d = (x1 - x2).abs() + (y1 - y2).abs();

        vec.add([i, j, d]);
      }
    }

    vec.sort((v1, v2) => v1[2].compareTo(v2[2]));

    return kruskal(vec);
  }
}
