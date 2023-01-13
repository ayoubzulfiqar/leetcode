/*


*- 1519. Number of Nodes in the Sub-Tree With the Same Label *-


You are given a tree (i.e. a connected, undirected graph that has no cycles) consisting of n nodes numbered from 0 to n - 1 and exactly n - 1 edges. The root of the tree is the node 0, and each node of the tree has a label which is a lower-case character given in the string labels (i.e. The node with the number i has the label labels[i]).

The edges array is given on the form edges[i] = [ai, bi], which means there is an edge between nodes ai and bi in the tree.

Return an array of size n where ans[i] is the number of nodes in the subtree of the ith node which have the same label as node i.

A subtree of a tree T is the tree consisting of a node in T and all of its descendant nodes.

 

Example 1:


Input: n = 7, edges = [[0,1],[0,2],[1,4],[1,5],[2,3],[2,6]], labels = "abaedcd"
Output: [2,1,1,1,1,1,1]
Explanation: Node 0 has label 'a' and its sub-tree has node 2 with label 'a' as well, thus the answer is 2. Notice that any node is part of its sub-tree.
Node 1 has a label 'b'. The sub-tree of node 1 contains nodes 1,4 and 5, as nodes 4 and 5 have different labels than node 1, the answer is just 1 (the node itself).
Example 2:


Input: n = 4, edges = [[0,1],[1,2],[0,3]], labels = "bbbb"
Output: [4,2,1,1]
Explanation: The sub-tree of node 2 contains only node 2, so the answer is 1.
The sub-tree of node 3 contains only node 3, so the answer is 1.
The sub-tree of node 1 contains nodes 1 and 2, both have label 'b', thus the answer is 2.
The sub-tree of node 0 contains nodes 0, 1, 2 and 3, all with label 'b', thus the answer is 4.
Example 3:


Input: n = 5, edges = [[0,1],[0,2],[1,3],[0,4]], labels = "aabab"
Output: [3,2,1,1,1]
 

Constraints:

1 <= n <= 105
edges.length == n - 1
edges[i].length == 2
0 <= ai, bi < n
ai != bi
labels.length == n
labels is consisting of only of lowercase English letters.



*/

/*

We need to return the number of nodes in the subtree of the currentent node which have the same label as currentent node . To do that we use a HashMap of labels that are present in the subtree of the currentent node.
So we use a function helper to do the same.

node -> an integer representing the currentent node being visited
labels -> a character array representing the labels of the nodes in the tree.
answer-> an integer array where answer[i] will store the number of subtrees with the same label as the i-th node.
visited ->a boolean array where visited[i] will be used to keep track of whether the i-th node has been visited during the traversal.
This function will return a HashMap with all the labels along with their counts of that subtree.
The required output is stored in the array answer.

*/

import 'dart:collection';

class A {
  // Memory Limit Exceed
  late List<List<int>> canVisit;
  List<int> countSubTrees(int n, List<List<int>> edges, String labels) {
    canVisit = List.filled(n, 0).map((e) => List.filled(n, 0)).toList();
    for (int i = 0; i < n; i++) canVisit[i] = [];
    for (List<int> edge in edges) {
      canVisit[edge[0]].add(edge[1]);
      canVisit[edge[1]].add(edge[0]);
    }
    List<bool> visited = List.filled(n, false);
    List<int> answer = List.filled(n, 0);
    helper(0, labels.split(""), answer, visited);
    return answer;
  }

  HashMap<String, int> helper(
      int node, List<String> labels, List<int> answer, List<bool> visited) {
    HashMap<String, int> currententHashMap = HashMap();
    visited[node] = true;
    for (int i in canVisit[node]) {
      if (visited[i]) continue;
      HashMap<String, int> map = helper(i, labels, answer, visited);
      for (MapEntry<String, int> entry in map.entries) {
        currententHashMap[entry.key] =
            (currententHashMap[entry.key] ?? 0) + entry.value;
      }
    }
    currententHashMap[labels[node]] =
        (currententHashMap[labels[node]] ?? 0) + 1;
    answer[node] = currententHashMap[labels[node]]!;
    return currententHashMap;
  }
}

class B {
  // Memory Limit Exceed
  late List<int> result;
  late List<List<int>> adj;
  late List<bool> visited;
  List<int> countSubTrees(int n, List<List<int>> edges, String labels) {
    //Creating an adjacency list to store the edges
    adj = List.filled(n, 0, growable: true)
        .map((e) => List.filled(n, 0, growable: true))
        .toList();
    result = List.filled(n, 0);
    //initializing the adjacency list
    for (int i = 0; i < n; i++) {
      adj.add([]);
    }
    //populating the adjacency list with the edges
    for (List<int> edge in edges) {
      adj[edge[0]].add(edge[1]);
      adj[edge[1]].add(edge[0]);
    }
    //keep track of visited nodes
    visited = List.filled(n, false);
    //calling the dfs function to count the subtrees starting from the root node
    dfs(0, labels);
    return result;
  }

  List<int> dfs(int node, String labels) {
    visited[node] = true;
    List<int> count = List.filled(26, 0);
    //visiting all the neighbors of the currentent node
    for (int nbr in adj[node]) {
      if (!visited[nbr]) {
        List<int> adjCount = dfs(nbr, labels);
        //updating the count array with the count of the subtrees of the neighbors
        for (int i = 0; i < 26; i++) {
          count[i] += adjCount[i];
        }
      }
    }
    //incrementing the count of the currentent node label
    int ch = labels.codeUnitAt(node);
    count[ch - 'a'.codeUnitAt(0)]++;
    //storing the count of the subtrees of the currentent node
    result[node] = count[ch - 'a'.codeUnitAt(0)];
    return count;
  }
}

class C {
  List<int> countSubTrees(int n, List<List<int>> edges, String labels) {
    List<List<int>> graph = List.filled(n, 0, growable: true)
        .map((e) => List.filled(n, 0, growable: true))
        .toList();
    int i;
    for (i = 0; i < n; i++) graph[i] = [];
    for (i = 0; i < edges.length; i++) {
      graph[edges[i][0]].add(edges[i][1]);
      graph[edges[i][1]].add(edges[i][0]);
    }
    List<int> ans = List.filled(n, 0);
    List<int> freq = List.filled(26, 0);
    List<bool> dp = List.filled(n, false);
    dfs(0, ans, freq, dp, labels, graph);
    return ans;
  }

  void dfs(int i, List<int> ans, List<int> freq, List<bool> dp, String s,
      List<List<int>> graph) {
    if (dp[i]) return;
    dp[i] = true;
    int c = s.codeUnitAt(i) - 'a'.codeUnitAt(0);
    int tmp = freq[c];
    freq[c] = 1;
    for (int it in graph[i]) dfs(it, ans, freq, dp, s, graph);
    ans[i] = freq[c];
    freq[c] += tmp;
  }
}

//================

// class ANode {
//   late String c;
//   late int key;
//   late List<Node> cs;
//   late Node? p;
//   Node(int key) {
//     this.key = key;
//     cs = <Node>[];
//     this.p = null;
//   }
// }

// class D {
//   late List<int> res;
//   Node build(int n, List<List<int>> es, String l) {
//     HashMap<int, List<int>> g = HashMap();
//     for (List<int> e in es) {
//       g.putIfAbsent(e[0], () => []);
//       g.putIfAbsent(e[1], () => []);
//       g[e[1]]?.add(e[0]);
//       g[e[0]]?.add(e[1]);
//     }
//     Node root = Node(0);
//     root.c = l[0];
//     Queue<Node> q = Queue();
//     q.add(root);
//     while (!q.isEmpty) {
//       Node current = q.removeLast();
//       for (int neighbor in g[current.key] ?? []) {
//         if (current.p == null || neighbor != current.p?.key) {
//           Node next = Node(neighbor);
//           next.c = l[neighbor];
//           next.p = current;
//           current.cs.add(next);
//           q.add(next);
//         }
//       }
//     }
//     return root;
//   }

//   HashMap<String, int> dfs(Node? node) {
//     HashMap<String, int> map = HashMap();
//     if (node == null) return map;
//     map[node.c] = 1;
//     for (Node child in node.cs) {
//       HashMap<String, int> cHashMap = dfs(child);
//       for (String c in cHashMap.keys) {
//         map[c] = (map[c] ?? 0) + cHashMap[c]!;
//       }
//     }
//     res[node.key] = map[node.c]!;
//     return map;
//   }

//   List<int> countSubTrees(int n, List<List<int>> edges, String labels) {
//     Node root = build(n, edges, labels);
//     res = List.filled(n, 0, growable: true);
//     dfs(root);
//     return res;
//   }
// }

class E {
  // Time limit exceed
  late List<int> result;
  late HashSet<int> visited;
  late HashMap<int, HashSet<int>> graph;
  late String labels;
  List<int> countSubTrees(int n, List<List<int>> edges, String labels) {
    visited = HashSet();
    this.labels = labels;
    result = List.filled(n, 0);
    graph = buildGraph(edges);
    findLabels(0);
    return result;
  }

  HashMap<int, HashSet<int>> buildGraph(List<List<int>> edges) {
    HashMap<int, HashSet<int>> map = HashMap();
    for (List<int> e in edges) {
      int a = e[0];
      int b = e[1];
      addEdge(map, a, b);
      addEdge(map, b, a);
    }
    return map;
  }

  void addEdge(HashMap<int, HashSet<int>> HashMap, int a, int b) {
    if (!HashMap.containsKey(a)) {
      HashMap[a] = HashSet();
    }
    HashMap[a]?.add(b);
  }

  List<int> findLabels(int root) {
    List<int> allLabelsCounter = List.filled(26, 0);
    if (visited.contains(root)) {
      return allLabelsCounter;
    }
    visited.add(root);
    HashSet<int> neighbors = graph[root]!;
    int labelIndex = labels.codeUnitAt(root) - 'a'.codeUnitAt(0);
    allLabelsCounter[labelIndex]++;
    if (neighbors.isEmpty || neighbors.length == 0) {
      result[root] = allLabelsCounter[labelIndex];
      return allLabelsCounter;
    }
    for (int nbr in neighbors) {
      List<int> temp = findLabels(nbr);
      for (int i = 0; i < temp.length; i++) {
        allLabelsCounter[i] += temp[i];
      }
    }
    result[root] = allLabelsCounter[labelIndex];
    return allLabelsCounter;
  }
}

class Node {
  late List<Node> next;
  late int id;

  Node(int id) {
    next = [];
    this.id = id;
  }
}

class F {
  List<int> countSubTrees(int n, List<List<int>> edges, String labels) {
    List<int> res = List.filled(n, 0, growable: true);
    HashMap<int, Node> map = HashMap();
    Node root = new Node(0);
    map[0] = root;
    for (List<int> e in edges) {
      if (!map.containsKey(e[0])) {
        Node t = new Node(e[0]);
        map[e[0]] = t;
        map[e[1]]?.next.add(t);
      } else {
        Node t = new Node(e[1]);
        map[e[1]] = t;
        map[e[0]]?.next.add(t);
      }
    }
    List<String> arr = labels.split("");
    dfs(root, arr, res);
    return res;
  }

  List<int> dfs(Node? node, List<String> arr, List<int> res) {
    if (node == null) {
      return [];
    }
    if (node.next.length == 0) {
      List<int> record = List.filled(26, 0);
      record[arr[node.id].codeUnitAt(0) - 'a'.codeUnitAt(0)]++;
      res[node.id] = record[arr[node.id].codeUnitAt(0) - 'a'.codeUnitAt(0)];
      return record;
    }
    List<int> r = List.filled(26, 0);
    for (Node n in node.next) {
      List<int> t = dfs(n, arr, res);
      for (int i = 0; i < 26; i++) {
        r[i] += t[i];
      }
    }
    r[arr[node.id].codeUnitAt(0) - 'a'.codeUnitAt(0)]++;
    res[node.id] = r[arr[node.id].codeUnitAt(0) - 'a'.codeUnitAt(0)];
    return r;
  }
}
/*


class Solution {
    public int[] countSubTrees(int n, int[][] edges, String labels) {
        int[] res = new int[n];
        Map<Integer, Node> map = new HashMap<>();
        Node root = new Node(0);
        map.put(0, root);
        for (int[] e : edges) {
            if (!map.containsKey(e[0])) {
                Node t = new Node(e[0]);
                map.put(e[0], t);
                map.get(e[1]).nexts.add(t);
            } else {
                Node t = new Node(e[1]);
                map.put(e[1], t);
                map.get(e[0]).nexts.add(t);
            }
        }
        char[] arr = labels.toCharArray();
        dfs(root, arr, res);
        return res;
    }

    int[] dfs(Node node, char[] arr, int[] res) {
        if (node == null) {
            return null;
        }
        if (node.nexts.size() == 0) {
            int[] record = new int[26];
            record[arr[node.id] - 'a']++;
            res[node.id] = record[arr[node.id] - 'a'];
            return record;
        }
        int[] r = new int[26];
        for (Node n : node.nexts) {
            int[] t = dfs(n, arr, res);
            for (int i = 0; i < 26; i++) {
                r[i] += t[i];
            }
        }
        r[arr[node.id] - 'a']++;
        res[node.id] = r[arr[node.id] - 'a'];
        return r;
    }
    
    
}

*/