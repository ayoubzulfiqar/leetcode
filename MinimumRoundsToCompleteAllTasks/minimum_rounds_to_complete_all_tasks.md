# 🔥 3 Approaches 🔥 || Simple Fast and Easy || with Explanation

## Solution - 1

```dart
import 'dart:collection';

class Solution {
  int minimumRounds(List<int> tasks) {
    // Create a HashMap to store the count of each task
    HashMap<int, int> getCount = HashMap();

    // Iterate through the tasks array and store the count of each task
    // in the HashMap
    for (int t in tasks) {
      getCount[t] = (getCount[t] ?? 0) + 1;
    }

    // Initialize a result variable to 0
    int result = 0;

    // Iterate through the values in the HashMap (which represent the counts of the tasks)
    for (int count in getCount.values) {
      // If a task has a count of 1, it cannot be grouped with other tasks
      // and so we return -1
      if (count == 1) return -1;

      // Add the number of rounds needed to process the tasks with count greater than or equal to 3
      result += count ~/ 3;

      // If there are any tasks left with count less than 3, we need an additional round
      // to process these tasks
      if (count % 3 != 0) result++;
    }

    // Return the total number of rounds needed to process all tasks
    return result;
  }
}

```

## Solution - 2

```dart
class Solution {
  int minimumRounds(List<int> tasks) {
    // Sort the tasks array in ascending order
    tasks.sort();
    int result = 0, count = 0;
    // Iterate through each task
    for (int i = 0; i < tasks.length; i++) {
      // Increment the count of tasks with the same value
      count++;
      // If we have reached the last task or the current task is different from the next task
      if (i == tasks.length - 1 || tasks[i] != tasks[i + 1]) {
        // If there is only one task with this value, we cannot create groups of 3
        // and we return -1
        if (count == 1) {
          return -1;
        }
        // Add the number of full groups of 3 we can create from the tasks with this value
        result += count ~/ 3;
        // If there are remaining tasks that cannot be included in a group of 3,
        // we need one more round to process these tasks
        if (count % 3 != 0) result++;
        // Reset the count for the next set of tasks
        count = 0;
      }
    }
    // Return the total number of rounds needed
    return result;
  }
}
```

## Solution - 3 GREEDY

```dart
import 'dart:collection';

class Solution {
  int minimumRounds(List<int> tasks) {
    int ans = 0;
    HashMap<int, int> map = HashMap();
    for (int number in tasks) {
      map[number] = (map[number] ?? 0) + 1;
    }
    for (int key in map.keys) {
      int val = map[key] ?? 0;
      if (val == 1) return -1;
      int cnt = val ~/ 3;
      if (val % 3 != 0) cnt++;
      ans += cnt;
    }
    return ans;
  }
}
```
