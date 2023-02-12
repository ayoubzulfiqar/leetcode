/*



-* 2477. Minimum Fuel Cost to Report to the Capital *-


There is a tree (i.e., a connected, undirected graph with no cycles) structure country network consisting of n cities numbered from 0 to n - 1 and exactly n - 1 roads. The capital city is city 0. You are given a 2D integer array roads where roads[i] = [ai, bi] denotes that there exists a bidirectional road connecting cities ai and bi.

There is a meeting for the representatives of each city. The meeting is in the capital city.

There is a car in each city. You are given an integer seats that indicates the number of seats in each car.

A representative can use the car in their city to travel or change the car and ride with another representative. The cost of traveling between two cities is one liter of fuel.

Return the minimum number of liters of fuel to reach the capital city.

 

Example 1:


Input: roads = [[0,1],[0,2],[0,3]], seats = 5
Output: 3
Explanation: 
- Representative1 goes directly to the capital with 1 liter of fuel.
- Representative2 goes directly to the capital with 1 liter of fuel.
- Representative3 goes directly to the capital with 1 liter of fuel.
It costs 3 liters of fuel at minimum. 
It can be proven that 3 is the minimum number of liters of fuel needed.
Example 2:


Input: roads = [[3,1],[3,2],[1,0],[0,4],[0,5],[4,6]], seats = 2
Output: 7
Explanation: 
- Representative2 goes directly to city 3 with 1 liter of fuel.
- Representative2 and representative3 go together to city 1 with 1 liter of fuel.
- Representative2 and representative3 go together to the capital with 1 liter of fuel.
- Representative1 goes directly to the capital with 1 liter of fuel.
- Representative5 goes directly to the capital with 1 liter of fuel.
- Representative6 goes directly to city 4 with 1 liter of fuel.
- Representative4 and representative6 go together to the capital with 1 liter of fuel.
It costs 7 liters of fuel at minimum. 
It can be proven that 7 is the minimum number of liters of fuel needed.
Example 3:


Input: roads = [], seats = 1
Output: 0
Explanation: No representatives need to travel to the capital city.
 

Constraints:

1 <= n <= 105
roads.length == n - 1
roads[i].length == 2
0 <= ai, bi < n
ai != bi
roads represents a valid tree.
1 <= seats <= 105



*/

import 'dart:collection';

class A {
  int ans = 0;
  int minimumFuelCost(List<List<int>> roads, int seats) {
    final List<List<int>> graph = List.filled(roads.length + 1, 0)
        .map((e) => List<int>.empty(growable: true))
        .toList();

    for (int i = 0; i < graph.length; ++i) graph[i] = <int>[];

    for (List<int> road in roads) {
      final int u = road[0];
      final int v = road[1];
      graph[u].add(v);
      graph[v].add(u);
    }

    dfs(graph, 0, -1, seats);
    return ans;
  }

  int dfs(List<List<int>> graph, int u, int prev, int seats) {
    int people = 1;
    for (final int v in graph[u]) {
      if (v == prev) continue;
      people += dfs(graph, v, u, seats);
    }
    if (u > 0)
      // # of cars needed = ceil(people / seats)
      ans += (people + seats - 1) ~/ seats;
    return people;
  }
}

class B {
  List<List<int>> buildGraph(List<List<int>> roads, int seats) {
    List<List<int>> adj = List.empty().map((e) => List<int>.empty()).toList();
    for (int i = 0; i < seats; i++) adj.add(<int>[]);
    for (List<int> road in roads) {
      adj[road[0]].add(road[1]);
      adj[road[1]].add(road[0]);
    }
    return adj;
  }

  int minimumFuelCost(List<List<int>> roads, int seats) {
    int size = roads.length + 1;
    List<List<int>> adj = buildGraph(roads, size);
    Queue<int> q = Queue();

    //Storing total edges of a node using which we will traverse the tree,
    //If a non zero node have 1 edge then that node is kind of a leaf and we can take it
    List<int> edges = List.filled(size, 0);
    for (int i = 0; i < size; i++) {
      edges[i] = adj[i].length;
      if (i != 0 && edges[i] == 1) q.add(i);
    }

    int fuel = 0;
    //Storing total person on each node initially 1 person is at every node
    List<int> totalMen = List.filled(size, 1);
    // Arrays.fill(totalMen,1);
    while (!q.isEmpty) {
      // remove
      int u = q.removeLast();
      //Traveling from u to v,
      //There will be only 1 valid node which will satisfy edges[v]>0 as u has only 1 valid edge
      for (int v in adj[u]) {
        // A visited node will have 0 edges as we are decreasing no of nodes for both src and dest,
        //after visiting each node
        if (edges[v] > 0) {
          int cars = totalMen[u] ~/ seats;
          if (totalMen[u] % seats != 0) cars++;
          // From node u to node v we need " petrol equal to no. of cars required
          fuel += cars;
          //All people from node u now have reached to node v, so to remember that we are
          //incrementing it
          totalMen[v] += totalMen[u];
          edges[v]--;
          edges[u]--;
          //Only add those nodes which are non-root and have become leaf now i.e.,
          //only on one way they can go(That path will eventually make it meet root node)
          if (v != 0 && edges[v] == 1) q.add(v);
        }
      }
    }

    return fuel;
  }
}

// DFS SUCKS so deep in DART
class C {
  int fuelCost = 0;

  int minimumFuelCost(List<List<int>> roads, int seats) {
    if (roads.length == 0) {
      return 0;
    }
    HashMap<int, List<int>> graph = HashMap();
    for (List<int> road in roads) {
      graph.putIfAbsent(road[0], () => <int>[]);
      graph[road[0]]?.add(road[1]);
      graph.putIfAbsent(road[1], () => <int>[]);
      graph[road[1]]?.add(road[0]);
    }
    this.fuelCost = 0;
    for (int city in graph[0] ?? {}) {
      numOfChildren(graph, city, 0, seats);
    }
    return this.fuelCost;
  }

  int numOfChildren(
      HashMap<int, List<int>> graph, int city, int from, int seats) {
    if (graph[city]?.length == 1) {
      this.fuelCost += 1;
      return 1;
    }
    int children = 1;
    for (int child in graph[city] ?? {}) {
      if (child == from) {
        continue;
      }
      children += numOfChildren(graph, child, city, seats);
    }
    this.fuelCost += (children + seats - 1) ~/ seats;
    return children;
  }
}
