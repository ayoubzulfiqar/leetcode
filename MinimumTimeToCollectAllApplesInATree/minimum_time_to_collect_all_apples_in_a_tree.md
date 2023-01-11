# 🔥 3 Approaches 🔥 || Simple Fast and Easy || with Explanation

## Approach

Still need bi-direction graph and use visited set. Example test case for that:
4
[[0,2],[0,3],[1,2]]
[false,true,false,false]
Expected Answer: 4

Key Notes:

You need to consume 2 seconds to simply collect an apple node (come and go)
Consider a node:
If none of descendant (including itself) has an apple, we don't need to waste time on this node
If any of descendant has an apple (no matter if it-self has an apple or not), we need to consume 2 seconds on this node anyway
Collect node 0 does not need to consume any time
Then, we can have a helper dfs function meaning: time needs to waste on this node to collect all apples. (0 or > 0).

## Solution - 1 Classic Depth First Search

```dart
class Solution {
  int res = 0;
  int minTime(int n, List<List<int>> edges, List<bool> hasApple) {
    HashMap<int, HashSet<int>> map = HashMap();
    for (List<int> edge in edges) {
      HashSet<int> list1 = map[edge[0]] ?? HashSet();
      HashSet<int> list2 = map[edge[1]] ?? HashSet();
      list1.add(edge[1]);
      list2.add(edge[0]);
      map.putIfAbsent(edge[0], () => list1);
      map.putIfAbsent(edge[1], () => list2);
    }
    List<bool> visited = List.filled(n, false);
    visited[0] = true;
    dfs(hasApple, map, 0, visited);
    return res;
  }

  void dfs(List<bool> hasApple, HashMap<int, HashSet<int>> map, int index,
      List<bool> visited) {
    HashSet<int> list1 = map[index] ?? HashSet();
    for (int neighbor in list1) {
      if (!visited[neighbor]) {
        int temp = res;
        visited[neighbor] = true;
        if (hasApple[neighbor]) res += 2;
        dfs(hasApple, map, neighbor, visited);
        if (!hasApple[neighbor] && temp < res) {
          res += 2;
        }
      }
    }
  }
}
```

## Solution - 2 Depth First Search - Via Building Tree

```dart
class Solution {
  int minTime(int n, List<List<int>> edges, List<bool> hasApple) {
    HashMap<int, List<int>> map = HashMap();
    buildTree(edges, map);
    HashSet<int> visited = HashSet();
    return helper(0, map, hasApple, visited);
  }

  void buildTree(List<List<int>> edges, HashMap<int, List<int>> map) {
    for (List<int> edge in edges) {
      int a = edge[0], b = edge[1];
      map.putIfAbsent(a, () => []);
      map.putIfAbsent(b, () => []);
      map[a]?.add(b);
      map[b]?.add(a);
    }
  }

  int helper(int node, HashMap<int, List<int>> map, List<bool> hasApple,
      HashSet<int> visited) {
    visited.add(node);

    int res = 0;

    for (int child in map[node] ?? []) {
      if (visited.contains(child)) continue;
      res += helper(child, map, hasApple, visited);
    }

    if ((res > 0 || hasApple[node]) && node != 0) res += 2;

    return res;
  }
}
```

## Solution - 3 For FUN

```dart
class Solution {
  late int ans;
  int minTime(int n, List<List<int>> edges, List<bool> hasApple) {
    ans = 0;
    List<List<int>> a = List.filled(n, 0, growable: true)
        .map((e) => List.filled(n, 0, growable: true))
        .toList();
    for (int i = 0; i < n; i++) {
      a[i] = [];
    }
    for (List<int> arr in edges) {
      a[arr[0]].add(arr[1]);
      a[arr[1]].add(arr[0]);
    }
    List<bool> visited = List.filled(n, false);
    visited[0] = true;
    rec(n, a, hasApple, visited, 0);
    return ans;
  }

  bool rec(int n, List<List<int>> a, List<bool> hasApple, List<bool> visited,
      int ind) {
    bool flag = false;
    for (int i = 0; i < a[ind].length; i++) {
      if (!visited[a[ind].elementAt(i)]) {
        visited[a[ind].elementAt(i)] = true;
        bool val = rec(n, a, hasApple, visited, a[ind].elementAt(i));
        if (val) {
          ans += 2;
        }
        flag = flag | val;
      }
    }
    flag = flag | hasApple.elementAt(ind);
    return flag;
  }
}
```
