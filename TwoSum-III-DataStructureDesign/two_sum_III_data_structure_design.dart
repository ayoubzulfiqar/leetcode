/*

 -* Two Sum III - Data Structure Design *-


Design and implement a TwoSum class. It should support the following operations:addandfind.
add- Add the number to an internal data structure.
find- Find if there exists any pair of numbers which sum is equal to the value.
Example 1:
add(1); add(3); add(5);
find(4) -> true
find(7) -> false
Example 2:
add(3); add(1); add(2);
find(3) -> true
find(6) -> false



*/

import 'dart:collection';

class A {
/*

Approach 1:
using two hash-set to store unique number and unique sum when add(), add to unique sum and num,
this will have O(n) time for add(), and O(1) for find().
The space complexity though is O(n^2), which unique set for sum will consume O(n^2) space

*/

  HashMap<int, int> elements = HashMap<int, int>();

  void add(int number) {
    if (elements.containsKey(number)) {
      elements.forEach((key, value) {
        key = number;
        value = elements.values.elementAt(number) + 1;
      });
    } else {
      elements.forEach((key, value) {
        key = number;
        value = 1;
      });
    }
  }

  bool find(int value) {
    for (int i in elements.keys) {
      int target = value - i;
      if (elements.containsKey(target)) {
        if (i == target && elements.values.elementAt(target) < 2) {
          continue;
        }
        return true;
      }
    }
    return false;
  }
}
