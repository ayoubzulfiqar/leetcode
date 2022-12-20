/*



-* 841. Keys and Rooms *-

There are n rooms labeled from 0 to n - 1 and all the rooms are locked except for room 0. Your goal is to visit all the rooms. However, you cannot enter a locked room without having its key.

When you visit a room, you may find a set of distinct keys in it. Each key has a number on it, denoting which room it unlocks, and you can take all of them with you to unlock the other rooms.

Given an array rooms where rooms[i] is the set of keys that you can obtain if you visited room i, return true if you can visit all the rooms, or false otherwise.

 

Example 1:

Input: rooms = [[1],[2],[3],[]]
Output: true
Explanation: 
We visit room 0 and pick up key 1.
We then visit room 1 and pick up key 2.
We then visit room 2 and pick up key 3.
We then visit room 3.
Since we were able to visit every room, we return true.
Example 2:

Input: rooms = [[1,3],[3,0,1],[2],[0]]
Output: false
Explanation: We can not enter room number 2 since the only key that unlocks it is in that room.
 

Constraints:

n == rooms.length
2 <= n <= 1000
0 <= rooms[i].length <= 1000
1 <= sum(rooms[i].length) <= 3000
0 <= rooms[i][j] < n
All the values of rooms[i] are unique.


*/

/*



*/

import 'dart:collection';

class A {
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

class B {
  // breath first Search
  bool canVisitAllRooms(List<List<int>> rooms) {
    HashSet<int> visited = HashSet();
    Queue<int> queue = Queue();
    queue.add(0);
    visited.add(0);
    while (queue.isNotEmpty) {
      // poll
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

class C {
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
