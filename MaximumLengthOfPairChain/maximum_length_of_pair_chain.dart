/*

-* 646. Maximum Length of Pair Chain *-

You are given an array of n pairs pairs where pairs[i] = [lefti, righti] and lefti < righti.

A pair p2 = [c, d] follows a pair p1 = [a, b] if b < c. A chain of pairs can be formed in this fashion.

Return the length longest chain which can be formed.

You do not need to use up all the given intervals. You can select pairs in any order.

 

Example 1:

Input: pairs = [[1,2],[2,3],[3,4]]
Output: 2
Explanation: The longest chain is [1,2] -> [3,4].
Example 2:

Input: pairs = [[1,2],[7,8],[4,5]]
Output: 3
Explanation: The longest chain is [1,2] -> [4,5] -> [7,8].
 

Constraints:

n == pairs.length
1 <= n <= 1000
-1000 <= left-i < right-i <= 1000




*/

// Bucket Sort

import 'dart:collection';

class Solution {
  int findLongestChain(List<List<int>> pairs) {
    int max = 0;
    final List<int> timeline = List<int>.filled(2001, 0);
    int s;
    int f;
    for (final List<int> pair in pairs) {
      s = pair[0] + 1000;
      f = pair[1] + 1000;
      max = max > f ? max : f;
      if (timeline[f] < s) timeline[f] = s;
    }
    int l = 0;
    int k = 0;
    for (int i = 0; i <= max; i++) {
      if (timeline[i] > k) {
        l++;
        k = i;
      }
    }
    return l;
  }
}

// TOPO Sort

class A {
  int findLongestChain(List<List<int>> pairs) {
    final int n = pairs.length;
    final List<int> inDegree = List<int>.filled(n, 0);
    final List<List<int>> adj = List.generate(n, (index) => <int>[]);

    for (int i = 0; i < n; i++) {
      for (int j = 0; j < n; j++) {
        if (pairs[i][1] < pairs[j][0]) {
          adj[i].add(j);
          inDegree[j]++;
        }
      }
    }

    final Queue<int> q = Queue<int>();
    for (int i = 0; i < n; i++) {
      if (inDegree[i] == 0) q.add(i);
    }

    final List<int> distance = List<int>.filled(n, 0);
    while (q.isNotEmpty) {
      final int node = q.removeFirst();

      for (int i in adj[node]) {
        inDegree[i]--;
        distance[i] =
            distance[i] > 1 + distance[node] ? distance[i] : 1 + distance[node];
        if (inDegree[i] == 0) q.add(i);
      }
    }

    int maxValue = 0;
    for (final int i in distance) {
      maxValue = maxValue > i ? maxValue : i;
    }

    return maxValue + 1;
  }
}

// Matrix - Greedy
class B {
  int findLongestChain(List<List<int>> pairs) {
    pairs.sort((a, b) => a[1].compareTo(b[1]));
    int count = 1;
    int pairEnd = pairs[0][1]; // Last selected pair end
    for (int i = 1; i < pairs.length; i++) {
      if (pairs[i][0] > pairEnd) {
        count++;
        pairEnd = pairs[i][1];
      }
    }
    return count;
  }
}
