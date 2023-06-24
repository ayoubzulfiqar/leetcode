# 🔥 3 Solutions 🔥 || Simple Fast and Easy || with Explanation 😈

## Solution - 1 Depth First Search

## Explanation

1. It starts by calculating the sum of all rod lengths in the rods vector and storing it in the variable sum.

2. An integer array dp is declared with a size of sum + 1 to store the maximum heights of billboards. The index of dp represents the height difference between the two billboards.

3. The first element of dp, dp[0], is initialized to 0 because having a height difference of 0 between the billboards means no rods are used.

4. All other elements in dp are initialized to -1 to indicate that their values have not been computed yet.

5. The code then iterates through each rod in the rods vector.

6. For each rod, it creates a copy of the dp array named dpCopy to keep track of the previous state.

7. It then iterates through all possible heights up to sum - rod, representing the height of the billboard without considering the current rod.

8. Inside the loop, it checks if the previous height dpCopy[i] is valid (not -1). If not, it skips the current iteration.

9. The code considers two cases for each height:

- Case 1: Placing the current rod on the same height billboard. It updates dp[i + rod] with the maximum value between its current value and the previous height dpCopy[i]. This case means the rod is added to the same height billboard, maintaining the height difference.

- Case 2: Placing the current rod on the taller billboard. It calculates the absolute difference between the current height i and the rod length using abs(i - rod). It updates dp[abs(i - rod)] with the maximum value between its current value and the previous height dpCopy[i] plus the minimum of i and the rod length. This case adjusts the height difference between the billboards.

10. Finally, the code returns the maximum height of the billboard stored at dp[0], which represents the perfectly balanced billboard height with no rods used.

```dart
class Solution {
  int tallestBillboard(List<int> rods) {
    int sum = 0;
    for (int rod in rods) {
      sum += rod;
    }

    List<int> dp = List<int>.filled(sum + 1, 0);
    dp[0] = 0;

    for (int i = 1; i <= sum; i++) {
      dp[i] = -1;
    }

    for (int rod in rods) {
      List<int> dpCopy = List<int>.from(dp);

      for (int i = 0; i <= sum - rod; i++) {
        if (dpCopy[i] < 0) continue;

        dp[i + rod] = max(dp[i + rod], dpCopy[i]);

        dp[(-i + rod).abs()] =
            max(dp[(-i + rod).abs()], dpCopy[i] + min(i, rod));
      }
    }

    return dp[0];
  }
}
```

## Solution - 2 HashMap

```dart
import 'dart:collection';

class Solution {
  int tallestBillboard(List<int> rods) {
    final HashMap<String, int> map = HashMap<String, int>();
    int sum = 0;
    for (int rod in rods) {
      sum += rod;
    }
    return helper(rods, 0, 0, sum, map);
  }

  int helper(
    List<int> rods,
    int index,
    int diff,
    int sum,
    HashMap<String, int> map,
  ) {
    if (index == rods.length) return (diff == 0) ? 0 : -2147483648;

    String key = '$index+$diff';

    if (map.containsKey(key)) return map[key]!;

    int exclude = helper(rods, index + 1, diff, sum, map);
    int taller =
        helper(rods, index + 1, diff + rods[index], sum, map) + rods[index];
    int shorter = helper(rods, index + 1, diff - rods[index], sum, map);

    int maxHeight = max(exclude, max(taller, shorter));

    map[key] = maxHeight;
    return maxHeight;
  }
}
```

## Solution - 3 Dynamic Programming

```dart
class Solution {
  int tallestBillboard(List<int> rods) {
    Map<int, int> dp = {0: 0};

    for (int r in rods) {
      Map<int, int> newDp = Map<int, int>.from(dp);

      for (MapEntry<int, int> e in dp.entries) {
        int diff = e.key;
        int taller = e.value;
        int shorter = taller - diff;

        int newTaller = newDp[diff + r] ?? 0;
        newDp[diff + r] = max(newTaller, taller + r);

        int newDiff = (shorter + r - taller).abs();
        int newTaller2 = max(shorter + r, taller);

        newDp[newDiff] = max(newTaller2, newDp[newDiff] ?? 0);
      }

      dp = newDp;
    }

    return dp[0] ?? 0;
  }
}
```
