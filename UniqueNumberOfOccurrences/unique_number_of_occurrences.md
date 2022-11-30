# 🔥 Unique Number of Occurrences 🔥 || 3 Approaches || Simple Fast and Easy || with Explanation

## Solution - 1 HashMap + HashSet

```dart
import 'dart:collection';

class Solution {
  bool uniqueOccurrences(List<int> arr) {
    // hashmap to store all values of the array as key value pair
    HashMap<int, int> map = HashMap();
    // for all value inside our array
    for (int number in arr) {
      // we will add value of array as key and value + 1
      map[number] = (map[number] ?? 0) + 1;
    }
    // hashSet to see the unique values
    HashSet<int> hashSet = HashSet();
    // we will add all the values inside the set
    hashSet.addAll(map.values);
    // if the length of the unique set is same as the length of the map than true else false
    return hashSet.length == map.length;
  }
}
```

## Solution - 2 HashSet

```dart
import 'dart:collection';

class Solution {
  bool uniqueOccurrences(List<int> arr) {
    arr.sort();
    HashSet<int> unique = HashSet();

    int c = 1;
    for (int i = 1; i < arr.length; i++) {
      if (arr[i] == arr[i - 1])
        c++;
      else {
        if (unique.contains(c)) return false;

        unique.add(c);

        c = 1;
      }
    }

    if (unique.contains(c)) return false;

    return true;
  }
}
```

## Solution - 3 HashMap + Frequency Array

```dart
import 'dart:collection';

class Solution {
  bool uniqueOccurrences(List<int> arr) {
    HashMap<int, int> map = HashMap();

    for (int i = 0; i < arr.length; i++) {
      int ele = arr[i];
      if (map.containsKey(ele)) {
        map[ele] = (map[ele] ?? 0) + 1;
      } else {
        map[ele] = 1;
      }
    }

    List<int> freq = List.filled(1000, 0); //Constraint given

    for (MapEntry<int, int> e in map.entries) {
      int n = e.value;
      if (freq[n] != 0) {
        return false;
      }
      freq[n]++;
    }

    return true;
  }
}
```
