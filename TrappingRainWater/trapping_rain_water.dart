/*

 -* Trapping Rain Water *-



Given n non-negative integers representing an elevation map where the width of each bar is 1, compute how much water it can trap after raining.



Example 1:


Input: height = [0,1,0,2,1,0,1,3,2,1,2,1]
Output: 6
Explanation: The above elevation map (black section) is represented by array [0,1,0,2,1,0,1,3,2,1,2,1].
In this case, 6 units of rain water (blue section) are being trapped.


Example 2:

Input: height = [4,2,0,3,2,5]
Output: 9


Constraints:

n == height.length
1 <= n <= 2 * 104
0 <= height[i] <= 105

*/

// Two Pointer Solution - Dart, O(n) time and O(1) space (with explanations).
import 'dart:collection';
import 'dart:math';

class A {
// Runtime: 481 ms, faster than 60.00% of Dart online submissions for Trapping Rain Water.
// Memory Usage: 145.7 MB, less than 40.00% of Dart online submissions for Trapping Rain Water.

  int trap(List<int> height) {
    // if you remove this condition than the solution will 100% faster
    if (height.isEmpty || height.length == 0) return 0;

    int left = 0;
    int right = height.length - 1; // Pointers to both ends of the array.
    int maxLeft = 0;
    int maxRight = 0;

    int totalWater = 0;
    while (left < right) {
      // Water could, potentially, fill everything from left to right, if there is nothing in between.
      if (height[left] < height[right]) {
        // If the current elevation is greater than the previous maximum, water cannot occupy that point at all.
        // However, we do know that everything from maxLeft to the current index, has been optimally filled, as we've
        // been adding water to the brim of the last maxLeft.
        if (height[left] >= maxLeft) {
          // So, we say we've found a new maximum, and look to see how much water we can fill from this point on.
          maxLeft = height[left];
          // If we've yet to find a maximum, we know that we can fill the current point with water up to the previous
          // maximum, as any more will overflow it. We also subtract the current height, as that is the elevation the
          // ground will be at.
        } else {
          totalWater += maxLeft - height[left];
        }
        // Increment left, we'll now look at the next point.
        left++;
        // If the height at the left is NOT greater than height at the right, we cannot fill from left to right without over-
        // flowing; however, we do know that we could potentially fill from right to left, if there is nothing in between.
      } else {
        // Similarly to above, we see that we've found a height greater than the max, and cannot fill it whatsoever, but
        // everything before is optimally filled
        if (height[right] >= maxRight) {
          // We can say we've found a new maximum and move on.
          maxRight = height[right];
          // If we haven't found a greater elevation, we can fill the current elevation with maxRight - height[right]
          // water.
        } else {
          totalWater += maxRight - height[right];
        }
        // Decrement left, we'll look at the next point.
        right--;
      }
    }
    // Return the sum we've been adding to.
    return totalWater;
  }
}

// Two Pointers Solution
class B {
// Runtime: 354 ms, faster than 100.00% of Dart online submissions for Trapping Rain Water.
// Memory Usage: 145.4 MB, less than 80.00% of Dart online submissions for Trapping Rain Water.

  int trap(List<int> height) {
    if (height.length < 3) return 0;

    int tallest = 0;
    for (int i = 1; i < height.length; i++)
      if (height[tallest] < height[i]) tallest = i;

    int water = 0;

    for (int i = 0, tall = 0; i < tallest; i++) {
      if (tall < height[i])
        tall = height[i];
      else
        water += tall - height[i];
    }
    for (int i = height.length - 1, tall = 0; i > tallest; i--) {
      if (tall < height[i])
        tall = height[i];
      else
        water += tall - height[i];
    }
    return water;
  }
}

// Short Version of above solution but not efficient
class C {
// Runtime: 726 ms, faster than 20.00% of Dart online submissions for Trapping Rain Water.
// Memory Usage: 147.5 MB, less than 20.00% of Dart online submissions for Trapping Rain Water.
  int trap(List<int> height) {
    int total = 0, high1 = 0, high2 = 0;
    for (int l = 0, r = height.length - 1; l < r;) {
      if (height[l] < height[r]) {
        high1 = max(high1, height[l]);
        total += high1 - height[l++];
      } else {
        high2 = max(high2, height[r]);
        total += high2 - height[r--];
      }
    }
    return total;
  }
}

// Stack Solution
class D {
// Runtime: 659 ms, faster than 20.00% of Dart online submissions for Trapping Rain Water.
// Memory Usage: 150.4 MB, less than 20.00% of Dart online submissions for Trapping Rain Water.

  int trap(List<int> height) {
    if (height.isEmpty && height.length < 3) return 0;
    Queue<int> s = Queue();
    int i = 0, maxWater = 0, maxBotWater = 0;
    while (i < height.length) {
      if (s.isEmpty || height[i] <= height[s.last]) {
        s.add(i++);
      } else {
        int bot = s.removeLast();
        maxBotWater = s.isEmpty
            ? // empty means no il
            0
            : (min(height[s.last], height[i]) - height[bot]) * (i - s.last - 1);
        maxWater += maxBotWater;
      }
    }
    return maxWater;
  }
}

class E {
//   Runtime: 556 ms, faster than 60.00% of Dart online submissions for Trapping Rain Water.
// Memory Usage: 146.1 MB, less than 40.00% of Dart online submissions for Trapping Rain Water.
  int trap(List<int> height) {
    if (height.isEmpty && height.length < 3) return 0;
    int l = 0, r = height.length - 1, level = 0, water = 0;
    while (l < r) {
      int lower = height[height[l] < height[r] ? l++ : r--];
      level = max(level, lower);
      water += level - lower;
    }
    return water;
  }
}

// Stack Solution
class F {
//   Runtime: 435 ms, faster than 100.00% of Dart online submissions for Trapping Rain Water.
// Memory Usage: 147.8 MB, less than 20.00% of Dart online submissions for Trapping Rain Water.
  int trap(List<int> height) {
    Queue<int> stack = Queue();
    int totalWater = 0;
    for (int right = 0; right < height.length; right++) {
      while (!stack.isEmpty && height[stack.last] < height[right]) {
        int bottom = stack.removeLast();
        if (stack.isEmpty) {
          break;
        }
        int left = stack.last;
        // Identified water trapped = width * height
        int water = (right - left - 1) *
            (min(height[right], height[left]) - height[bottom]);
        totalWater += water;
      }
      stack.add(right);
    }
    return totalWater;
  }
}

class G {
// Runtime: 382 ms, faster than 100.00% of Dart online submissions for Trapping Rain Water.
// Memory Usage: 149.4 MB, less than 20.00% of Dart online submissions for Trapping Rain Water.
  int trap(List<int> height) {
    // List<int> heightOne = [height.length];
    List<int> heightOne = List.filled(height.length, 0);
    // List<int> heightTwo = [height.length];
    List<int> heightTwo = List.filled(height.length, 0);
    int max = height[0];
    for (int i = 0; i < height.length; i++) {
      if (height[i] > max) max = height[i];
      heightOne[i] = max;
    }
    max = height[height.length - 1];
    for (int i = height.length - 1; i >= 0; i--) {
      if (height[i] > max) max = height[i];
      heightTwo[i] = max;
    }
    int sum = 0;
    for (int i = 0; i < height.length; i++) {
      sum = sum + (min(heightOne[i], heightTwo[i]) - height[i]);
    }
    return sum;
  }
}
