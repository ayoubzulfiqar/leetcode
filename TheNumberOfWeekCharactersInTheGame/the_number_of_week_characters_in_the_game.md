# ✅ Dart | Sorting (NlogN) Approach | The Number of Week Characters In The Game

## Runtime

  Runtime: 1538 ms, faster than 100.00% of Dart online submissions for The Number of Weak Characters in the Game.

## Memory Usage

  Memory Usage: 252.2 MB, less than 100.00% of Dart online submissions for The Number of Weak Characters in the Game.

```dart
class Solution {
  // Runtime: 1538 ms, faster than 100.00% of Dart online submissions for The Number of Weak Characters in the Game.
  // Memory Usage: 252.2 MB, less than 100.00% of Dart online submissions for The Number of Weak Characters in the Game.
  int numberOfWeakCharacters(List<List<int>> properties) {
    // Whole length of nested list
    int n = properties.length;
    // sorting the nested list
    properties.sort((a, b) => a[0] == b[0] ? b[1] - a[1] : a[0] - b[0]);
    // to get get the second lastValue based on Index
    int secondLastValue = n - 2;
    // maximum value
    int maximumValue = properties[n - 1][1];
    // to hold our result
    int result = 0;
    // iterating the values
    //  if i is same as secondLast value and it's equal and less than zero
    // than we will decrement the i
    for (int i = secondLastValue; i >= 0; i--) {
      // if the both values in nested list is less than maximum value as above
      if (properties[i][1] < maximumValue) {
        // than we will add the  value in our result
        result += 1;
      }
      // getting the max value between max value and nested list
      maximumValue = max(maximumValue, properties[i][1]);
    }
    // simply returning the result
    return result;
  }
}
```
