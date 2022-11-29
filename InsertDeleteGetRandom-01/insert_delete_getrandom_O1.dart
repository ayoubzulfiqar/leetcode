/*
 

-* Insert Delete GetRandom O(1) *-


Implement the RandomizedSet class:

RandomizedSet() Initializes the RandomizedSet object.
bool insert(int val) Inserts an item val into the set if not present. Returns true if the item was not present, false otherwise.
bool remove(int val) Removes an item val from the set if present. Returns true if the item was present, false otherwise.
int getRandom() Returns a random element from the current set of elements (it's guaranteed that at least one element exists when this method is called). Each element must have the same probability of being returned.
You must implement the functions of the class such that each function works in average O(1) time complexity.

 

Example 1:

Input
["RandomizedSet", "insert", "remove", "insert", "getRandom", "remove", "insert", "getRandom"]
[[], [1], [2], [2], [], [1], [2], []]
Output
[null, true, false, true, 2, true, false, 2]

Explanation
RandomizedSet randomizedSet = new RandomizedSet();
randomizedSet.insert(1); // Inserts 1 to the set. Returns true as 1 was inserted successfully.
randomizedSet.remove(2); // Returns false as 2 does not exist in the set.
randomizedSet.insert(2); // Inserts 2 to the set, returns true. Set now contains [1,2].
randomizedSet.getRandom(); // getRandom() should return either 1 or 2 randomly.
randomizedSet.remove(1); // Removes 1 from the set, returns true. Set now contains [2].
randomizedSet.insert(2); // 2 was already in the set, so return false.
randomizedSet.getRandom(); // Since 2 is the only number in the set, getRandom() will always return 2.
 

Constraints:

-231 <= val <= 231 - 1
At most 2 * 105 calls will be made to insert, remove, and getRandom.
There will be at least one element in the data structure when getRandom is called.


 */

// import 'dart:collection';
// import 'dart:math';

// class RandomizedSet {
//   // Hashmap to keep track of thee value and the index
//   HashMap<int, int> valueToPosition = HashMap();
//   // whole list to store our values
//   List<int> values = [];
//   // random number Generator
//   Random random = Random();
//   RandomizedSet() {
//     // initialization
//     this.random = random;
//     this.valueToPosition = valueToPosition;
//     this.values = values;
//   }

//   bool insert(int val) {
//     // if our map have the key but no value than return false
//     if (valueToPosition.containsKey(val)) return false;
//     // if so than we will store the value to our list
//     values.add(val);
//     // left side val as key and right side is index to keep track of the value
//     valueToPosition[val] = values.length - 1;
//     // than return true because we have values
//     return true;
//   }

//   bool remove(int val) {
//     // if the key at position does not exist than return false
//     if (!valueToPosition.containsKey(val)) return false;
//     // finding a position to remove the inserted value
//     int position = valueToPosition.remove(val) ?? 0;
//     // removing a the last index position
//     int last = values.removeAt(values.length - 1);
//     // if the position and the length matches we will return true
//     if (position == values.length) return true;
//     // assigning the position of the element in ou list to the last element where we would remove
//     values[position] = last;
//     // setting the new value to our map to keep track of everything
//     valueToPosition[last] = position;
//     return true;
//   }

//   int getRandom() {
//     // storing the whatever the number we will get from this function
//     return values[random.nextInt(values.length)];
//   }
// }

//====================================================================\\

// import 'dart:collection';
// import 'dart:math';

// class RandomizedSet {
//   HashSet<int> hashSet = HashSet(); // since values given is in 1s and 2s
//   //so not get confused between  index i choose to store in form of strings
//   List<int> list = [];
//   RandomizedSet() {
//     this.hashSet = hashSet;
//     this.list = list;
//   }

//   bool insert(int val) {
//     if (hashSet.contains(val)) return false;
//     hashSet.add(val);
//     list.add(val);
//     return true;
//   }

//   bool remove(int val) {
//     if (hashSet.contains(val)) {
//       list.remove(val);
//       hashSet.remove(val);

//       return true;
//     }
//     return false;
//   }

//   int getRandom() {
//     return list[Random().nextInt(hashSet.length)];
//   }
// }

//===========================================================\\

import 'dart:math';

class RandomizedSet {
  List<int> list = [];
  int size = 0;
  RandomizedSet() {
    this.list = list;
    this.size = size;
  }

  bool insert(int val) {
    int i = size;

    while (i > 0) {
      if (val == list[--i]) return false;
    }

    // size = size + 1;
    list[size + 1] = val;

    if (size >= list.length) {
      List<int> newSet = [2 * size];

      for (int j = 0; j < size; j++) newSet[j] = list[j];

      list = newSet;
    }
    return true;
  }

  bool remove(int val) {
    int i = size - 1;

    while (i >= 0) {
      if (list[i] == val) break;
      i--;
    }

    if (i == -1) return false;

    swap(i, --size);

    return true;
  }

  void swap(int i, int j) {
    int temp = list[i];
    list[i] = list[j];
    list[j] = temp;
  }

  int getRandom() {
    return list[Random().nextInt(size)];
  }
}

/*



class RandomizedSet {

  RandomizedSet() {

  }
  
  bool insert(int val) {

  }
  
  bool remove(int val) {

  }
  
  int getRandom() {

  }
}



*/