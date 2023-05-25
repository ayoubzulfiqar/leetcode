# 🔥 New 21 Game 🔥 || 2 Solutions || Simple Fast and Easy || with Explanation

## Solution - 1

```dart
class Solution {
double new21Game(int n, int k, int maxPts) {
  // Corner cases
  if (k == 0) {
    return 1.0;
  }
  if (n >= k - 1 + maxPts) {
    return 1.0;
  }

  // dp[i] is the probability of getting point i.
  List<double> dp = List<double>.filled(n + 1, 0.0);

  double probability = 0.0; // dp of N or less points.
  double windowSum = 1.0; // Sliding required window sum
  dp[0] = 1.0;

  for (int i = 1; i <= n; i++) {
    dp[i] = windowSum / maxPts.toDouble();

    if (i < k) {
      windowSum += dp[i];
    } else {
      probability += dp[i];
    }

    if (i - maxPts >= 0) {
      windowSum -= dp[i - maxPts];
    }
  }

  return probability;
 }
}
```

## Solution - 2

```dart
import 'dart:math';

class CircularBuffer {
  late List<double> data;
  late int mask;

  CircularBuffer(int minSize) {
    final size = 1 << bitLen(minSize);
    mask = size - 1;
    data = List<double>.filled(size, 0.0);
  }

  double operator [](int index) {
    return data[index & mask];
  }

  void operator []=(int index, double value) {
    data[index & mask] = value;
  }

  int capacity() {
    return data.length;
  }

  static int bitLen(int minSize) {
    return 32 - minSize.bitLength;
  }
}

class Solution {
  double new21Game(int n, int k, int maxPts) {
    if (k == 0 || n - k + 1 >= maxPts) {
      return 1;
    }

    final kFactor = 1.0 / maxPts;
    if (maxPts + 1 >= n) {
      return ((pow(1 + kFactor, k - 1) / maxPts * (n - k + 1)) * 1e6).round() / 1e6;
    }

    final dp = CircularBuffer(maxPts + 1);
    dp[0] = 1;
    var sum = 1.0;

    for (int i = 1; i < k; ++i) {
      dp[i] = sum * kFactor;
      sum += dp[i] - dp[i - maxPts];
    }

    double answer = 0.0;

    for (int i = k; i <= n; ++i) {
      answer += sum * kFactor;
      sum -= dp[i - maxPts];
    }

    return (answer * 1e6).round() / 1e6;
  }
}
```
