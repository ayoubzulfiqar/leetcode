/*



-*  2421. Number of Good Paths *-


There is a tree (i.e. a connected, undirected graph with no cycles) consisting of n nodes numbered from 0 to n - 1 and exactly n - 1 edges.

You are given a 0-indexed integer array vals of length n where vals[i] denotes the value of the ith node. You are also given a 2D integer array edges where edges[i] = [ai, bi] denotes that there exists an undirected edge connecting nodes ai and bi.

A good path is a simple path that satisfies the following conditions:

The starting node and the ending node have the same value.
All nodes between the starting node and the ending node have values less than or equal to the starting node (i.e. the starting node's value should be the maximum value along the path).
Return the number of distinct good paths.

Note that a path and its reverse are counted as the same path. For example, 0 -> 1 is considered to be the same as 1 -> 0. A single node is also considered as a valid path.

 

Example 1:


Input: vals = [1,3,2,1,3], edges = [[0,1],[0,2],[2,3],[2,4]]
Output: 6
Explanation: There are 5 good paths consisting of a single node.
There is 1 additional good path: 1 -> 0 -> 2 -> 4.
(The reverse path 4 -> 2 -> 0 -> 1 is treated as the same as 1 -> 0 -> 2 -> 4.)
Note that 0 -> 2 -> 3 is not a good path because vals[2] > vals[0].
Example 2:


Input: vals = [1,1,2,2,3], edges = [[0,1],[1,2],[2,3],[2,4]]
Output: 7
Explanation: There are 5 good paths consisting of a single node.
There are 2 additional good paths: 0 -> 1 and 2 -> 3.
Example 3:


Input: vals = [1], edges = []
Output: 1
Explanation: The tree consists of only one node, so there is one good path.
 

Constraints:

n == vals.length
1 <= n <= 3 * 104
0 <= vals[i] <= 105
edges.length == n - 1
edges[i].length == 2
0 <= ai, bi < n
ai != bi
edges represents a valid tree.

*/

import 'dart:math';

class A {
  late List<int> root;
  late List<int> cnt;
  int get(int x) {
    return x == root[x] ? x : (root[x] = get(root[x]));
  }

  int numberOfGoodPaths(List<int> vals, List<List<int>> edges) {
    // each node is a good path
    int n = vals.length, ans = n;
    cnt = List.filled(n, 0);
    root = List.filled(n, 0);
    // each element is in its own group initially
    for (int i = 0; i < n; i++) {
      root[i] = i;
      cnt[i] = 1;
    }
    // sort by vals
    List<List<int>> edgesList = [];
    for (int i = 0; i < edges.length; i++) edgesList.add(edges[i]);
    // Collections.sort(edgesList, new Comparator<int[]>() {
    //       int compare(int[] x, int[] y) {
    //         int a = Math.max(vals[x[0]], vals[x[1]]);
    //         int b = Math.max(vals[y[0]], vals[y[1]]);
    //         if(a < b) return -1;
    //         else if(a > b) return 1;
    //         else return 0;
    //     }
    // });

    edgesList.sort((List<int> x, List<int> y) {
      int a = max(vals[x[0]], vals[x[1]]);
      int b = max(vals[y[0]], vals[y[1]]);
      if (a < b)
        return -1;
      else if (a > b)
        return 1;
      else
        return 0;
    });

    // iterate each edge
    for (List<int> e in edgesList) {
      int x = e[0], y = e[1];
      // get the root of x
      x = get(x);
      // get the root of y
      y = get(y);
      // if their vals are same,
      if (vals[x] == vals[y]) {
        // then there would be cnt[x] * cnt[y] good paths
        ans += cnt[x] * cnt[y];
        // unite them
        root[x] = y;
        // add the count of x to that of y
        cnt[y] += cnt[x];
      } else if (vals[x] > vals[y]) {
        // unite them
        root[y] = x;
      } else {
        // unite them
        root[x] = y;
      }
    }
    return ans;
  }
}

class B {
  List<int> parents = [];
  int find(int x) {
    if (x != parents[x]) parents[x] = find(parents[x]);
    return parents[x];
  }

  int numberOfGoodPaths(List<int> vals, List<List<int>> edges) {
    int n = vals.length;
    if (n == 1) return 1;
    // 1. init union find and ids arrayList
    parents = List.filled(n, 0);
    List<int> ids = [];
    for (int i = 0; i < n; i++) {
      parents[i] = i;
      ids.add(i);
    }

    // build Graph
    Map<int, Set<int>> graph = Map();

    for (List<int> edge in edges) {
      int u = edge[0];
      int v = edge[1];

      graph.putIfAbsent(u, () => Set<int>());
      graph.putIfAbsent(v, () => Set<int>());

      graph[v]?.add(u);
      graph[u]?.add(v);
    }

    // 2. sort the ids by vals
    // Collections.sort(ids, (a, b) -> (vals[a] - vals[b]));
    ids.sort((a, b) => vals[a] - vals[b]);

    // 3. iterate from smallest to biggest
    int ret = 0;
    for (int i = 0; i < n; i++) {
      // get all same vals of node ids[i, j)
      int j = i + 1;
      while (j < n && vals[ids[j]] == vals[ids[i]]) j++;

      // enum each same val
      for (int k = i; k < j; k++) {
        int x = ids[k];
        // traverse neighbor, if small than current node
        for (int neighbor in graph[x] ?? []) {
          if (vals[x] >= vals[neighbor]) {
            // union node x and its smaller neighbor
            parents[find(x)] = find(neighbor);
          }
        }
      }
      // checkout for current values, the # of val in each component
      Map<int, int> temp = Map();
      for (int k = i; k < j; k++) {
        int root = find(ids[k]);
        temp[root] =
            (temp[root] ?? 0) + 1; // # of current val in the {root} group
      }
      // standalone nodes are included. Note C(n, 2) + n = C(n + 1, 2)
      for (int v in temp.values) {
        ret += v * (v + 1) ~/ 2;
      }

      i = j - 1;
    }

    return ret;
  }
}

class C {
  int numberOfGoodPaths(List<int> vals, List<List<int>> edges) {
    int n = vals.length;
    int sum = n;

    // create adjacency list
    List<List<int>> adjList = [];

    // create sortedmap with key as node value and value as list of index
    Map<int, List<int>> tm = Map();

    // create unionfind
    UnionFind uf = UnionFind(n);

    for (int i = 0; i < n; i++) {
      //O(N)
      adjList.add([]);
      if (!tm.containsKey(vals[i])) {
        tm[vals[i]] = [];
      }
      tm[vals[i]]?.add(i);
    }
    for (List<int> edge in edges) {
      //O(N)
      adjList[edge[0]].add(edge[1]);
      adjList[edge[1]].add(edge[0]);
    }

    // traverse node values from lowest to highest
    MapEntry<int, List<int>> curr = tm.entries.first;
    while (curr != null) {
      List<int> listNodes = curr.value;

      // for each node union with neighbor if neighbor value is
      // lower or equal to node value
      for (int node in listNodes) {
        List<int> neighbors = adjList[node];
        for (int neighbor in neighbors) {
          if (vals[node] >= vals[neighbor]) {
            uf.merge(node, neighbor);
          }
        }
      }

      // check if each node is in union with other node with
      // same value
      if (listNodes.length > 1) {
        Map<int, int> freq = Map();

        // create frequency map of parent, to count number of nodes of same value in each set
        for (int i = 0; i < listNodes.length; i++) {
          int parent = uf.find(listNodes[i]);
          freq[parent] = (freq[parent] ?? 0) + 1;
        }

        // apply arithmetic progression formula to find sum of good paths
        for (int parentKey in freq.keys) {
          int frequency = freq[parentKey]! - 1;
          sum += (frequency * (frequency + 1)) ~/ 2;
        }
      }

      curr = tm.entries.elementAt(curr.key);
    }
    return sum;
  }
}

class UnionFind {
  late List<int> dp;
  late List<int> rank;

  UnionFind(int n) {
    dp = List.filled(n, 0);
    rank = List.filled(n, 0);
    for (int i = 0; i < n; i++) {
      dp[i] = i;
      rank[i] = 1;
    }
  }

  int find(int i) {
    if (dp[i] == i) {
      return i;
    }
    dp[i] = find(dp[i]);
    return dp[i];
  }

  bool isSameSet(int x, int y) {
    return find(x) == find(y);
  }

  void merge(int x, int y) {
    if (isSameSet(x, y)) {
      return;
    }
    int xp = find(x);
    int yp = find(y);

    if (rank[xp] < rank[yp]) {
      dp[xp] = yp;
    } else {
      dp[yp] = dp[xp];
      if (rank[xp] == rank[yp]) {
        rank[xp]++;
      }
    }
  }
}
