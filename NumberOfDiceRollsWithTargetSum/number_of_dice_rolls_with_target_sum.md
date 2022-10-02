# 🔥 Number of Dice Rolls With Target Sum 🔥 || 3 Solutions || Simple Fast and Easy || with Explanation

## Solution - 1 DP Tabulation Bottom Up

### Explanation

As an initial example, pretend we have 5 dice with 6 faces each and we want to determine how many ways to make 18.

In other words, what is dp(5, 6, 18)?

At first glance, this seems difficult and overwhelming. But if we make one simple observation, we can reduce this big problem into several smaller sub-problems. We have 5 dice, but let’s first just look at ONE of these dice (say the last one). This die can take on f=6 different values (1 to 6), so we consider what happens when we fix its value to each possibility (6 cases):

- Case 1: The last die is a 1. The remaining 4 dice must sum to 18-1=17. This can happen dp(4, 6, 17) ways.
- Case 2: The last die is a 2. The remaining 4 dice must sum to 18-2=16. This can happen dp(4, 6, 16) ways.
- Case 3: The last die is a 3. The remaining 4 dice must sum to 18-3=15. This can happen dp(4, 6, 15) ways.
- Case 4: The last die is a 4. The remaining 4 dice must sum to 18-4=14. This can happen dp(4, 6, 14) ways.
- Case 5: The last die is a 5. The remaining 4 dice must sum to 18-5=13. This can happen dp(4, 6, 13) ways.
- Case 6: The last die is a 6. The remaining 4 dice must sum to 18-6=12. This can happen dp(4, 6, 12) ways.

dp(5, 6, 18) = dp(4, 6, 17) + dp(4, 6, 16) + dp(4, 6, 15) + dp(4, 6, 14) + dp(4, 6, 13) + dp(4, 6, 12)

We sum up the solutions in these 6 cases to arrive at our result. Of course, each of these cases branches off into 6 cases of its own, and the recursion only resolves when d=0. The handling of this base case is explained below.
The general relation is:

dp(d, f, target) = dp(d-1, f, target-1) + dp(d-1, f, target-2) + … + dp(d-1, f, target-f)

The base case occurs when d = 0. We can make target=0 with 0 dice, but nothing else.
So dp(0, f, t) = 0 iff t != 0, and dp(0, f, 0) = 1.

Time Complexity
O(d *target* faces)

Space Complexity
O(d * target)

```dart
class Solution {
// Runtime: 529 ms, faster than 100.00% of Dart online submissions for Number of Dice Rolls With Target Sum.
// Memory Usage: 143.7 MB, less than 100.00% of Dart online submissions for Number of Dice Rolls With Target Sum.

  int numRollsToTarget(int n, int k, int target) {
    // int mod = (1e9 + 7).floor();
    int m = 1000000007;
    List<List<int>> dp =
        List.filled(n + 1, 0).map((e) => List.filled(target + 1, 0)).toList();
    dp[0][0] = 1;
    for (int i = 1; i <= n; i++) {
      for (int j = 1; j <= target; j++) {
        for (int r = 1; r <= k; r++) {
          if (r <= j) dp[i][j] = ((dp[i][j] % m) + (dp[i - 1][j - r] % m)) % m;
        }
      }
    }
    return dp[n][target];
  }
}
```

## Solution - 2 Memoization HashMap - TLC

```dart
class Solution {
  int numRollsToTarget(int n, int k, int target) {
    // mod value
   // int mod = (1e9 + 7).floor();
    int MOD = 1000000007;
    // HashMap to unique elements because we don't wanna repeat
    HashMap<int, int> mem = HashMap();
    // if our target and side is end up 0 than we will return 1
    if (n == 0 && target == 0) return 1;
    // if the face is OR the target is less or equal to zero return zeo
    if (n <= 0 || target <= 0) return 0;
    // our key in the HAsh map to hold the value
    int key = n + "_".codeUnitAt(0) + target;
    // if we find the we will simply return the key based on the index we have found
    if (mem.containsKey(key)) return mem.keys.elementAt(key);
    // holding our value
    int ans = 0;
    // loop to iterate through the target value and face value of the dice
    for (int i = 1; i <= k && i <= target; i++) {
      // getting the MOD recursively
      ans = (ans + numRollsToTarget(n - 1, k, target - i)) % MOD;
    }
    // putting the value inside our hashMap
    mem.forEach((key, value) {
      key = key;
      value = ans;
    });
    // return the value
    return ans;
  }
}
```

## Solution - 3 Recursive Brute Force - TLC

```dart
class Solution {
  /// > The number of ways to get to `target` using `n` dice with `k` sides is the sum of the number of
  /// ways to get to `target - 1` through `target - k` using `n - 1` dice with `k` sides
  ///
  /// Args:
  ///   n (int): number of dice
  ///   k (int): the maximum number that can be used in the sum
  ///   target (int): the sum of the numbers
  ///
  /// Returns:
  ///   The number of ways to sum to target using n numbers from 1 to k.
  int solve(int n, int k, int target) {
    if (n == 0 && target == 0) return 1;

    if (n <= 0 || target <= 0) return 0;

    int ans = 0;
    for (int i = 1; i <= k; i++) ans += solve(n - 1, k, target - i);

    return ans;
  }

  int numRollsToTarget(int n, int k, int target) {
    return solve(n, k, target);
  }
}
```
