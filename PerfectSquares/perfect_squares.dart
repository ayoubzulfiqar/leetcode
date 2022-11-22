/*



-* 279. Perfect Squares *-

Given an integer n, return the least number of perfect square numbers that sum to n.

A perfect square is an integer that is the square of an integer; in other words, it is the product of some integer with itself. For example, 1, 4, 9, and 16 are perfect squares while 3 and 11 are not.



Example 1:

Input: n = 12
Output: 3
Explanation: 12 = 4 + 4 + 4.
Example 2:

Input: n = 13
Output: 2
Explanation: 13 = 4 + 9.


Constraints:

1 <= n <= 104


*/

import 'dart:collection';
import 'dart:math';

class A {
  // recursion TLE ut solution is perfect
  int helper(int n) {
    if (n == 0) return 0;
    int minimumCount = 104;
    for (int number = 1; number <= sqrt(n); number++) {
      int squareNumber = number * number;
      int currentCount = 1 + helper(n - squareNumber);
      minimumCount = min(minimumCount, currentCount);
    }
    return minimumCount;
  }

  int numSquares(int n) {
    return helper(n);
  }
}

class B {
  // TLE 2575ms which is large
  int numSquares(int n) {
    if (n == 0) return 0;
    int minimumCount = 104;
    for (int number = 1; number <= sqrt(n); number++) {
      int squareNumber = number * number;
      int currentCount = 1 + numSquares(n - squareNumber);
      minimumCount = min(minimumCount, currentCount);
    }
    return minimumCount;
  }
}

class C {
  // Memoization
  int helper(int n, List<int> dp) {
    if (n == 0) return 0;
    if (dp[n] != -1) return dp[n];

    int minimumCount = 104;
    for (int number = 1; number <= sqrt(n); number++) {
      int sqNum = number * number;
      int currCount = 1 + helper(n - sqNum, dp);
      minimumCount = min(minimumCount, currCount);
    }
    return dp[n] = minimumCount;
  }

  int numSquares(int n) {
    List<int> dp = List.filled(n + 1, -1);
    return helper(n, dp);
  }
}

class D {
  // Dp
  int helper(int n) {
    List<int> dp = List.filled(n + 1, 104);
    dp[0] = 0;
    for (int target = 1; target <= n; target++) {
      int mnCount = 104;
      for (int num = 1; num <= sqrt(target); num++) {
        int sqNum = num * num;
        int currCount = 1 + dp[target - sqNum];
        mnCount = min(mnCount, currCount);
      }
      dp[target] = mnCount;
    }
    return dp[n];
  }

  int numSquares(int n) {
    return helper(n);
  }
}

class E {
  // dfs
  int numSquares(int n) {
    Queue<int> q = Queue();
    HashSet<int> visited = HashSet();
    q.add(0);
    visited.add(0);
    int depth = 0;
    while (q.isNotEmpty) {
      int size = q.length;
      depth++;
      while (size-- > 0) {
        int u = q.removeLast();
        for (int i = 1; i * i <= n; i++) {
          int v = u + i * i;
          if (v == n) {
            return depth;
          }
          if (v > n) {
            break;
          }
          if (!visited.contains(v)) {
            q.add(v);
            visited.add(v);
          }
        }
      }
    }
    return depth;
  }
}

class F {
  // static dp
  int numSquares(int n) {
    if (n <= 0) {
      return 0;
    }

    // cntPerfectSquares[i] = the least number of perfect square numbers
    // which sum to i. Since cntPerfectSquares is a static vector, if
    // cntPerfectSquares.size() > n, we have already calculated the result
    // during previous function calls and we can just return the result now.
    List<int> cntPerfectSquares = ([0]);

    // While cntPerfectSquares.size() <= n, we need to incrementally
    // calculate the next result until we get the result for n.
    while (cntPerfectSquares.length <= n) {
      int m = cntPerfectSquares.length;
      int cntSquares = 104;
      for (int i = 1; i * i <= m; i++) {
        cntSquares = min(cntSquares, cntPerfectSquares[m - i * i] + 1);
      }

      cntPerfectSquares.add(cntSquares);
    }

    return cntPerfectSquares[n];
  }
}

class G {
  // math
  // Runtime: 310 ms, faster than 100.00% of Dart online submissions for Perfect Squares.
// Memory Usage: 158.6 MB, less than 20.00% of Dart online submissions for Perfect Squares.
  bool isSquare(int n) {
    int sqrt_n = sqrt(n).toInt();
    return (sqrt_n * sqrt_n) == n;
  }

  int numSquares(int n) {
    if (isSquare(n)) {
      return 1;
    }

    // The result is 4 if and only if n can be written in the
    // form of 4^k*(8*m + 7). Please refer to
    // Legendre's three-square theorem.
    while ((n & 3) == 0) // n%4 == 0
    {
      n >>= 2;
    }
    if ((n & 7) == 7) // n%8 == 7
    {
      return 4;
    }

    // Check whether 2 is the result.
    int sqrt_n = sqrt(n).toInt();
    for (int i = 1; i <= sqrt_n; i++) {
      if (isSquare(n - i * i)) {
        return 2;
      }
    }

    return 3;
  }
}

class H {
  // bfs
  int numSquares(int n) {
    if (n <= 0) {
      return 0;
    }

    // perfectSquares contain all perfect square numbers which
    // are smaller than or equal to n.
    List<int> perfectSquares = [];
    // cntPerfectSquares[i - 1] = the least number of perfect
    // square numbers which sum to i.
    List<int> cntPerfectSquares = List.filled(n, 0);

    // Get all the perfect square numbers which are smaller than
    // or equal to n.
    for (int i = 1; i * i <= n; i++) {
      perfectSquares.add(i * i);
      cntPerfectSquares[i * i - 1] = 1;
    }

    // If n is a perfect square number, return 1 immediately.
    if (perfectSquares.last == n) {
      return 1;
    }

    // Consider a graph which consists of number 0, 1,...,n as
    // its nodes. Node j is connected to node i via an edge if
    // and only if either j = i + (a perfect square number) or
    // i = j + (a perfect square number). Starting from node 0,
    // do the breadth-first search. If we reach node n at step
    // m, then the least number of perfect square numbers which
    // sum to n is m. Here since we have already obtained the
    // perfect square numbers, we have actually finished the
    // search at step 1.
    Queue<int> searchQ = Queue();
    for (int i in perfectSquares) {
      searchQ.add(i);
    }

    int currCntPerfectSquares = 1;
    while (searchQ.isNotEmpty) {
      currCntPerfectSquares++;

      int searchQSize = searchQ.length;
      for (int i = 0; i < searchQSize; i++) {
        int tmp = searchQ.first;
        // Check the neighbors of node tmp which are the sum
        // of tmp and a perfect square number.
        for (int j in perfectSquares) {
          if (tmp + j == n) {
            // We have reached node n.
            return currCntPerfectSquares;
          } else if ((tmp + j < n) && (cntPerfectSquares[tmp + j - 1] == 0)) {
            // If cntPerfectSquares[tmp + j - 1] > 0, this is not
            // the first time that we visit this node and we should
            // skip the node (tmp + j).
            cntPerfectSquares[tmp + j - 1] = currCntPerfectSquares;
            searchQ.add(tmp + j);
          } else if (tmp + j > n) {
            // We don't need to consider the nodes which are greater ]
            // than n.
            break;
          }
        }

        searchQ.removeFirst();
      }
    }

    return 0;
  }
}
