/*

-* 2101. Detonate the Maximum Bombs *-


You are given a list of bombs. The range of a bomb is defined as the area where its effect can be felt. This area is in the shape of a circle with the center as the location of the bomb.

The bombs are represented by a 0-indexed 2D integer array bombs where bombs[i] = [xi, yi, ri]. xi and yi denote the X-coordinate and Y-coordinate of the location of the ith bomb, whereas ri denotes the radius of its range.

You may choose to detonate a single bomb. When a bomb is detonated, it will detonate all bombs that lie in its range. These bombs will further detonate the bombs that lie in their ranges.

Given the list of bombs, return the maximum number of bombs that can be detonated if you are allowed to detonate only one bomb.

 

Example 1:


Input: bombs = [[2,1,3],[6,1,4]]
Output: 2
Explanation:
The above figure shows the positions and ranges of the 2 bombs.
If we detonate the left bomb, the right bomb will not be affected.
But if we detonate the right bomb, both bombs will be detonated.
So the maximum bombs that can be detonated is max(1, 2) = 2.
Example 2:


Input: bombs = [[1,1,5],[10,10,5]]
Output: 1
Explanation:
Detonating either bomb will not detonate the other bomb, so the maximum number of bombs that can be detonated is 1.
Example 3:


Input: bombs = [[1,2,3],[2,3,1],[3,4,2],[4,5,3],[5,6,4]]
Output: 5
Explanation:
The best bomb to detonate is bomb 0 because:
- Bomb 0 detonates bombs 1 and 2. The red circle denotes the range of bomb 0.
- Bomb 2 detonates bomb 3. The blue circle denotes the range of bomb 2.
- Bomb 3 detonates bomb 4. The green circle denotes the range of bomb 3.
Thus all 5 bombs are detonated.
 

Constraints:

1 <= bombs.length <= 100
bombs[i].length == 3
1 <= xi, yi, ri <= 105



*/
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

class A {
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

class Union {
  late final List<int> root;
  late final List<int> rank;
  late final int count;

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
