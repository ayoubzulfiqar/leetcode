/*


-* Minimum Genetic Mutation *-


A gene string can be represented by an 8-character long string, with choices from 'A', 'C', 'G', and 'T'.

Suppose we need to investigate a mutation from a gene string start to a gene string end where one mutation is defined as one single character changed in the gene string.

For example, "AACCGGTT" --> "AACCGGTA" is one mutation.
There is also a gene bank bank that records all the valid gene mutations. A gene must be in bank to make it a valid gene string.

Given the two gene strings start and end and the gene bank bank, return the minimum number of mutations needed to mutate from start to end. If there is no such a mutation, return -1.

Note that the starting point is assumed to be valid, so it might not be included in the bank.



Example 1:

Input: start = "AACCGGTT", end = "AACCGGTA", bank = ["AACCGGTA"]
Output: 1
Example 2:

Input: start = "AACCGGTT", end = "AAACGGTA", bank = ["AACCGGTA","AACCGCTA","AAACGGTA"]
Output: 2
Example 3:

Input: start = "AAAAACCC", end = "AACCCCCC", bank = ["AAAACCCC","AAACCCCC","AACCCCCC"]
Output: 3


Constraints:

start.length == 8
end.length == 8
0 <= bank.length <= 10
bank[i].length == 8
start, end, and bank[i] consist of only the characters ['A', 'C', 'G', 'T'].




*/

import 'dart:collection';
import 'dart:math';

// Breadth first Search
class A {
// Runtime: 375 ms, faster than 100.00% of Dart online submissions for Minimum Genetic Mutation.
// Memory Usage: 142.8 MB, less than 100.00% of Dart online submissions for Minimum Genetic Mutation.
  bool isValid(String s, String target) {
    int changedCount = 0;
    for (int i = 0; i < s.length; i++) {
      if (s[i] != target[i]) changedCount++;
    }
    if (changedCount == 1)
      return true; //if ony one char is changed then "MUTATION IS VALID"
    return false; //changedCount == 0 or changedCount > 1 => "MUTATION IS INVALID"
  }

  int minMutation(String start, String end, List<String> bank) {
    bank.add(start); //start is also a valid string mutation
    int n = bank.length;

    Queue<String> q = Queue();
    //to keep a track of visited strings from bank
    List<bool> visited = List.filled(n, false);
    visited[n - 1] = true; //marking index of "start" string as visited
    q.add(start);

    int stepCount = 0;
    while (q.isNotEmpty) {
      int size = q.length;
      //iterating level wise to keep a track of steps(levels of bfs)
      while (size-- != 0) {
        String curr = q.first;
        q.removeFirst();
        if (curr == end) return stepCount; //target found
        for (int i = 0; i < n; i++) {
          bool valid = isValid(curr, bank[i]);
          if (!valid || visited[i]) continue;

          visited[i] = true;
          q.add(bank[i]);
        }
      }
      stepCount++; //after each level stepCount is increased by 1
    }
    return -1;
  }
}

// DFS
class B {
// Runtime: 402 ms, faster than 100.00% of Dart online submissions for Minimum Genetic Mutation.
// Memory Usage: 140.4 MB, less than 100.00% of Dart online submissions for Minimum Genetic Mutation.
  bool isOneAway(String start, String end) {
    int count = 0;
    for (int i = 0; i < start.length && count < 2; i++) {
      if (start.codeUnitAt(i) != end.codeUnitAt(i)) {
        count++;
      }
    }
    return count == 1;
  }

  int backtrack(String start, String end, int count, List<String> bank,
      List<bool> visited) {
    if (start == end) {
      return 0;
    }
    int ans = double.maxFinite.toInt();
    for (int i = 0; i < bank.length; i++) {
      if (!visited[i] && isOneAway(start, bank[i])) {
        visited[i] = true;
        ans = min(ans, backtrack(bank[i], end, count + 1, bank, visited));
        visited[i] = false;
      }
    }
    if (ans == double.maxFinite.toInt()) {
      return ans;
    }
    return ans + 1;
  }

  int minMutation(String start, String end, List<String> bank) {
    List<bool> visited = List.filled(bank.length, false);
    int ans = backtrack(start, end, 0, bank, visited);
    return ans == double.maxFinite.toInt() ? -1 : ans;
  }
}
