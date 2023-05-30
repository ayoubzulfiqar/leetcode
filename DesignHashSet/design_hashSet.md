# 🔥 Design HashSet - Bit Manipulation 🔥 || Simple Fast and Easy || with Explanation

## Explanation

In this optimized version, we use a single Int32List instead of a boolean array. Each element of the list represents 32 bits, allowing us to store the state of multiple keys in a single integer value. We perform bit manipulation operations to set or unset specific bits in the integer.

The add method sets the bit at the corresponding index and position using bitwise OR (|). The remove method un-sets the bit using bitwise AND (&) with the complement of the bit mask. The contains method checks if the bit is set using bitwise AND (&).

This optimized implementation reduces memory usage and provides faster performance for operations on large sets of integers.

Please note that the size of the Int32List is set to accommodate integers up to 1,000,000 (32 * 125001). You can adjust the size based on your specific needs.

1. The MyHashSet class represents a HashSet implementation using bit manipulation.
2. The mp variable is an Int32List used to store the state of the keys.
3. In the constructor MyHashSet(), we initialize mp with a size of 125001, which allows us to store 1,000,000 bits (32 bits per element * 125001 elements).
4. The add method takes an integer key. It calculates the index and bit position of the key in mp. It then uses the bitwise OR (|) operation to set the corresponding bit at the calculated position.
5. The remove method is similar to add. It calculates the index and bit position of the key and uses the bitwise AND (&) operation with the complement of the bit mask to unset the bit at the position.
6. The contains method checks if the bit at the index and position is set. It performs the bitwise AND (&) operation with the bit mask and returns true if the result is non-zero, indicating that the bit is set.

### Space Complexity

The space complexity of the MyHashSet class is O(1) because the size of the Int32List (mp) is fixed at 125001, regardless of the number of elements added.

#### Time Complexity

The time complexity of the add, remove, and contains methods is O(1) because the calculations and bitwise operations performed are constant-time operations.
The optimized implementation using bit manipulation reduces memory usage and provides efficient constant-time operations for adding, removing, and checking the presence of keys in the HashSet.

### Solution - 1 Bit Manipulation

```dart
import 'dart:typed_data';

class MyHashSet {
  final Int32List mp;
  MyHashSet() : mp = Int32List(125001);

  void add(int key) {
    final int index = key ~/ 32;
    final int bitPosition = key % 32;
    mp[index] |= (1 << bitPosition);
  }

  void remove(int key) {
    final int index = key ~/ 32;
    final int bitPosition = key % 32;
    mp[index] &= ~(1 << bitPosition);
  }

  bool contains(int key) {
    final int index = key ~/ 32;
    final int bitPosition = key % 32;
    return (mp[index] & (1 << bitPosition)) != 0;
  }
}
```
