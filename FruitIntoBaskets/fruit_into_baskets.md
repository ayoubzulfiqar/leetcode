# 🔥 100% Fast 🔥 || Simple Fast and Easy || with Explanation

## Approach

Initialize an array counts to store the count of each type of fruit.
Initialize variables max to store the maximum length of the sub-array, currentMax to store the current length of the sub-array, typeCount to store the number of different types of fruit in the sub-array, and start to store the start index of the sub-array.
Iterate through the fruits array and increment the count of the current fruit in counts. Also, increment currentMax and typeCount if the current fruit is a new type.
While the number of different fruit types in the sub-array exceeds 2, and start is less than i, decrement the count of the fruit at start in counts, decrement currentMax, and increment start. If the count of the fruit becomes 0, decrement typeCount.
Update max with the maximum value of max and currentMax.
Return max as the result.

## Complexity

- Time complexity: O(n)
This is because the solution uses a single loop through the fruits

- Space complexity: O(n)
This is because the solution uses an array counts of size n to store the count of each fruit type

## Code - 1

```dart
class Solution {
  int totalFruit(List<int> fruits) {
    List<int> counts = List.filled(fruits.length, 0);
    int maximum = 0;
    int currentMax = 0;
    int typeCount = 0;
    int start = 0;

    for (int i = 0; i < fruits.length; i++) {
      if (counts[fruits[i]] == 0) typeCount++;
      counts[fruits[i]]++;
      currentMax++;

      while (typeCount > 2 && start < i) {
        counts[fruits[start]]--;
        if (counts[fruits[start]] == 0) typeCount--;
        start++;
        currentMax--;
      }

      maximum = max(maximum, currentMax);
    }

    return maximum;
  }
}
```

## Code - 2

```dart
class Solution {
  int totalFruit(List<int> fruits) {
    int n = fruits.length, ans = 0;
    // count the frequency of fruits
    HashMap<int, int> m = HashMap();
    // two pointers
    // - l is the pointer to the starting index of the window
    // - r is the pointer to the ending index of the window
    for (int l = 0, r = 0; r < n; r++) {
      // add fruits[r] to a hashmap
      m[fruits[r]] = (m[fruits[r]] ?? 0) + 1;
      // if there is more than two types
      if (m.length > 2) {
        // then we need to sub-tract one from the freq of leftmost element, i.e. fruits[l]
        // if it is 0, then we can erase it
        m[fruits[l]] = (m[fruits[l]] ?? 0) - 1;
        if (m[fruits[l]] == 0) m.remove(fruits[l]);
        // shrink the window by moving the `l` to the right
        l += 1;
      }
      // the maximum number of fruits we can pick is simply the window size
      ans = max(ans, r - l + 1);
    }
    return ans;
  }
}
```
