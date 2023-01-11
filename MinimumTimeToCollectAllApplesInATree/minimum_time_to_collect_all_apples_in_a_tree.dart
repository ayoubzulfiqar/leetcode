/*

-* 1443. Minimum Time to Collect All Apples in a Tree *-


Given an undirected tree consisting of n vertices numbered from 0 to n-1, which has some apples in their vertices. You spend 1 second to walk over one edge of the tree. Return the minimum time in seconds you have to spend to collect all apples in the tree, starting at vertex 0 and coming back to this vertex.

The edges of the undirected tree are given in the array edges, where edges[i] = [ai, bi] means that exists an edge connecting the vertices ai and bi. Additionally, there is a boolean array hasApple, where hasApple[i] = true means that vertex i has an apple; otherwise, it does not have any apple.

 

Example 1:


Input: n = 7, edges = [[0,1],[0,2],[1,4],[1,5],[2,3],[2,6]], hasApple = [false,false,true,false,true,true,false]
Output: 8 
Explanation: The figure above represents the given tree where red vertices have an apple. One optimal path to collect all apples is shown by the green arrows.  
Example 2:


Input: n = 7, edges = [[0,1],[0,2],[1,4],[1,5],[2,3],[2,6]], hasApple = [false,false,true,false,false,true,false]
Output: 6
Explanation: The figure above represents the given tree where red vertices have an apple. One optimal path to collect all apples is shown by the green arrows.  
Example 3:

Input: n = 7, edges = [[0,1],[0,2],[1,4],[1,5],[2,3],[2,6]], hasApple = [false,false,false,false,false,false,false]
Output: 0
 

Constraints:

1 <= n <= 105
edges.length == n - 1
edges[i].length == 2
0 <= ai < bi <= n - 1
from-i < toi
hasApple.length == n

*/

import 'dart:collection';

class A {
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

class B {
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

class C {
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
