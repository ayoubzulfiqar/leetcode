# 🔥 Dart 🔥 || 4 Solutions || Simple Fast and Easy || with Explanation

## Solution - 1 HashMap Union Find

### Analysis

#### Time Complexity: $O(nlogn)$

#### Space Complexity: $O(n)$

```dart
import 'dart:collection';

class Solution {
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
    this.parents = HashMap();
    this.count = 0;
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
```

## Graph

## Solution - 2 Depth First Search

```dart
class Solution {
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
```

## Solution - 3 DSU

```dart
class Solution {
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
```

## Solution - 4 HashSet Recursive DFS

```dart
import 'dart:collection';

class Solution {
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
```
