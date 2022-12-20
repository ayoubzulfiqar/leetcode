# 🔥 Keys and Rooms 🔥 || 3 Approaches || Simple Fast and Easy || with Explanation

## Idea

Since we can only enter rooms to which we have found a key, we can't just iterate through the entire input array (R) normally. If we think of this like a graph problem, we can see that the rooms are like nodes and the keys are like edges.

In that case, we can use a breadth-first search (BFS) queue or a depth-first search (DFS) stack approach, or even a DFS recursion approach here to good effect. Here, we'll push newly found keys onto stack as we go through.

To eliminate duplicate stack entries, we can use a lightweight boolean array (vis) to keep track of which rooms have already been pushed onto the stack. Rather than having to count the number of visited rooms again at the end, we can just use another variable (count) to keep track of that separately.

Once our stack runs empty, we can just check to see if the count is the same as the length of R and return the answer.

## Solution - 1

```dart
class Solution {
  bool canVisitAllRooms(List<List<int>> rooms) {
    if (rooms.length == 0) return true;
    List<bool> visited = List.filled(rooms.length, false);
    depthFirstSearch(0, rooms, visited);
    for (int i = 0; i < rooms.length; i++) if (!visited[i]) return false;
    return true;
  }

  void depthFirstSearch(int index, List<List<int>> rooms, List<bool> visited) {
    visited[index] = true;
    for (int n in rooms[index]) {
      if (!visited[n]) {
        depthFirstSearch(n, rooms, visited);
      }
    }
  }
}
```

## Solution - 2 Breadth First Search

```dart
import 'dart:collection';

class Solution {
  bool canVisitAllRooms(List<List<int>> rooms) {
    HashSet<int> visited = HashSet();
    Queue<int> queue = Queue();
    queue.add(0);
    visited.add(0);
    while (queue.isNotEmpty) {
      int node = queue.removeFirst();
      for (int next in rooms[node]) {
        if (!visited.contains(next)) {
          queue.add(next);
          visited.add(next);
        }
      }
    }
    return visited.length == rooms.length;
  }
}
```

## Solution - 3 Union Find Algorithm

### WARNING - Some of cases will fail but it is intreating implementation

```dart
class Solution {
  bool canVisitAllRooms(List<List<int>> rooms) {
    // sanity check
    if (rooms.isEmpty || rooms.length == 0) {
      return false;
    }
    UnionFind uf = UnionFind(rooms.length);
    for (int i = 0; i < rooms.length; ++i) {
      for (int j = 0; j < rooms[i].length; ++j) {
        uf.union(i, rooms[i][j]);
      }
    }
    return uf.count == 1; // means only one connected component
  }
}
```

```dart

class UnionFind {
  late List<int> ids;
  late List<int> sizes;
  late int count; // represents the number of connected component
  UnionFind(int capacity) {
    ids = List.filled(capacity, 0);
    sizes = List.filled(capacity, 0);
    count = capacity;
    for (int i = 0; i < capacity; ++i) {
      ids[i] = i;
      sizes[i] = 1;
    }
  }
  void union(int a, int b) {
    int rootOfa = find(a);
    int rootOfb = find(b);
    if (rootOfa == rootOfb) {
      // already in the same connected component
      return;
    }
    count--; // union them, so decrease count
    if (sizes[rootOfa] >= sizes[rootOfb]) {
      // apply weighted union
      ids[rootOfb] = rootOfa;
      sizes[rootOfa] += sizes[rootOfb];
    } else {
      ids[rootOfa] = rootOfb;
      sizes[rootOfb] += sizes[rootOfa];
    }
  }

  int find(int a) {
    int root = ids[a];
    while (root != ids[root]) {
      root = ids[root];
    }
    while (root != ids[a]) {
      // apply path compression
      int parent = ids[a];
      ids[a] = root;
      a = parent;
    }
    return root;
  }
}
```
