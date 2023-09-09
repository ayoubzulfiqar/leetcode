/*

-* 1489. Find Critical and Pseudo-Critical Edges in Minimum Spanning Tree *-


Given a weighted undirected connected graph with n vertices numbered from 0 to n - 1, and an array edges where edges[i] = [ai, bi, weighti] represents a bidirectional and weighted edge between nodes ai and bi. A minimum spanning tree (MST) is a subset of the graph's edges that connects all vertices without cycles and with the minimum possible total edge weight.

Find all the critical and pseudo-critical edges in the given graph's minimum spanning tree (MST). An MST edge whose deletion from the graph would cause the MST weight to increase is called a critical edge. On the other hand, a pseudo-critical edge is that which can appear in some MSTs but not all.

Note that you can return the indices of the edges in any order.

 

Example 1:



Input: n = 5, edges = [[0,1,1],[1,2,1],[2,3,2],[0,3,2],[0,4,3],[3,4,3],[1,4,6]]
Output: [[0,1],[2,3,4,5]]
Explanation: The figure above describes the graph.
The following figure shows all the possible MSTs:

Notice that the two edges 0 and 1 appear in all MSTs, therefore they are critical edges, so we return them in the first list of the output.
The edges 2, 3, 4, and 5 are only part of some MSTs, therefore they are considered pseudo-critical edges. We add them to the second list of the output.
Example 2:



Input: n = 4, edges = [[0,1,1],[1,2,1],[2,3,1],[0,3,1]]
Output: [[],[0,1,2,3]]
Explanation: We can observe that since all 4 edges have equal weight, choosing any 3 edges from the given 4 will yield an MST. Therefore all 4 edges are pseudo-critical.
 

Constraints:

2 <= n <= 100
1 <= edges.length <= min(200, n * (n - 1) / 2)
edges[i].length == 3
0 <= ai < bi < n
1 <= weight-i <= 1000
All pairs (ai, bi) are distinct.


*/

class Solution {
  List<List<int>> findCriticalAndPseudoCriticalEdges(
    int n,
    List<List<int>> edges,
  ) {
    final List<List<List<int>>> graph =
        List.generate(n, (i) => List.generate(n, (j) => [0, 0]));

    for (int i = 0; i < edges.length; i++) {
      final List<int> edge = edges[i];
      final int from = edge[0];
      final int to = edge[1];
      final int weight = edge[2];
      graph[from][to][0] = weight;
      graph[to][from][0] = weight;
      graph[from][to][1] = i;
      graph[to][from][1] = i;
    }

    final List<List<int>> minimumSpanningTree =
        List.generate(n, (i) => <int>[]);

    final List<bool> mstEdgeSet = List.filled(edges.length, false);

    edges.sort((a, b) => a[2].compareTo(b[2]));

    buildMinimumSpanningTree(n, edges, mstEdgeSet, minimumSpanningTree, graph);
    final List<List<int>> result =
        List.filled(2, 0).map((e) => <int>[]).toList();

    final Set<int> pseudoCriticalEdges = Set();
    final List<int> criticalEdges = List.empty(growable: true);

    // Finding pseudo-critical edges
    for (int i = 0; i < edges.length; i++) {
      final int from = edges[i][0], to = edges[i][1];
      final int weight = edges[i][2];
      final int index = graph[from][to][1];
      if (!mstEdgeSet[index]) {
        final Set<int> currentSet = Set();
        final bool isPseudoCritical = isPath(
          from,
          to,
          weight,
          -1,
          minimumSpanningTree,
          graph,
          currentSet,
        );
        if (isPseudoCritical && currentSet.isNotEmpty) {
          pseudoCriticalEdges.addAll(currentSet);
          pseudoCriticalEdges.add(index);
        }
      }
    }

    // Finding critical edges
    for (int i = 0; i < edges.length; i++) {
      final int from = edges[i][0], to = edges[i][1];
      final int index = graph[from][to][1];
      if (mstEdgeSet[index] && !pseudoCriticalEdges.contains(index)) {
        criticalEdges.add(index);
      }
    }

    result[0] = criticalEdges;
    result[1] = pseudoCriticalEdges.toList();
    return result;
  }

  bool isPath(
      final int from,
      final int to,
      final int weight,
      final int previous,
      final List<List<int>> minimumSpanningTree,
      final List<List<List<int>>> graph,
      final Set<int> indices) {
    if (from == to) {
      return true;
    }
    for (final int neighbor in minimumSpanningTree[from]) {
      if (previous != neighbor) {
        if (isPath(
            neighbor, to, weight, from, minimumSpanningTree, graph, indices)) {
          if (graph[from][neighbor][0] == weight) {
            indices.add(graph[from][neighbor][1]);
          }
          return true;
        }
      }
    }
    return false;
  }

  void buildMinimumSpanningTree(
      final int n,
      final List<List<int>> edges,
      final List<bool> mstEdgeSet,
      final List<List<int>> minimumSpanningTree,
      final List<List<List<int>>> graph) {
    final DisjointSet ds = DisjointSet(n);
    int weight=0;

    for (int i = 0; i < edges.length; i++) {
      if (ds.union(edges[i][0], edges[i][1])) {
        weight += edges[i][2];
        final List<int> edge = edges[i];
        minimumSpanningTree[edge[0]].add(edge[1]);
        minimumSpanningTree[edge[1]].add(edge[0]);
        mstEdgeSet[graph[edge[0]][edge[1]][1]] = true;
      }
    }
  }
}

class DisjointSet {
  late final List<int> parent;

  DisjointSet(int n) {
    parent = List.generate(n, (i) => i);
  }

  int find(int i) {
    return (i == parent[i]) ? i : (parent[i] = find(parent[i]));
  }

  bool union(int u, int v) {
    final int pu = find(u);
    final int pv = find(v);
    if (pu == pv) {
      return false;
    }
    parent[pu] = pv;
    return true;
  }
}
