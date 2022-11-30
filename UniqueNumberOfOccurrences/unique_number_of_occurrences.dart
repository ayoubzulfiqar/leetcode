/*


-* 1207. Unique Number of Occurrences *-


Given an array of integers arr, return true if the number of occurrences of each value in the array is unique, or false otherwise.

 

Example 1:

Input: arr = [1,2,2,1,1,3]
Output: true
Explanation: The value 1 has 3 occurrences, 2 has 2 and 3 has 1. No two values have the same number of occurrences.
Example 2:

Input: arr = [1,2]
Output: false
Example 3:

Input: arr = [-3,0,1,-3,1,1,1,-3,10,0]
Output: true
 

Constraints:

1 <= arr.length <= 1000
-1000 <= arr[i] <= 1000


*/

import 'dart:collection';

class A {
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

class B {
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

class C {
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
