# 🔥 FAST 🔥 || Simple Fast and Easy || with Explanation

## Intuition

Sorting with DP.

## Approach

Sort the Players on the basis of scores(Ascending) and break their ties on the basis of age(Ascending).

Now, we can select the players from left to right.

Create a dp array of length n, where dp[i], indicates the sum of scores of selected players on left of ith player + score of ith player.

For each player i, now search a player j on left which has maximum dp[j] value and age[j]<=age[i].

Fill dp[i] with searched value(if not found then 0) + current player score.

Get the max from dp.

## Complexity

### Time complexity: O(n^2)

### Space complexity: O(n)

```dart
class Solution {
  int bestTeamScore(List<int> scores, List<int> ages) {
    int n = scores.length;
    List<List<int>> players =
        List.filled(n, 0).map((e) => List.filled(2, 0)).toList();

    for (int i = 0; i < n; i++) {
      players[i][0] = scores[i];
      players[i][1] = ages[i];
    }

    // Sorting Players on the basis of scores(Ascending) and break their ties on the basis of age(Ascending)
    players.sort(
        (a, b) => a[0] == b[0] ? a[1].compareTo(b[1]) : a[0].compareTo(b[0]));

    List<int> dp = List.filled(n, 0);
    int maxi = 0;
    for (int i = 0; i < n; i++) {
      dp[i] = search(dp, players, i) + players[i][0];
      maxi = max(maxi, dp[i]);
    }

    return maxi;
  }

  int search(List<int> dp, List<List<int>> players, int i) {
    int maxi = 0;
    for (int j = 0; j < i; j++) {
      if (dp[j] > maxi && players[j][1] <= players[i][1]) {
        maxi = dp[j];
      }
    }
    return maxi;
  }
}
```
