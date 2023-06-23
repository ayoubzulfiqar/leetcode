# 🔥 3 Solutions 🔥 || Simple Fast and Easy || with Explanation 😈


## Intuition
The intuition behind this solution is to use dynamic programming to find the length of the longest arithmetic subsequence in the given array. We iterate through each pair of indices (i, j), where i > j, and check if we can extend the arithmetic subsequence ending at index i by including the element at index j. We update the dynamic programming values based on the common difference between the elements at indices i and j. By keeping track of the maximum length encountered, we can find the length of the longest arithmetic subsequence in the array.

## Approach:
1. If n is less than or equal to 2, we can immediately return n as the answer since any two elements form a valid arithmetic subsequence.
2. We initialize the variable longest to 2, as explained earlier, the minimum length of an arithmetic subsequence is 2.
3. We create a 2D vector dp of size n, where each element is an unordered map. The purpose of dp is to store the dynamic programming values for the lengths of the arithmetic subsequences ending at each index with different common differences.
3. We iterate through each index i in the range [0, n-1]. This represents the current ending index of the arithmetic subsequences we are considering.
4. For each i, we iterate through all previous indices j in the range [0, i-1]. This allows us to check all the potential elements that can form an arithmetic subsequence with the element at index i.
5. We calculate the difference between the elements at indices i and j and store it in the variable diff. This difference represents the common difference of the potential arithmetic subsequence.
6. Next, we update dp[i][diff] based on whether we have seen a previous arithmetic subsequence ending at index j with a common difference of diff.
7. If dp[j].count(diff) returns true, it means we have encountered an arithmetic subsequence ending at index j with the common difference diff. In this case, we update dp[i][diff] to be dp[j][diff] + 1, which extends the subsequence and increments its length by 1.
8. If dp[j].count(diff) returns false, it means we haven't seen an arithmetic subsequence ending at index j with the common difference diff. In this case, we initialize dp[i][diff] to 2 because we have found a new arithmetic subsequence of length 2 (nums[j], nums[i]).
9. After updating dp[i][diff], we check if the current length dp[i][diff] is greater than the current longest arithmetic subsequence length longest. If so, we update longest to the new maximum length.
10. Once we finish iterating through all pairs of indices, we have computed the lengths of all possible arithmetic subsequences ending at each index. The maximum length among these subsequences is stored in longest, so we return it as the result.



## Solution - 1

```dart
import 'dart:collection';

class Solution {
  int longestArithSeqLength(List<int> nums) {
   final int n = nums.length;
    if (n <= 2) return n;

    int longest = 2;
   final List<HashMap<int, int>> dp =
        List<HashMap<int, int>>.generate(n, (index) => HashMap<int, int>());

    for (int i = 0; i < n; i++) {
      for (int j = 0; j < i; j++) {
        int diff = nums[i] - nums[j];
        dp[i][diff] = dp[j].containsKey(diff) ? dp[j][diff]! + 1 : 2;
        longest = longest > dp[i][diff]! ? longest : dp[i][diff]!;
      }
    }

    return longest;
  }
}
```

## Solution - 2

```dart
class Solution {
  int longestArithSeqLength(List<int> nums) {
   final int n = nums.length;
    int max = 0;
   final List<List<int>> dp = List.generate(n, (i) => List<int>.filled(1001, 0));

    for (int i = 1; i < n; i++) {
      for (int j = 0; j < i; j++) {
        int diff = nums[j] - nums[i] + 500;
        dp[i][diff] = dp[j][diff] + 1;
        max = max < dp[i][diff] ? dp[i][diff] : max;
      }
    }
    return max + 1;
  }
}
```

## Solution - 3 - Stay Away this one Contain BUG Intentional BUG 😈

```dart
class Solution {
  int longestArithSeqLength(List<int> nums) {
    Map<int, List<int>> hash = {};
    for (int i = 0; i < nums.length; i++) {
      if (!hash.containsKey(nums[i])) {
        hash[nums[i]] = [];
      }
      hash[nums[i]]!.add(i);
    }
    int maxCount = 0;
    for (int i = 0; i < nums.length; i++) {
      for (int j = i + 1; j < nums.length; j++) {
        int d = nums[j] - nums[i], ls = nums[j], cnt = 2, li = j;
        while (ls >= 0) {
          List<int>? v = hash[ls + d];
          if (d == 0) {
            cnt = v!.length;
            break;
          }
          if (v != null && v.length > 0) {
            int ind = v.indexOf(li);
            if (ind >= 0 && ind < v.length) {
              cnt++;
              ls += d;
              li = v[ind];
            } else {
              break;
            }
          } else {
            break;
          }
        }
        maxCount = max(maxCount, cnt);
      }
    }
    return maxCount;
  }
}
```
