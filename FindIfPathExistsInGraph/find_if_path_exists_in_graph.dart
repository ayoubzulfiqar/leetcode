/*
  
-*1971. Find if Path Exists in Graph *-


There is a bi-directional graph with n vertices, where each vertex is labeled from 0 to n - 1 (inclusive). The edges in the graph are represented as a 2D integer array edges, where each edges[i] = [ui, vi] denotes a bi-directional edge between vertex ui and vertex vi. Every vertex pair is connected by at most one edge, and no vertex has an edge to itself.

You want to determine if there is a valid path that exists from vertex source to vertex destination.

Given edges and the integers n, source, and destination, return true if there is a valid path from source to destination, or false otherwise.

 

Example 1:


Input: n = 3, edges = [[0,1],[1,2],[2,0]], source = 0, destination = 2
Output: true
Explanation: There are two paths from vertex 0 to vertex 2:
- 0 → 1 → 2
- 0 → 2
Example 2:


Input: n = 6, edges = [[0,1],[0,2],[3,5],[5,4],[4,3]], source = 0, destination = 5
Output: false
Explanation: There is no path from vertex 0 to vertex 5.
 

Constraints:

1 <= n <= 2 * 105
0 <= edges.length <= 2 * 105
edges[i].length == 2
0 <= ui, vi <= n - 1
ui != vi
0 <= source, destination <= n - 1
There are no duplicate edges.
There are no self edges.


*/

import 'dart:collection';

class A {
  bool found = false;
  void dfs(Map<int, List<int>> graph, List<bool> visited, int start, int end) {
    if (visited[start] || found) return;
    visited[start] = true;
    //when we found and neighbor which is equal to end point inside the recursion, voooleeey! break and return the true
    for (int nei in graph[start] ?? []) {
      if (nei == end) {
        found = true;
        break;
      }
      if (!visited[nei])
        dfs(graph, visited, nei, end); //otherwise deep dig again!
    }
  }

  bool validPath(int n, List<List<int>> edges, int source, int destination) {
    if (source == destination) return true;

    HashMap<int, List<int>> graph = HashMap();
    List<bool> visited = List.filled(n, false);

    for (int i = 0; i < n; i++) graph[i] = [];
    //construct graph, add bidirectional vertex
    for (List<int> edge in edges) {
      graph[edge[0]]?.add(edge[1]);
      graph[edge[1]]?.add(edge[0]);
    }
    //start dfs from start point
    dfs(graph, visited, source, destination);
    return found;
  }
}

class B {
  List<int> parent = [];
  int findParent(int node) {
    return parent[node] == node
        ? node
        : (parent[node] = findParent(parent[node]));
  }

  void makeSameGroup(int u, int v) {
    int pu = findParent(u);
    int pv = findParent(v);
    parent[pu] = pv;
  }

  bool validPath(int n, List<List<int>> edges, int source, int destination) {
    // resizing an array
    parent = List.filled(n, 0);
    for (int i = 0; i < n; i++) parent[i] = i;

    for (List<int> e in edges) {
      makeSameGroup(e[0], e[1]);
    }
    return findParent(source) == findParent(destination);
  }
}





//==========================

// class Solution {
//   bool validPath(int n, List<List<int>> edges, int source, int destination) {
//     UnionFind uf = UnionFind(n);
//     for (List<int> edge in edges) {
//       // connect two node
//       uf.union(edge[0], edge[1]);
//     }

//     return uf.find(source, destination);
//   }
// }

// class UnionFind {
//   // parent of node
//   late final List<int> parent;
//   // rank of disjoint set
//   late final List<int> rank;
//   // number of disjoint set
//   late int count;

//   UnionFind(int n) {
//     count = n;
//     parent = List.filled(n, 0);
//     rank = List.filled(n, 0);
//     for (int i = 0; i < n; i++) {
//       // every node is itself
//       parent[i] = i;
//       // every node init rank is one
//       rank[i] = 1;
//     }
//   }

//   int root(int p) {
//     while (parent[p] != p) {
//       // compress path
//       parent[p] = parent[parent[p]];
//       p = parent[p];
//     }

//     return p;
//   }

//   int counting() {
//     return count;
//   }

//   bool find(int p, int q) {
//     return root(p) == root(q);
//   }

//   bool union(int p, int q) {
//     int rootP = root(p);
//     int rootQ = root(q);
//     if (rootP == rootQ) {
//       return false;
//     }

//     if (rank[rootP] < rank[rootQ]) {
//       parent[rootP] = rootQ;
//       rank[rootQ] += rank[rootP];
//     } else {
//       parent[rootQ] = rootP;
//       rank[rootP] += rank[rootQ];
//     }

//     count--;

//     return true;
//   }
// }
