# 🔥 4 Approaches 🔥 || Simple Fast and Easy || with Explanation

## Solution - 1

```dart
class Solution {
  int maxIceCream(List<int> costs, int coins) {
    costs.sort();
    int i = 0;
    while (i < costs.length && coins >= costs[i]) {
      coins -= costs[i++];
    }
    return i;
  }
}
```

## Solution - 2

```dart
class Solution {
  int maxIceCream(List<int> costs, int coins) {
    int ans = 0;
    costs.sort();
    for (int cost in costs) {
      coins -= cost;
      if (coins < 0) {
        break;
      }
      ans++;
    }
    return ans;
  }
}
```

## Solution - 3

```dart
class Solution {
  int maxIceCream(List<int> costs, int coins) {
    int n = costs.length;
    int ans = 0;
    costs.sort();
    for (int i = 0; i < n; i++) {
      if (ans + costs[i] > coins) return i;
      ans += costs[i];
    }
    return costs.length;
  }
}
```

## Solution - 4

```dart
class Solution {
  int maxIceCream(List<int> costs, int coins) {
    costs.sort();
    int result = 0;
    int sum = 0;
    for (int cost in costs) {
      sum += cost;
      if (sum > coins) {
        return result;
      }
      result++;
      if (sum == coins) {
        return result;
      }
    }
    return result;
  }
}
```
