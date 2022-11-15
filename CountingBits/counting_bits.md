# 🔥 Counting Bits 🔥 || 3 Approaches || Simple Fast and Easy || with Explanation

## Solution - 1

```dart
class Solution {
  List<int> countBits(int n) {
    List<int> f = List.filled(n + 1, 0);
    for (int i = 1; i <= n; i++) f[i] = f[i >> 1] + (i & 1);
    return f;
  }
}
```

## Solution - 2

```dart
class Solution {
  List<int> countBits(int n) {
    List<int> answer = List.filled(n + 1, 0);
    int offset = 1;
    for (int i = 1; i < answer.length; i++) {
      if (offset * 2 == i) offset *= 2;
      answer[i] = 1 + answer[i - offset];
    }
    return answer;
  }
}
```

## Solution - 3

```dart
class Solution {
  List<int> countBits(int n) {
    List<int> res = List.filled(n + 1, 0);

    for (int i = 0; i <= n; i++) {
      res[i] = solve(i, res);
    }
    return res;
  }

  int solve(int n, List<int> memo) {
    if (n == 0) return 0;
    if (n == 1) return 1;

    if (memo[n] != 0)
      // if memo of n answer is already available we will re-use it & not go further for calculation
      return memo[n];
    // but if you are coming for the first time then, store that value in memo
    if (n % 2 == 0) {
      memo[n] = solve(n ~/ 2, memo);
      return solve(n ~/ 2, memo);
    } else {
      memo[n] = 1 + solve(n ~/ 2, memo);
      return 1 + solve(n ~/ 2, memo);
    }
  }
}
```
