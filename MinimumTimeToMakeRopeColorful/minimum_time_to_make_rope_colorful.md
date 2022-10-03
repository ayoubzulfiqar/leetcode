# 🔥 Minimum Time to Make Rope Colorful 🔥 || 4 Solutions || Simple Fast and Easy || with Explanation

## Solution - 1 Brute Force O(n)

```dart
class Solution {
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
```

## Solution - 2

```dart
class Solution {
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
```

## Solution - 3

### Basically what you need to do is

get the sum of needed time to remove the all the consecutive balloons of the same color
while you are looping through them store the maximum value of needed time
if there are two or more consecutive balloons of the same color :
add their needed time sum to the result sum
subtract the maximum value of needed time sum from the result sum
return the sum after the loop finishes iteration

```dart
class Solution {
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
```

## Solution - 4

```dart
class Solution {
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
        // count<<sum<<endless;
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
```

## Solution - 5

### Working on this Solution wait of updates. Any help would be appreciated

```dart
class I {
  int minCost(String colors, List<int> neededTime) {
    int sum = 0;
    HashMap<String, int> myMap = HashMap();
    for (int i = 0; i < colors.split("").length; i++) {
      // range error
      if (colors[i] == colors[i + 1]) {
        if (myMap.containsValue(colors.codeUnitAt(i))) {
          int value = myMap.values.elementAt(colors.codeUnitAt(i));

          if (value <= neededTime[i]) {

            myMap.forEach((key, value) {
              key = colors[i];
              value = neededTime[i];
            });

            sum += value;
          } else if (value > neededTime[i]) {
            sum += neededTime[i];
          }
        } else {

          myMap.forEach((key, value) {
            key = colors[i];
            value = neededTime[i];
          });
        }
      } else {
        if (myMap.containsValue(colors.codeUnitAt(i))) {
          int value = myMap.values.elementAt(colors.codeUnitAt(i));
          if (value <= neededTime[i]) {

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

```
