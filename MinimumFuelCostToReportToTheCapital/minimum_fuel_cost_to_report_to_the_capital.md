# 🔥 DFS & BFS 🔥 || Simple Fast and Easy || with Explanation

## Code -1 Breath First Search

```dart
class Solution {
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
   
    while (q.isNotEmpty) {
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
```

## Code -2 Depth First Search

```dart
class Solution {
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
```
