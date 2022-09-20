/*



  -*  Climbing Stairs *-

You are climbing a staircase. It takes n steps to reach the top.

Each time you can either climb 1 or 2 steps. In how many distinct ways can you climb to the top?



Example 1:

Input: n = 2
Output: 2
Explanation: There are two ways to climb to the top.
1. 1 step + 1 step
2. 2 steps


Example 2:

Input: n = 3
Output: 3
Explanation: There are three ways to climb to the top.
1. 1 step + 1 step + 1 step
2. 1 step + 2 steps
3. 2 steps + 1 step


Constraints:

1 <= n <= 45

*/

import 'dart:math';

class Algorithmic {
  int climbStairs(int n) {
    if (n == 0 || n == 1 || n == 2 || n == 3) {
      return n;
    }
    int sum = 0;
    int left = 1;
    int right = 2;
    for (int i = 2; i < n; i++) {
      sum = left + right;
      left = right;
      right = sum;
    }
    return sum;
  }
}

class Recursive {
  // Recursive
  int climbStairs(int n) {
    //handle invalid cases
    if (n < 0) return 0;
    //base case 1: if reached 0 or 1-> 1
    if (n == 0 || n == 1) return 1;
    //the current position will be the sum of the last two ones
    return climbStairs(n - 1) + climbStairs(n - 2);
  }
}

class Mathematical {
// Using Math

// Runtime: 306 ms, faster than 97.73% of Dart online submissions for Climbing Stairs.
// Memory Usage: 155.3 MB, less than 13.64% of Dart online submissions for Climbing Stairs.

  int climbStairs(int n) {
    return ((1 / sqrt(5.0)) *
            (pow((1 + sqrt(5)) / 2, n + 1) - pow((1 - sqrt(5)) / 2, n + 1)))
        .toInt();
  }
}

class MemoryEfficientTabulation {
  //  Memory Efficient Tabulation
//   Runtime: 452 ms, faster than 43.18% of Dart online submissions for Climbing Stairs.
// Memory Usage: 140.2 MB, less than 79.55% of Dart online submissions for Climbing Stairs.
  int climbStairs(int n) {
    int stair1 = 1;
    int stair2 = 1;

    for (int i = 2; i <= n; i++) {
      int stair = stair1 + stair2;
      stair1 = stair2;
      stair2 = stair;
    }

    return stair2;
  }
}

class Tabulation {
// Runtime: 484 ms, faster than 31.82% of Dart online submissions for Climbing Stairs.
// Memory Usage: 140.3 MB, less than 70.45% of Dart online submissions for Climbing Stairs.

  int climbStairs(int n) {
    //initialize two variables base cases
    int one = 1, two = 1;
    //loop until reaching the given number
    for (int i = 2; i <= n; i++) {
      //save the one value in temp variable
      int temp = one;
      //update the one value by adding the last one and current two values
      one += two;
      //update the two value by the old one variable value
      two = temp;
    }
    //return the last reached value
    return one;
  }
}

class Memoization {
  int stairs(int n, List<int> stair) {
    if (n <= 1) {
      stair[n] = 1;
      return 1;
    }

    if (stair[n] != -1) {
      return stair[n];
    }

    int one = stairs(n - 1, stair);
    int two = stairs(n - 2, stair);

    stair[n] = one + two;

    return one + two;
  }

  int climbStairs(int n) {
    List<int> stair = [n + 1, -1];
    stairs(n, stair);
    return stair[n];
  }
}
