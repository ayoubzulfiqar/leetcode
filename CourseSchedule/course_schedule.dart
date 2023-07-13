/*


-* Course Schedule *-

There are a total of numCourses courses you have to take, labeled from 0 to numCourses - 1. You are given an array prerequisites where prerequisites[i] = [ai, bi] indicates that you must take course bi first if you want to take course ai.

For example, the pair [0, 1], indicates that to take course 0 you have to first take course 1.
Return true if you can finish all courses. Otherwise, return false.

 

Example 1:

Input: numCourses = 2, prerequisites = [[1,0]]
Output: true
Explanation: There are a total of 2 courses to take. 
To take course 1 you should have finished course 0. So it is possible.
Example 2:

Input: numCourses = 2, prerequisites = [[1,0],[0,1]]
Output: false
Explanation: There are a total of 2 courses to take. 
To take course 1 you should have finished course 0, and to take course 0 you should also have finished course 1. So it is impossible.
 

Constraints:

1 <= numCourses <= 2000
0 <= prerequisites.length <= 5000
prerequisites[i].length == 2
0 <= ai, bi < numCourses
All the pairs prerequisites[i] are unique.



*/

// Topological Sort
// class Solution {
//   bool canFinish(int numCourses, List<List<int>> prerequisites) {}
// }

import 'dart:collection';

class A {
  bool canFinish(int numCourses, List<List<int>> prerequisites) {
    final List<int> answer = [];
    final Map<int, List<int>> map = Map();
    final List<int> result = List<int>.filled(numCourses, 0);

    for (final List<int> x in prerequisites) {
      map[x[1]] = [...map[x[1]] ?? [], x[0]];
      result[x[0]]++;
    }

    final Queue<int> q = Queue<int>();
    for (int i = 0; i < numCourses; i++) {
      if (result[i] == 0) {
        q.add(i);
      }
    }

    while (q.isNotEmpty) {
      final int fr = q.removeFirst();
      answer.add(fr);

      for (final int x in map[fr] ?? []) {
        result[x]--;
        if (result[x] == 0) {
          q.add(x);
        }
      }
    }

    return answer.length == numCourses;
  }
}

// Union Find - Wrong

class F {
  bool canFinish(int numCourses, List<List<int>> prerequisites) {
    List<int> par = List<int>.generate(numCourses, (index) => index);
    List<int> rank = List<int>.filled(numCourses, 0);

    for (var pre in prerequisites) {
      int x = pre[0];
      int y = pre[1];
      if (find(par, x) == find(par, y)) {
        return false; // Cycle detected
      }
      union(par, rank, x, y);
    }

    return true;
  }

  int find(List<int> par, int x) {
    if (par[x] != x) {
      par[x] = find(par, par[x]);
    }
    return par[x];
  }

  void union(List<int> par, List<int> rank, int x, int y) {
    int rootX = find(par, x);
    int rootY = find(par, y);

    if (rootX != rootY) {
      if (rank[rootX] < rank[rootY]) {
        par[rootX] = rootY;
      } else if (rank[rootX] > rank[rootY]) {
        par[rootY] = rootX;
      } else {
        par[rootY] = rootX;
        rank[rootX]++;
      }
    }
  }
}

// Correct

class B {
  bool canFinish(int numCourses, List<List<int>> prerequisites) {
   final List<List<int>> graph = List<List<int>>.generate(numCourses, (_) => []);
    for (var pre in prerequisites) {
    final  int x = pre[0];
    final  int y = pre[1];
      graph[x].add(y);
    }

   final List<int> visited = List<int>.filled(numCourses, 0);
    for (int i = 0; i < numCourses; i++) {
      if (hasCycle(graph, visited, i)) {
        return false; // Cycle detected
      }
    }

    return true;
  }

  bool hasCycle(List<List<int>> graph, List<int> visited, int node) {
    if (visited[node] == 1) {
      return true; // Cycle detected
    }
    if (visited[node] == -1) {
      return false; // Already visited and no cycle
    }

    visited[node] = 1; // Mark node as visited

    for (final int neighbor in graph[node]) {
      if (hasCycle(graph, visited, neighbor)) {
        return true; // Cycle detected
      }
    }

    visited[node] = -1; // Mark node as visited and no cycle
    return false;
  }
}

class Solution {
  bool canFinish(int numCourses, List<List<int>> prerequisites) {
    final List<List<int>> graph = List<List<int>>.generate(
        numCourses, (_) => List<int>.filled(numCourses, 0));

    // Create graph representation - adjacency matrix.
    for (int i = 0; i < prerequisites.length; i++) {
      graph[prerequisites[i][1]][prerequisites[i][0]] = 1;
    }

    return topoSort(graph, numCourses);
  }

  bool topoSort(List<List<int>> graph, int numCourses) {
    final List<bool> visited = List<bool>.filled(numCourses, false);
    final List<bool> tempMarked = List<bool>.filled(numCourses, false);
    final List<int> path = [];

    for (int i = 0; i < numCourses; i++) {
      if (!visited[i] && !dfsVisit(graph, i, path, visited, tempMarked)) {
        return false;
      }
    }

    // TopoSort builds the actual schedule in the path.
    return path.length == numCourses;
  }

  bool dfsVisit(List<List<int>> graph, int course, List<int> path,
      List<bool> visited, List<bool> tempMarked) {
    if (tempMarked[course]) {
      return false;
    }
    if (!visited[course]) {
      tempMarked[course] = true;
      for (int i = 0; i < graph.length; i++) {
        if (graph[course][i] == 1) {
          if (!dfsVisit(graph, i, path, visited, tempMarked)) {
            return false;
          }
        }
      }
      tempMarked[course] = false;
      visited[course] = true;
      path.add(course);
    }
    return true;
  }
}
