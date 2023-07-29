# 🔥 3 Solutions 🔥 || Simple Fast and Easy || with Explanation 😈

## **Intuition:**
The problem requires calculating the probability of serving soup A and soup B such that they are consumed simultaneously. The probability depends on the amount of soup served from each bowl and the rules for how much soup can be served in each step. We can solve this problem using a recursive approach with memoization, which avoids redundant calculations by storing the results of subproblems in a HashMap.

## **Approach:**
1. We first check if the value of `n` is greater than or equal to 5000. If it is, we return 1.0 because, in this case, the probability of serving the soup is very close to 1.0, and further computation is not necessary.
2. For `n` values less than 5000, we initialize a HashMap called `dp` to store the results of previously computed subproblems. The key for the HashMap is a string representation of the current soup amounts in both bowls (`soupA.toString() + "-" + soupB.toString()`), and the value is the probability calculated for that soup combination.
3. We call the `solve` function with the initial amount of soup in both bowls (`n, n`) and pass the `dp` HashMap as well.
4. The `solve` function is a recursive function that calculates the probability of serving the soup for a given amount of soup in each bowl. It checks for the base cases where either of the bowls is empty or both are empty and returns the appropriate probability.
5. If the result for the current combination of soup amounts exists in the `dp` HashMap, we retrieve and return it to avoid redundant computation.
6. If the result is not in the `dp` HashMap, we calculate the probability by recursively calling the `solve` function for four different scenarios based on the rules of serving soup from both bowls. We add the probabilities of these four scenarios, weighted by 0.25 each (as there are four scenarios with equal probabilities), to get the final probability for the current soup combination.
7. After calculating the probability, we store it in the `dp` HashMap with the corresponding key before returning it.

## **Space Complexity:**
The space complexity is O(n^2) because we use a HashMap (`dp`) to store results for all unique combinations of soup amounts.

## **Time Complexity:**
The time complexity is O(n^2) because the `solve` function is called recursively for all possible combinations of soup amounts in the range of 1 to n, and each combination is calculated only once and then stored in the `dp` HashMap for future use. Thus, the time complexity is proportional to the number of unique subproblems, which is O(n^2).
# Memoization + Dynamic Programming
```dart
import 'dart:collection';

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
```

# Depth First Search + Recursion

## **Intuition:**
The problem requires calculating the probability of serving soup A and soup B such that they are consumed simultaneously. The probability depends on the amount of soup served from each bowl and the rules for how much soup can be served in each step. The provided code solves this problem using a depth-first search (DFS) with memoization to avoid redundant calculations.

## **Approach:**

1. The code defines a class named `Solution` with a 2D list called `dp` (dimension 200x200) to store the memoized results of the DFS calculations. The `dp` list is initialized with all zeros.

2. The `depthFirstSearch` function is a recursive function that calculates the probability of serving the soup for a given amount of soup in each bowl.
3. The base cases of the recursion check whether either of the bowls is empty, and if so, return the appropriate probability (0, 0.5, or 1).
4. If the probability for the current soup combination (`soupA`, `soupB`) is already calculated and stored in the `dp` list, the function directly returns the result to avoid redundant calculations.
5. If the result is not memoized, the function calculates the probability by recursively calling itself for four different scenarios based on the rules of serving soup from both bowls. It calculates the probabilities for the four scenarios and then returns the average of these four probabilities (weighted by 0.25 each) as the final probability for the current soup combination.
6. After calculating the probability, the function stores it in the `dp` list at the corresponding index before returning it.
7. The `soupServings` function is the entry point to the solution. It checks whether the input `n` is greater than 4800.0. If it is, it returns 1.0 directly because the probability of serving the soup is very close to 1.0 in such cases, and further computation is not necessary.
8. If `n` is less than or equal to 4800.0, the function reduces `n` to the nearest multiple of 25 (by adding 24 and then using integer division by 25). It then calls the `depthFirstSearch` function with the updated `n` value for both bowls, and it returns the result of the DFS.

## **Space Complexity:**

The space complexity is O(n^2) because of the `dp` list, which has a size of 200x200.

## **Time Complexity:**

The time complexity is O(n^2) because the `depthFirstSearch` function is called recursively for all possible combinations of soup amounts in the range of 1 to n. Each combination is calculated only once and then stored in the `dp` list for future use. Thus, the time complexity is proportional to the number of unique subproblems, which is O(n^2).

```dart
class Solution {
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
```

## Recursion - TLE

```dart
class Solution {
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
```
