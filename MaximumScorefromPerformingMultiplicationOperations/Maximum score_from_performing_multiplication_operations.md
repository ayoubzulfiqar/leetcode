# ️‍🔥 Dart ️‍🔥 || 4 solutions || line by line explanation

## Explanation

It is easy to see that our current decision will affect the future decisions depends on our multiplications by a left or right elements of the current nums. This is the sense of using DP when future similar problems depends on the current problems.

At state i:

If we use the elements left of nums. Then in the next state, we can use only the rest of nums which start from left+1 to right

```dart
dp[i] = multipliers[i] * nums[left] + dp(i+1, left+1, right)
```

If we use the elements right of nums. Then in the next state, we can use only the rest of nums which start from left to right-1

```dart
dp[i] = multipliers[i] * nums[right] + dp(i+1, left, right-1)
```

We will choose only the option with the maximum total. That means our recurrence relation is:

```dart
dp(i, left, right) = max(
    multipliers[i] * nums[left] + dp(i+1, left+1, right),
    multipliers[i] * nums[right] + dp(i+1, left, right - 1)
)
```

Nevertheless, we can reduce the right variable because at state i, you used totally i elements from nums with left elements from the left side, so you used (i – left ) elements from the right side
=> right = (N – 1) – (i – left)

Remove right in the recurrence relation, we have:

```dart
right = (N - 1) - (i + left)
dp(i, left) = max(
    multipliers[i] * nums[left] + dp(i+1, left+1),
    multipliers[i] * nums[right] + dp(i+1, left)
)
```

## Solution - 1 Recursive Approach

```dart
class Solution {
  int maximumScore(List<int> nums, List<int> multipliers) {
// Runtime: 846 ms, faster than 100.00% of Dart online submissions for Maximum Score from Performing Multiplication Operations.
// Memory Usage: 159.6 MB, less than 100.00% of Dart online submissions for Maximum Score from Performing Multiplication Operations.

    int n = nums.length, m = multipliers.length;
    List<int> dp = List.filled(m + 1, 0);
    // let's think backwards
    for (int i = 0; i < m; i++) {
      // at round m, we  pick the m-th multiplier
      // at round m - 1, we pick the (m - 1)-th multiplier
      // at round m - 2, we pick the (m - 2)-th multiplier
      // and so on ...
      int multi = multipliers[m - 1 - i];
      // how many elements we need to process?
      // at round m, there are m elements
      // at round m - 1, there are m - 1 elements
      // at round m - 2, there are m - 2 elements
      // and so on ...
      for (int j = 0; j < m - i; j++) {
        // so we take the max of
        dp[j] = max(
          // the start
          multi * nums[j] + dp[j + 1],
          // the end
          multi * nums[j + (n - (m - i))] + dp[j],
        );
      }
    }
    return dp[0];
  }
}
```

## Solution - 2 Bottom Up Approach O(n) Space

Because we only need the values from row(i+1) to calculate the value from row(i) so we don't need to use a 2D array for dp.

```dart
class Solution {
// Runtime: 783 ms, faster than 100.00% of Dart online submissions for Maximum Score from Performing Multiplication Operations.
// Memory Usage: 159.9 MB, less than 100.00% of Dart online submissions for Maximum Score from Performing Multiplication Operations.

  int maximumScore(List<int> nums, List<int> multipliers) {
    List<int> dp = List.filled(multipliers.length + 1, 0);

    var dpLeft = 0;
    for (int i = multipliers.length - 1; i >= 0; i--) {
      for (int left = i; left >= 0; left--) {
        int temp = dp[left];
        dp[left] = max(multipliers[i] * nums[left] + dpLeft,
            multipliers[i] * nums[(nums.length - 1) - (i - left)] + dp[left]);
        dpLeft = temp;
      }
      dpLeft = dp[i];
    }
    return dp[0];
  }
}
```

## Solution - 3 Bottom Up Approach

At state i, the max
ium left elements of nums you can use is nums[i]. That means you have i options to multiply for this state.
We just need to iterate through all cases and get the maximum result.

```dart
class Solution {
// Runtime: 816 ms, faster than 100.00% of Dart online submissions for Maximum Score from Performing Multiplication Operations.
// Memory Usage: 193.5 MB, less than 100.00% of Dart online submissions for Maximum Score from Performing Multiplication Operations.

  int maximumScore(List<int> nums, List<int> multipliers) {
    List<List<int>> memo = List.filled(multipliers.length + 1, 0)
        .map((e) => List.filled(multipliers.length + 1, 0))
        .toList();

    // starting point will be from the end
    for (int i = multipliers.length - 1; i >= 0; i--) {
      // at state i, used i elements from nums
      // and left nums.length - i consecutive elements
      // those consecutive elements can be seen as the rest block
      // the left of the rest block can be any where from i to 0
      // whereas the left element that this state can use is from the rest block
      // so left = i to 0;
      for (int left = i; left >= 0; left--) {
        int right = (nums.length - 1) - (i - left);

        // calculate all possible cases for state i
        // each case will combine with each case of state i - 1 and so on
        memo[i][left] = max(multipliers[i] * nums[left] + memo[i + 1][left + 1],
            multipliers[i] * nums[right] + memo[i + 1][left]);
      }
    }

    // finish the calculation and
    // return the last case that we calculated
    return memo[0][0];
  }
}
```

## Solution - 4 Top-Down Approach _ Recursive

```dart
class Solution {

// 49 / 50 test cases passed.
// Status: Time Limit Exceeded
// Submitted: 0 minutes ago
// Last executed input:
// [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]
// [1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1]

  int maximumScore(List<int> nums, List<int> multipliers) {
    // use array to save the time of processing
    var memo = List.filled(multipliers.length, -1)
        .map((e) => List.filled(multipliers.length, -1))
        .toList();
    // recursing function
    int multiply(int left, int i) {
      // when you used all multipliers
      if (multipliers.length == i) {
        return 0;
      }

      // get right from left:
      // you used i multipliers,
      // left of them are on the left
      // so the rest will be on the right side
      int right = (nums.length - 1) - (i - left);

      // already calculated before
      if (-1 != memo[i][left]) {
        return memo[i][left];
      }

      // at i, you have two options:
      // multiply with a left or right elements from nums
      // if you choose left,
      // you should use the total points earned till the prev left
      // because in order for you to choose that current left,
      // the previous left should be used
      // same for the right.
      // Then choose the max value
      return memo[i][left] = max(
          multipliers[i] * nums[left] + multiply(left + 1, i + 1),
          multipliers[i] * nums[right] + multiply(left, i + 1));
    }

    // start point
    return multiply(0, 0);
  }
}

```
