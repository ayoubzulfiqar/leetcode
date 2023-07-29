/*


-* 808. Soup Servings *-



There are two types of soup: type A and type B. Initially, we have n ml of each type of soup. There are four kinds of operations:

Serve 100 ml of soup A and 0 ml of soup B,
Serve 75 ml of soup A and 25 ml of soup B,
Serve 50 ml of soup A and 50 ml of soup B, and
Serve 25 ml of soup A and 75 ml of soup B.
When we serve some soup, we give it to someone, and we no longer have it. Each turn, we will choose from the four operations with an equal probability 0.25. If the remaining volume of soup is not enough to complete the operation, we will serve as much as possible. We stop once we no longer have some quantity of both types of soup.

Note that we do not have an operation where all 100 ml's of soup B are used first.

Return the probability that soup A will be empty first, plus half the probability that A and B become empty at the same time. Answers within 10-5 of the actual answer will be accepted.

 

Example 1:

Input: n = 50
Output: 0.62500
Explanation: If we choose the first two operations, A will become empty first.
For the third operation, A and B will become empty at the same time.
For the fourth operation, B will become empty first.
So the total probability of A becoming empty first plus half the probability that A and B become empty at the same time, is 0.25 * (1 + 1 + 0.5 + 0) = 0.625.
Example 2:

Input: n = 100
Output: 0.71875
 

Constraints:

0 <= n <= 109

*/

import 'dart:collection';

// Recursion is BAD in Dart

class A {
  double soupServings(int n) {
    double ans = solve(n, n);
    return ans;
  }

  double solve(int soupA, int soupB) {
    if (soupA <= 0 && soupB <= 0) return 0.5;
    if (soupA <= 0) return 1.0;
    if (soupB <= 0) return 0.0;

    double prob = 0.0;
    prob += 0.25 * solve(soupA - 100, soupB);
    prob += 0.25 * solve(soupA - 75, soupB - 25);
    prob += 0.25 * solve(soupA - 50, soupB - 50);
    prob += 0.25 * solve(soupA - 25, soupB - 75);

    return prob;
  }
}

// Memoization - Dynamic Programming
class Solution {
  double soupServings(int n) {
    if (n >= 5000) return 1.0;
    final HashMap<String, double> dp = HashMap();
    double ans = solve(n, n, dp);
    return ans;
  }

  double solve(
      final int soupA, final int soupB, final HashMap<String, double> dp) {
    if (soupA <= 0 && soupB <= 0) return 0.5;
    if (soupA <= 0) return 1.0;
    if (soupB <= 0) return 0.0;

    String key = soupA.toString() + "-" + soupB.toString();
    if (dp.containsKey(key)) return dp[key] ?? 0;

    double prob = 0.0;
    prob += 0.25 * solve(soupA - 100, soupB, dp);
    prob += 0.25 * solve(soupA - 75, soupB - 25, dp);
    prob += 0.25 * solve(soupA - 50, soupB - 50, dp);
    prob += 0.25 * solve(soupA - 25, soupB - 75, dp);

    dp[key] = prob;
    return prob;
  }
}

// Depth First Search

class B {
  final List<List<double>> dp =
      List.generate(200, (_) => List.filled(200, 0.0));

  double depthFirstSearch(int soupA, int soupB) {
    if (soupA <= 0 && soupB <= 0) return 0.5;
    if (soupA <= 0) return 1.0;
    if (soupB <= 0) return 0.0;
    if (dp[soupA][soupB] > 0) return dp[soupA][soupB];
    return dp[soupA][soupB] = (depthFirstSearch(soupA - 4, soupB) +
            depthFirstSearch(soupA - 3, soupB - 1) +
            depthFirstSearch(soupA - 2, soupB - 2) +
            depthFirstSearch(soupA - 1, soupB - 3)) /
        4;
  }

  double soupServings(int n) {
    if (n > 4800.0) return 1.0;
    n = (n + 24.0) ~/ 25.0;
    return depthFirstSearch(n, n);
  }
}
