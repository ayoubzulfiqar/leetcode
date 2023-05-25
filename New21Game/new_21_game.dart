/*

- New 21 Game -



Alice plays the following game, loosely based on the card game "21".

Alice starts with 0 points and draws numbers while she has less than k points. During each draw, she gains an integer number of points randomly from the range [1, maxPts], where maxPts is an integer. Each draw is independent and the outcomes have equal probabilities.

Alice stops drawing numbers when she gets k or more points.

Return the probability that Alice has n or fewer points.

Answers within 10-5 of the actual answer are considered accepted.

 

Example 1:

Input: n = 10, k = 1, maxPts = 10
Output: 1.00000
Explanation: Alice gets a single card, then stops.
Example 2:

Input: n = 6, k = 1, maxPts = 10
Output: 0.60000
Explanation: Alice gets a single card, then stops.
In 6 out of 10 possibilities, she is at or below 6 points.
Example 3:

Input: n = 21, k = 17, maxPts = 10
Output: 0.73278
 

Constraints:

0 <= k <= n <= 104
1 <= maxPts <= 104


*/


// class Solution {
//   double new21Game(int n, int k, int maxPts) {
// return 300.0;
//   }
// }


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




