/*

 -* Minimum Time to Make Rope Colorful *-

Alice has n balloons arranged on a rope. You are given a 0-indexed string colors where colors[i] is the color of the ith balloon.

Alice wants the rope to be colorful. She does not want two consecutive balloons to be of the same color, so she asks Bob for help. Bob can remove some balloons from the rope to make it colorful. You are given a 0-indexed integer array neededTime where neededTime[i] is the time (in seconds) that Bob needs to remove the ith balloon from the rope.

Return the minimum time Bob needs to make the rope colorful.



Example 1:


Input: colors = "abaac", neededTime = [1,2,3,4,5]
Output: 3
Explanation: In the above image, 'a' is blue, 'b' is red, and 'c' is green.
Bob can remove the blue balloon at index 2. This takes 3 seconds.
There are no longer two consecutive balloons of the same color. Total time = 3.
Example 2:


Input: colors = "abc", neededTime = [1,2,3]
Output: 0
Explanation: The rope is already colorful. Bob does not need to remove any balloons from the rope.
Example 3:


Input: colors = "aabaa", neededTime = [1,2,3,4,1]
Output: 2
Explanation: Bob will remove the balloons at indices 0 and 4. Each ballon takes 1 second to remove.
There are no longer two consecutive balloons of the same color. Total time = 1 + 1 = 2.


Constraints:

n == colors.length == neededTime.length
1 <= n <= 105
1 <= neededTime[i] <= 104
colors contains only lowercase English letters.


*/

import 'dart:collection';
import 'dart:math';

class A {
  // Runtime: 833 ms, faster than 100.00% of Dart online submissions for Minimum Time to Make Rope Colorful.
// Memory Usage: 195 MB, less than 100.00% of Dart online submissions for Minimum Time to Make Rope Colorful.
  int minCost(String colors, List<int> neededTime) {
    int sum = 0, maxSum = 0;
    for (int i = 0; i < colors.length; i++) {
      sum += neededTime[i];
      int max = neededTime[i], count = 0;
      for (int j = i + 1;
          j < colors.length && colors.codeUnitAt(i) == colors.codeUnitAt(j);
          j++) {
        sum += neededTime[j];
        count++;
        if (neededTime[j] > max) max = neededTime[j];
        i = j;
      }
      maxSum += max;
    }
    return sum - maxSum;
  }
}

class B {
// Runtime: 527 ms, faster than 100.00% of Dart online submissions for Minimum Time to Make Rope Colorful.
// Memory Usage: 203.6 MB, less than 100.00% of Dart online submissions for Minimum Time to Make Rope Colorful.
  int minCost(String colors, List<int> neededTime) {
    if (colors.length == 0) return 0;

    int prev = colors.codeUnitAt(0);
    int ans = 0;
    for (int i = 1; i < neededTime.length; i++) {
      if (colors.codeUnitAt(i) == prev) {
        int current = min(neededTime[i], neededTime[i - 1]);
        ans += current;
        neededTime[i] = max(neededTime[i], neededTime[i - 1]);
      } else {
        prev = colors.codeUnitAt(i);
      }
    }
    return ans;
  }
}

class C {
  // Correct but TLC
  int grp(List<int> nT, int l, int r) {
    int maxi = 0, sum = 0;
    for (int i = l; i <= r; i++) {
      sum += nT[i];
      maxi = max(maxi, nT[i]);
    }
    return sum - maxi;
  }

  int minCost(String colors, List<int> neededTime) {
    int n = colors.length;
    int cost = 0;
    for (int i = 0; i < n; i++) {
      int j = i + 1;

      //while (j != n && colors[i] == colors[j]) j++;
      while (j != n && colors.codeUnitAt(i) == colors.codeUnitAt(j)) j++;
      if (j != i + 1) {
        cost += grp(neededTime, i, j - 1);
        i = j - 1;
      }
    }
    return cost;
  }
}

class D {
  int minCost(String colors, List<int> neededTime) {
    int res = 0;
    int maxi = 0;
    for (int i = 0; i < colors.length; i++) {
      res += neededTime[i];
      maxi = max(maxi, neededTime[i]);
      // range error
      if (colors.codeUnitAt(i) != colors.codeUnitAt(i + 1)) {
        res -= maxi;
        maxi = 0;
      }
    }
    return res;
  }
}

class E {
/*
Basically what you need to do is:

get the sum of needed time to remove the all the consecutive balloons of the same color
while you are looping through them store the maximum value of needed time
if there are two or more consecutive balloons of the same color :
add their needed time sum to the result sum
subtract the maximum value of needed time sum from the result sum
return the sum after the loop finishes iteration
*/

// Runtime: 646 ms, faster than 100.00% of Dart online submissions for Minimum Time to Make Rope Colorful.
// Memory Usage: 203.2 MB, less than 100.00% of Dart online submissions for Minimum Time to Make Rope Colorful.

  int minCost(String colors, List<int> neededTime) {
    int sum = 0;

    for (int i = 1; i < neededTime.length; i++) {
      int tempSum = neededTime[i - 1];
      int max = neededTime[i - 1], count = 1;

      while (colors[i] == colors[i - 1]) {
        tempSum += neededTime[i];
        if (max < neededTime[i]) max = neededTime[i];
        i++;
        count++;
        if (i == neededTime.length) break;
      }
      if (count == 1) continue;
      sum += tempSum - max;
    }

    return sum;
  }
}

class F {
// Runtime: 706 ms, faster than 100.00% of Dart online submissions for Minimum Time to Make Rope Colorful.
// Memory Usage: 193.9 MB, less than 100.00% of Dart online submissions for Minimum Time to Make Rope Colorful.

  int minCost(String colors, List<int> neededTime) {
    int i = 1, sum = neededTime[0];
    int ans = 0, mx = sum;
    while (i < colors.length) {
      if (colors[i] == colors[i - 1]) {
        mx = max(mx, neededTime[i]);
        sum += neededTime[i];
      } else {
        sum -= mx;
        ans += sum;
        // cout<<sum<<endl;
        sum = neededTime[i];
        mx = sum;
      }
      i++;
    }
    if (sum != mx) {
      sum -= mx;
      ans += sum;
    }
    return ans;
  }
}

// class G {
//   int minCost(String colors, List<int> neededTime) {
//     List<Map<String, int>> rope = [].map((e) => <String, int>{}).toList();
//     for (int i = 0; i < colors.length; i++)
//       rope.add(<String, int>{
//         //  (colors.split("").elementAt(i), neededTime[i])
//       });

//     List<Map<String, int>> colorfulRope =
//         [].map((e) => <String, int>{}).toList();
//     int time = 0;
//     for (Map<String, int> baloon in rope) {
//       if (colorfulRope.isEmpty)
//         colorfulRope.add(baloon);
//       else {
//         Map<String, int> last = colorfulRope.elementAt(colorfulRope.length - 1);
//         if (last.keys == baloon.keys) {
//           if (last.values > baloon.values)
//             time += baloon.values;
//           else {
//             //colorfulRope.set(colorfulRope.size()-1, baloon);
//             colorfulRope.forEach((key, value) {
//               colorfulRope.add(colorfulRope.length - 1);

//             });

//             time += last.values;
//           }
//         } else
//           colorfulRope.add(baloon);
//       }
//     }
//     return time;
//   }
// }

/*

extension DefaultMap<K,V> on Map<K,V> {
  V getOrElse(K key, V defaultValue) {
    if (this.containsKey(key)) {
      return this[key];
    } else {
      return defaultValue;
    }
  }
}

*/

// class Pair<T1, T2> {
//   final T1 first;
//   final T2 second;
//   Pair(this.first, this.second);

//   bool operator ==(final Pair other) {
//     return first == other.first && second == other.second;
//   }

//   int get hashCode => hash2(first.hashCode, second.hashCode);
// }

// class H {
//   // outPut zero
//   int minCost(String colors, List<int> neededTime) {
//     int n = colors.length;
//     List<int> prefix = [n + 1];
//     for (int i = 1; i <= n; i++) {
//       prefix[i] = prefix[i - 1] + neededTime[i - 1];
//     }
//     int start = 0;
//     String prev = colors[0];
//     int end;
//     int maxi = neededTime[0];
//     Map<MapEntry<int, int>, int> vec = {}.map((key, value) => <int, int>{}.cast());
//     for (int i = 1; i < n; i++) {
//       if (colors[i] != prev) {
//         end = i - 1;
//         if (start != end) vec[{start, end}] = maxi;
//         start = i;
//         prev = colors[i];
//         maxi = neededTime[i];
//       } else {
//         maxi = max(maxi, neededTime[i]);
//       }
//     }
//     end = n - 1;
//     if (start != end) vec[{start, end}] = maxi;
//     int time = 0;
//     // must be iterable
//     for (var it in vec) {
//       int i = it.first.first;
//       int j = it.first.second;
//       int val = it.second;
//       time += (prefix[j + 1] - prefix[i] - val);
//     }
//     return time;
//   }
// }

class I {
  int minCost(String colors, List<int> neededTime) {
    int sum = 0;
    HashMap<String, int> myMap = HashMap();
    for (int i = 0; i < colors.split("").length; i++) {
      // range error
      if (colors[i].codeUnitAt(0) == colors[i + 1].codeUnitAt(0)) {
        if (myMap.containsValue(colors.codeUnitAt(i))) {
          int value = myMap.values.elementAt(colors.codeUnitAt(i));

          if (value <= neededTime[i]) {
            // myMap.set(colors[i],neededTime[i]);
            myMap.forEach((key, value) {
              key = colors[i];
              value = neededTime[i];
            });

            sum += value;
          } else if (value > neededTime[i]) {
            sum += neededTime[i];
          }
        } else {
          //myMap.set(colors[i],neededTime[i]);
          myMap.forEach((key, value) {
            key = colors[i];
            value = neededTime[i];
          });
        }
      } else {
        if (myMap.containsValue(colors.codeUnitAt(i))) {
          int value = myMap.values.elementAt(colors.codeUnitAt(i));
          if (value <= neededTime[i]) {
            // myMap.set(colors[i],neededTime[i]);
            myMap.forEach((key, value) {
              key = colors[i];
              value = neededTime[i];
            });
            sum += value;
          } else if (value > neededTime[i]) {
            sum += neededTime[i];
          }
        }

        myMap = HashMap();
      }
    }
    return sum;
  }
}
