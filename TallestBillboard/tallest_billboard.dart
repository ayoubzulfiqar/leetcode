/*


-* 956. Tallest Billboard *-


You are installing a billboard and want it to have the largest height. The billboard will have two steel supports, one on each side. Each steel support must be an equal height.

You are given a collection of rods that can be welded together. For example, if you have rods of lengths 1, 2, and 3, you can weld them together to make a support of length 6.

Return the largest possible height of your billboard installation. If you cannot support the billboard, return 0.

 

Example 1:

Input: rods = [1,2,3,6]
Output: 6
Explanation: We have two disjoint subsets {1,2,3} and {6}, which have the same sum = 6.
Example 2:

Input: rods = [1,2,3,4,5,6]
Output: 10
Explanation: We have two disjoint subsets {2,3,5} and {4,6}, which have the same sum = 10.
Example 3:

Input: rods = [1,2]
Output: 0
Explanation: The billboard cannot be supported, so we return 0.
 

Constraints:

1 <= rods.length <= 20
1 <= rods[i] <= 1000
sum(rods[i]) <= 5000

*/

import 'dart:collection';
import 'dart:math';

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

class B {
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

class C {
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
