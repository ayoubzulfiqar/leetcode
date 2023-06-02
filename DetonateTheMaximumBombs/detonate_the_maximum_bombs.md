# 🔥 3 Approaches 🔥 || Simple Fast and Easy || with Explanation

## Solution - 1 Depth First Search

## Explanation

- The maximumDetonation function takes a list of lists (bombs) as input, where each inner list represents the coordinates and radius of a bomb. It returns the maximum number of bombs that can be detonated.

- The function initializes some variables: n to store the number of bombs, maxBombs to keep track of the maximum number of bombs that can be detonated, and a graph object (implemented as a HashMap) to represent the adjacency list of the graph.

- The code then proceeds to build the graph. It iterates through each bomb in the bombs list using nested for loops. For each pair of bombs, it calculates the distance between them using the Euclidean distance formula. If the square of the radius of the first bomb is greater than or equal to the square of the distance between the bombs, it means that the first bomb can detonate the second bomb. In this case, it adds an edge from the first bomb to the second bomb in the graph by adding the second bomb's index to the list of neighbors of the first bomb.

- After constructing the graph, the code performs a depth-first search (DFS) on each bomb in the graph to find the connected component it belongs to. It keeps track of the visited nodes using a HashSet. For each unvisited bomb, it performs a DFS starting from that bomb and marks all the connected bombs as visited. The size of the visited set represents the number of bombs that can be detonated starting from the current bomb. The code keeps track of the maximum number of bombs visited across all iterations.

### Time Complexity

Building the graph takes O(n^2) time because of the nested for loops iterating over all pairs of bombs.
Performing the depth-first search (DFS) takes O(n + m) time, where n is the number of nodes (bombs) and m is the number of edges in the graph. In the worst case, the graph can have n*(n-1) edges, resulting in O(n^2) time complexity for the DFS.
Overall, the time complexity is dominated by the building of the graph, resulting in O(n^2) time complexity.

### Space Complexity

The graph object uses O(n) space to store the adjacency list representation of the graph.
The visited set in the DFS function uses O(n) space to store the visited nodes.
The additional space used by other variables is negligible.
Therefore, the overall space complexity is O(n).

```dart
import 'dart:collection';
import 'dart:math';

class Solution {
  int maximumDetonation(List<List<int>> bombs) {
    final int n = bombs.length;
    int maxBombs = 0;
    final HashMap<int, List<int>> graph = HashMap();

    for (int i = 0; i < n; i++) {
      for (int j = 0; j < n; j++) {
        if (i == j) {
          continue;
        }
        if (pow(bombs[i][2], 2) >=
            pow(bombs[i][0] - bombs[j][0], 2) +
                pow(bombs[i][1] - bombs[j][1], 2)) {
          List<int> neighbors = graph.putIfAbsent(i, () => <int>[]);
          neighbors.add(j);
        }
      }
    }

    for (int i = 0; i < n; i++) {
      final HashSet<int> visited = HashSet();
      visited.add(i);
      depthFirstSearch(i, visited, graph);
      maxBombs = max(maxBombs, visited.length);
    }

    return maxBombs;
  }

  void depthFirstSearch(int node, Set<int> visited, Map<int, List<int>> graph) {
    final List<int> neighbors = graph[node] ?? <int>[];
    for (int child in neighbors) {
      if (!visited.contains(child)) {
        visited.add(child);
        depthFirstSearch(child, visited, graph);
      }
    }
  }
}
```

## Solution - 2 Breath First Search

## Explanation

- The maximumDetonation function takes a list of lists (bombs) as input, where each inner list represents the coordinates and radius of a bomb. It returns the maximum number of bombs that can be detonated.

- The code initializes a graph object (implemented as a HashMap) to represent the adjacency list of the graph. It also gets the length of the bombs list and assigns it to the variable n.

- The code then proceeds to build the graph using nested for loops. For each pair of bombs, it calculates the distance between them using the Euclidean distance formula. If the square of the radius of the first bomb is greater than or equal to the square of the distance between the bombs, it means that the first bomb can detonate the second bomb. In this case, it adds an edge from the first bomb to the second bomb in the graph by adding the second bomb's index to the list of neighbors of the first bomb.

- After constructing the graph, the code performs a breadth-first search (BFS) on each bomb in the graph to find the connected component it belongs to. It keeps track of the visited nodes using a HashSet and uses a Queue to perform the BFS. For each unvisited bomb, it performs a BFS starting from that bomb and marks all the connected bombs as visited. The size of the visited set represents the number of bombs that can be detonated starting from the current bomb. The code keeps track of the maximum number of bombs visited across all iterations.

### Time Complexity:

Building the graph takes O(n^2) time because of the nested for loops iterating over all pairs of bombs.
Performing the breadth-first search (BFS) takes O(n + m) time, where n is the number of nodes (bombs) and m is the number of edges in the graph. In the worst case, the graph can have n*(n-1) edges, resulting in O(n^2) time complexity for the BFS.
Overall, the time complexity is dominated by the building of the graph, resulting in O(n^2) time complexity.

### Space Complexity:

The graph object uses O(n) space to store the adjacency list representation of the graph.
The visited set and the queue in the BFS function use O(n) space to store the visited nodes and the nodes in the queue, respectively.
The additional space used by other variables is negligible.
Therefore, the overall space complexity is O(n).

```dart
import 'dart:collection';
import 'dart:math';

class Solution {
  int maximumDetonation(List<List<int>> bombs) {
    final HashMap<int, List<int>> graph = HashMap<int, List<int>>();

    final int n = bombs.length;

    // Build the graph
    for (int i = 0; i < n; i++) {
      for (int j = 0; j < n; j++) {
        int xi = bombs[i][0], yi = bombs[i][1], ri = bombs[i][2];
        int xj = bombs[j][0], yj = bombs[j][1];

        // Create a path from node i to node j, if bomb i detonates bomb j.
        if ((ri * ri) >= ((xi - xj) * (xi - xj) + (yi - yj) * (yi - yj))) {
          graph.putIfAbsent(i, () => <int>[]).add(j);
        }
      }
    }

    int answer = 0;
    for (int i = 0; i < n; i++) {
      answer = max(answer, breathFirstSearch(i, graph));
    }

    return answer;
  }

  int breathFirstSearch(int i, Map<int, List<int>> graph) {
    final Queue<int> queue = Queue<int>();
    final HashSet<int> visited = HashSet<int>();

    queue.add(i);
    visited.add(i);

    while (queue.isNotEmpty) {
      int current = queue.removeFirst();
      for (int neighbors in graph[current] ?? []) {
        if (!visited.contains(neighbors)) {
          visited.add(neighbors);
          queue.add(neighbors);
        }
      }
    }

    return visited.length;
  }
}
```

### Solution - Union Find - Failed

```dart

import 'dart:collection';

class Union {
  late final List<int> root;
  late final List<int> rank;
  late int count;

  Union(int n) {
    root = List<int>.generate(n, (i) => i);
    rank = List<int>.filled(n, 1);
    count = n;
  }

  void union(int x, int y) {
    int rootX = find(x);
    int rootY = find(y);
    if (rootX != rootY) {
      if (rank[x] > rank[y]) {
        root[rootY] = rootX;
      } else if (rank[x] < rank[y]) {
        root[rootX] = rootY;
      } else {
        root[rootY] = rootX;
        rank[rootX] += 1;
      }
      count -= 1;
    }
  }

  int find(int x) {
    if (root[x] == x) {
      return x;
    }
    root[x] = find(root[x]);
    return root[x];
  }
}

class B {
  int maximumDetonation(List<List<int>> bombs) {
    final int l = bombs.length;
    final Union u = Union(l);

    double distance(List<int> p1, List<int> p2) {
      return sqrt(pow(p1[0] - p2[0], 2) + pow(p1[1] - p2[1], 2));
    }

    for (int i = 0; i < l; i++) {
      for (int j = 0; j < l; j++) {
        double di = distance(bombs[i], bombs[j]);
        if (bombs[i][2] >= di || bombs[j][2] >= di) {
          u.union(i, j);
        }
      }
    }

    HashMap<int, int> mapping = HashMap<int, int>();
    for (int i in u.root) {
      mapping[i] = (mapping[i] ?? 0) + 1;
    }
    return mapping.values.reduce((max, value) => max > value ? max : value);
  }
}
```
