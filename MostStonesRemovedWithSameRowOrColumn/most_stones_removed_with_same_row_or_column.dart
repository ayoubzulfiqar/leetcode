/*

-* Most Stones Removed with Same Row or Column *-

On a 2D plane, we place n stones at some integer coordinate points. Each coordinate point may have at most one stone.

A stone can be removed if it shares either the same row or the same column as another stone that has not been removed.

Given an array stones of length n where stones[i] = [xi, yi] represents the location of the ith stone, return the largest possible number of stones that can be removed.



Example 1:

Input: stones = [[0,0],[0,1],[1,0],[1,2],[2,1],[2,2]]
Output: 5
Explanation: One way to remove 5 stones is as follows:
1. Remove stone [2,2] because it shares the same row as [2,1].
2. Remove stone [2,1] because it shares the same column as [0,1].
3. Remove stone [1,2] because it shares the same row as [1,0].
4. Remove stone [1,0] because it shares the same column as [0,0].
5. Remove stone [0,1] because it shares the same row as [0,0].
Stone [0,0] cannot be removed since it does not share a row/column with another stone still on the plane.
Example 2:

Input: stones = [[0,0],[0,2],[1,1],[2,0],[2,2]]
Output: 3
Explanation: One way to make 3 moves is as follows:
1. Remove stone [2,2] because it shares the same row as [2,0].
2. Remove stone [2,0] because it shares the same column as [0,0].
3. Remove stone [0,2] because it shares the same row as [0,0].
Stones [0,0] and [1,1] cannot be removed since they do not share a row/column with another stone still on the plane.
Example 3:

Input: stones = [[0,0]]
Output: 0
Explanation: [0,0] is the only stone on the plane, so you cannot remove it.


Constraints:

1 <= stones.length <= 1000
0 <= xi, yi <= 104
No two stones are at the same coordinate point.

*/

import 'dart:collection';

// Union Find
// Runtime: 568 ms, faster than 100.00% of Dart online submissions for Most Stones Removed with Same Row or Column.
// Memory Usage: 151.2 MB, less than 100.00% of Dart online submissions for Most Stones Removed with Same Row or Column.
class A {
  //Analysis
// Time Complexity: $O(nlogn)$.
// Space Complexity: $O(n)$.
  int removeStones(List<List<int>> stones) {
    if (stones.isEmpty || stones.length <= 1) {
      return 0;
    }

    int n = stones.length;

    UnionFind uf = UnionFind();
    for (List<int> edge in stones) {
      uf.union(edge[0] + 10001, edge[1]);
    }

    return n - uf.getCount();
  }
}

class UnionFind {
  late HashMap<int, int> parents;
  late int count;

  UnionFind() {
    parents = HashMap();
    count = 0;
  }

  int getCount() {
    return count;
  }

  int find(int x) {
    if (!parents.containsKey(x)) {
      parents[x] = x;
      count++;
    }

    if (x != parents[x]) {
      parents[x] = find(parents[x]!);
    }

    return parents[x]!;
  }

  void union(int x, int y) {
    int rootX = find(x);
    int rootY = find(y);
    if (rootX == rootY) {
      return;
    }

    parents[rootX] = rootY;
    count--;
  }
}

// DFS
class B {
  int removeStones(List<List<int>> stones) {
    int n = stones.length;
    List<bool> visited = List.filled(n, false);
    int componentCount = 0;
    for (int i = 0; i < n; i++) {
      if (visited[i]) continue;
      dfs(stones, visited, i);
      componentCount++;
    }
    return (n - componentCount);
  }

  bool isValid(List<int> pos1, List<int> pos2) {
    if (pos1[0] == pos2[0]) return true;
    if (pos1[1] == pos2[1]) return true;
    return false;
  }

  void dfs(List<List<int>> stones, List<bool> visited, int currentIdx) {
    visited[currentIdx] = true;
    for (int i = 0; i < stones.length; i++) {
      if (visited[i]) continue;
      if (isValid(stones[i], stones[currentIdx])) dfs(stones, visited, i);
    }
  }
}

class C {
  int removeStones(List<List<int>> stones) {
    int n = stones.length;
    List<int> parent = [n];
    for (int i = 0; i < n; i++) parent[i] = i;
    //==============================================
    int componentCount = n; //assuming "n" independent components at start
    for (int i = 0; i < n; i++) {
      for (int j = i; j < n; j++) {
        if (isValid(stones[i], stones[j])) merge(parent, componentCount, i, j);
      }
    }
    //===============================================
    return (n - componentCount);
  }

  bool isValid(List<int> pos1, List<int> pos2) {
    if (pos1[0] == pos2[0]) return true;
    if (pos1[1] == pos2[1]) return true;
    return false;
  }

  int findParent(List<int> parent, int node) {
    while (parent[node] != node) {
      node = parent[node];
    }
    return node;
  }

  void merge(List<int> parent, int componentCount, int node1, int node2) {
    int parent1 = findParent(parent, node1);
    int parent2 = findParent(parent, node2);
    if (parent1 != parent2) {
      componentCount--; //whenever we merge two components, totalComponentCount decrease by 1
      parent[parent1] =
          parent2; //or parent[parent2] = parent1 would also work :)
    }
  }
}

class D {
  int removeStones(List<List<int>> stones) {
    HashSet<List<int>> visited = HashSet();
    int numOfIslands = 0;
    for (List<int> s1 in stones) {
      if (!visited.contains(s1)) {
        dfs(s1, visited, stones);
        numOfIslands++;
      }
    }
    return stones.length - numOfIslands;
  }

  void dfs(List<int> s1, Set<List<int>> visited, List<List<int>> stones) {
    visited.add(s1);
    for (List<int> s2 in stones) {
      if (!visited.contains(s2)) {
        // stone with same row or column. group them into island
        if (s1[0] == s2[0] || s1[1] == s2[1]) dfs(s2, visited, stones);
      }
    }
  }
}
