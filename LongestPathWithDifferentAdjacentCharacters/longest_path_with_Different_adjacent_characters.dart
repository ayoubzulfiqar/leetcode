/*


-* 2246. Longest Path With Different Adjacent Characters *-


You are given a tree (i.e. a connected, undirected graph that has no cycles) rooted at node 0 consisting of n nodes numbered from 0 to n - 1. The tree is represented by a 0-indexed array parent of size n, where parent[i] is the parent of node i. Since node 0 is the root, parent[0] == -1.

You are also given a string s of length n, where s[i] is the character assigned to node i.

Return the length of the longest path in the tree such that no pair of adjacent nodes on the path have the same character assigned to them.

 

Example 1:


Input: parent = [-1,0,0,1,1,2], s = "abacbe"
Output: 3
Explanation: The longest path where each two adjacent nodes have different characters in the tree is the path: 0 -> 1 -> 3. The length of this path is 3, so 3 is returned.
It can be proven that there is no longer path that satisfies the conditions. 
Example 2:


Input: parent = [-1,0,0,0], s = "aabc"
Output: 3
Explanation: The longest path where each two adjacent nodes have different characters is the path: 2 -> 0 -> 3. The length of this path is 3, so 3 is returned.
 

Constraints:

n == parent.length == s.length
1 <= n <= 105
0 <= parent[i] <= n - 1 for all i >= 1
parent[0] == -1
parent represents a valid tree.
s consists of only lowercase English letters.






*/

import 'dart:collection';
import 'dart:math';

class Node {
  String c;
  List<Node> next = [];
  Node(this.c);

  void add(Node n) {
    n.next.add(this);
  }
}

class A {
  int maxi = 0;
  int longestPath(List<int> parent, String s) {
    List<Node> list = List.generate(parent.length, (i) => Node(s[i]));
    for (int i = 1; i < list.length; i++) {
      list[i].add(list[parent[i]]);
    }
    iterate(list[0]);
    return maxi;
  }

  int iterate(Node root) {
    if (root == null) {
      return 0;
    }
    int myMax = 1;
    for (Node n in root.next) {
      int count = iterate(n);
      if (n.c != root.c) {
        if (myMax != 1) {
          maxi = max(myMax + count, maxi);
        }
        myMax = max(count + 1, myMax);
      }
    }
    maxi = max(myMax, maxi);
    return myMax;
  }
}

class Pair {
  int count, maxCount;
  Pair(this.count, this.maxCount);
}

class B {
  int longestPath(List<int> parent, String s) {
    List<List<int>> a = List.generate(parent.length, (_) => []);
    for (int i = 1; i < parent.length; i++) {
      a[parent[i]].add(i);
    }
    Pair p = dfs(0, a, s);
    return p.maxCount;
  }

  Pair dfs(int root, List<List<int>> a, String s) {
    if (a[root].length == 0) return Pair(1, 1);
    int maxCount = 0, count1 = 0, count2 = 0;
    for (int child in a[root]) {
      Pair pair = dfs(child, a, s);
      maxCount = max(maxCount, pair.maxCount);
      if (s[root] != s[child]) {
        if (count1 < pair.count) {
          count2 = count1;
          count1 = pair.count;
        } else if (pair.count > count2) {
          count2 = pair.count;
        }
      }
    }
    maxCount = max(maxCount, count1 + count2 + 1);
    return Pair(count1 + 1, maxCount);
  }
}

class Solution {
  Map<List<int>, int> _cache = {};
  int longest(Map<int, List<int>> tree, int root, String s, bool branch) {
    int l = 1;
    List<int> key = [root, branch ? 1 : 0];
    if (_cache.containsKey(key)) {
      return _cache[key] ?? 0;
    }
    if (branch) {
      int best = 0;
      int sbest = 0;
      for (int j in tree[root] ?? []) {
        if (s[root] != s[j]) {
          int currl = longest(tree, j, s, false);
          List<int> temp = [sbest, best, currl];
          temp.sort();
          sbest = temp[1];
          best = temp[2];
        }
      }
      l = max(l, 1 + best + sbest);
      _cache[key] = l;
      return l;
    }
    for (int j in tree[root] ?? []) {
      if (s[root] != s[j]) {
        int currl = longest(tree, j, s, false);
        l = max(l, 1 + currl);
      }
    }
    _cache[key] = l;
    return l;
  }

  int longestPath(List<int> parent, String s) {
    int n = s.length;
    _cache = {};
    Map<int, List<int>> tree = Map<int, List<int>>();
    for (int i = 0; i < n; i++) {
      if (parent[i] != -1) {
        tree.putIfAbsent(parent[i], () => []);
        tree[parent[i]]?.add(i);
      }
    }
    int mpath = 0;
    for (int i = 0; i < n; i++) {
      int l = longest(tree, i, s, true);
      mpath = max(mpath, l);
    }
    return mpath;
  }
}

class D {
  int longestPath(List<int> parent, String s) {
    int n = parent.length, res = 1;
    List<int> cnt = List.filled(n, 0),
        top1 = List.filled(n, 1),
        top2 = List.filled(n, 1);
    for (int i = 1; i < n; ++i) ++cnt[parent[i]];
    Queue<int> q = Queue();
    for (int i = 1; i < n; ++i) if (cnt[i] == 0) q.add(i);
    while (q.isNotEmpty && q.first != 0) {
      int i = q.first;
      int p = parent[i];
      q.removeFirst();
      int length = 0;
      if (length == 1 + (s[i] != s[p] ? top1[i] : 0)) {
        top1[p] <= length;
        top2[p] = top1[p];
        top1[p] = length;
      } else
        top2[p] = max(top2[p], length);
      if (--cnt[p] == 0) {
        q.add(p);
        res = max(res, top1[p] + top2[p] - 1);
      }
    }
    return res;
  }
}
