# 🔥 3 Approaches 🔥 || Simple Fast and Easy || with Explanation

## Solution - 1 HashMap

```dart
import 'dart:collection';
import 'dart:math';

class RandomizedSet {
  // Hashmap to keep track of thee value and the index
  HashMap<int, int> valueToPosition = HashMap();
  // whole list to store our values
  List<int> values = [];
  // random number Generator
  Random random = Random();
  RandomizedSet() {
    // initialization
    this.random = random;
    this.valueToPosition = valueToPosition;
    this.values = values;
  }

  bool insert(int val) {
    // if our map have the key but no value than return false
    if (valueToPosition.containsKey(val)) return false;
    // if so than we will store the value to our list
    values.add(val);
    // left side val as key and right side is index to keep track of the value
    valueToPosition[val] = values.length - 1;
    // than return true because we have values
    return true;
  }

  bool remove(int val) {
    // if the key at position does not exist than return false
    if (!valueToPosition.containsKey(val)) return false;
    // finding a position to remove the inserted value
    int position = valueToPosition.remove(val) ?? 0;
    // removing a the last index position
    int last = values.removeAt(values.length - 1);
    // if the position and the length matches we will return true
    if (position == values.length) return true;
    // assigning the position of the element in ou list to the last element where we would remove
    values[position] = last;
    // setting the new value to our map to keep track of everything
    valueToPosition[last] = position;
    return true;
  }

  int getRandom() {
    // storing the whatever the number we will get from this function
    return values[random.nextInt(values.length)];
  }
}
```

## Solution - 2 HashSet

```dart
import 'dart:collection';
import 'dart:math';

class RandomizedSet {
  HashSet<int> hashSet = HashSet(); // since values given is in 1s and 2s
  //so not get confused between  index i choose to store in form of strings
  List<int> list = [];
  RandomizedSet() {
    this.hashSet = hashSet;
    this.list = list;
  }

  bool insert(int val) {
    if (hashSet.contains(val)) return false;
    hashSet.add(val);
    list.add(val);
    return true;
  }

  bool remove(int val) {
    if (hashSet.contains(val)) {
      list.remove(val);
      hashSet.remove(val);

      return true;
    }
    return false;
  }

  int getRandom() {
    return list[Random().nextInt(hashSet.length)];
  }
}
```

## Solution - 3 Array

```dart
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
```
