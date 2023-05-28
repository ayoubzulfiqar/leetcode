# 🔥 Minimum Cost to Cut a Stick 🔥 || 3 Approaches || Simple Fast and Easy || with Explanation

## Explanation

1. The function `minCost` takes an integer `n` (representing the length of the stick) and a list of integers `cuts` (representing the positions where the stick needs to be cut).
2. The code begins by creating a new list `combinedCuts` and populating it with the elements from the `cuts` list, appending `0` at the beginning and `n` at the end. This list represents all the cut positions, including the start and end points of the stick.
3. The `combinedCuts` list is then sorted in ascending order, ensuring that the cut positions are in increasing order.
4. The variable `m` is assigned the length of the `combinedCuts` list.
5. The `dp` list is initialized as a 2D list with dimensions `m` x `m`, where each element is initially set to `0`. This list will store the minimum cost for cutting the stick between different positions.
6. Next, a nested loop is used to fill the `dp` table. The outer loop iterates over the lengths of the cut ranges (starting from 2), and the inner loop iterates over the start positions of the cut ranges.
7. Inside the nested loops, the variable `j` is calculated as `i + length`, representing the end position of the cut range.
8. The `dp[i][j]` value is initialized to infinity (`double.infinity.toInt()`), indicating that it hasn't been computed yet.
9. Another loop iterates over the possible cut positions within the range (`k` ranges from `i + 1` to `j - 1`).
10. For each `k`, the code compares the current `dp[i][j]` value with the sum of `dp[i][k]`, `dp[k][j]`, and the cost of cutting the stick between positions `combinedCuts[j]` and `combinedCuts[i]`.
11. If the new sum is smaller than the current `dp[i][j]` value, it updates `dp[i][j]` with the new sum.
12. Once all the iterations are completed, the minimum cost to cut the entire stick is stored in `dp[0][m - 1]`.
13. The function returns the minimum cost.

## Time Complexity

The time complexity of this code is O(n^3), where n is the length of the `cuts` list. This is because there are three nested loops: one for the lengths of the cut ranges, one for the start positions, and one for the possible cut positions within each range. Since each loop can iterate up to `n` times, the overall time complexity is O(n^3).

## Solution - 1

```dart
class Solution {
  int minCost(int n, List<int> cuts) {
    cuts
      ..add(0)
      ..add(n);
    int m = cuts.length;
    cuts.sort();
    List<List<int>> dp = List.generate(m, (_) => List<int>.filled(m, -1));

/*
 I've defined maxIntValue as 1 << 30, 
 which represents a large integer value that can act as a substitute for infinity in this context. 
*/
    final int maxIntValue = 1 << 30; // Define a large constant value

    int cost(int i, int j) {
      if (j - i <= 1) return 0;
      if (dp[i][j] != -1) return dp[i][j];
      int result = maxIntValue;
      for (int k = i + 1; k < j; k++) {
        result =
            result < cost(i, k) + cost(k, j) ? result : cost(i, k) + cost(k, j);
      }
      return dp[i][j] = result + (cuts[j] - cuts[i]);
    }

    return cost(0, m - 1);
  }
}
```

## Solution - 2

```dart
class Solution {
  int minCost(int n, List<int> cuts) {
    List<int> combinedCuts = List<int>.from(cuts);
    combinedCuts
      ..add(0)
      ..add(n);
    combinedCuts.sort();
    int m = combinedCuts.length;

    List<List<int>> dp = List.generate(m, (_) => List<int>.filled(m, 0));

    for (int length = 2; length < m; length++) {
      for (int i = 0; i < m - length; i++) {
        int j = i + length;
        dp[i][j] = 1 << 30;
        for (int k = i + 1; k < j; k++) {
          dp[i][j] =
              dp[i][j] < dp[i][k] + dp[k][j] + combinedCuts[j] - combinedCuts[i]
                  ? dp[i][j]
                  : dp[i][k] + dp[k][j] + combinedCuts[j] - combinedCuts[i];
        }
      }
    }

    return dp[0][m - 1];
  }
}
```
