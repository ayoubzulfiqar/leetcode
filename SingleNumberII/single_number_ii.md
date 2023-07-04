# 🔥 3 Solutions 🔥 || Simple Fast and Easy || with Explanation 😈

## Brute Force

The provided code aims to find the single number in a list that occurs only once, while all other numbers occur twice.

### Algorithm Explanation

1. Initialize an empty HashMap called `map` to store the frequency count of each number.
2. Iterate over each element `x` in the input list `nums`.
3. Increment the frequency count of `x` in the `map` by 1. If `x` is not present in the `map`, initialize its count as 0 before incrementing.
4. After counting the frequencies, iterate over the entries of the `map` using `map.entries`.
5. For each entry, check if the value is equal to 1. If it is, return the corresponding key (the single number).
6. If no single number is found, return -1.

### Space Complexity

The space complexity is O(n), where n is the number of elements in the input list `nums`. This is because additional space is required to store the frequencies of the numbers in a HashMap.

### Time Complexity

The time complexity is O(n), where n is the number of elements in the input list `nums`. The code iterates over the input list once to count the frequencies, and then iterates over the entries of the `map`. However, since the number of unique elements in `nums` is represented as `m`, the worst-case time complexity can be expressed as O(n + m) = O(n). In the worst case, where all elements are unique, `m` is equal to `n`.

```dart
import 'dart:collection';

class Solution {
  int singleNumber(List<int> nums) {
    HashMap<int, int> map = HashMap<int, int>();

    for (int x in nums) {
      map[x] = (map[x] ?? 0) + 1;
    }

    for (MapEntry entry in map.entries) {
      if (entry.value == 1) {
        return entry.key;
      }
    }

    return -1;
  }
}
```

## Bit- Manipulation

### Algorithm Explanation

The given code aims to find the single number in a list that occurs only once, while all other numbers occur three times. The code uses bitwise operations to solve the problem efficiently.

1. Initialize a variable `ans` as 0 to store the result.
2. Iterate `i` from 0 to 31 (representing the 32 bits of an integer).
3. Initialize a variable `sum` as 0 to keep track of the sum of the i-th bit for all numbers.
4. Iterate over each number in the input list `nums`.
   - Right shift the number by `i` bits and perform a bitwise AND operation with 1 to get the i-th bit.
   - Add the i-th bit to `sum`.
5. Take the modulus of `sum` with 3 to handle numbers occurring three times.
6. Use the bitwise OR operation to set the i-th bit of `ans` based on `sum`.
7. After the loop, check if the sign bit (bit 31) of `ans` is set (negative number check).
   - If the sign bit is set, convert `ans` to a negative number by performing necessary bitwise operations.
8. Return the final result `ans`.

### Space Complexity

The space complexity of the code is O(1) since it uses a constant amount of additional space. The space required does not grow with the size of the input list.

### Time Complexity

The time complexity of the code is O(n), where n is the number of elements in the input list `nums`. The code consists of two nested loops: one loop iterating `i` from 0 to 31, and another loop iterating over each number in `nums`. However, since the number of bits being processed (32) and the number of elements in `nums` do not depend on each other, the time complexity remains linear. Therefore, the code performs an efficient linear scan of the input list to find the single number.

Overall, the code achieves a linear time complexity and constant space complexity, making it an efficient solution for finding the single number in the given scenario.

```dart
class Solution {
  int singleNumber(List<int> nums) {
    int ans = 0;

    for (int i = 0; i < 32; ++i) {
      int sum = 0;
      for (final int number in nums) {
        sum += (number >> i) & 1;
      }
      sum %= 3;
      ans |= (sum << i);
    }

    // Handle negative numbers
    if ((ans & (1 << 31)) != 0) {
      ans = -(1 << 31) | (ans & ((1 << 31) - 1));
    }

    return ans;
  }
}
```

## Magical XOR

### Algorithm Explanation

The given code aims to find the single number in a list that occurs only once, while all other numbers occur exactly twice. The code uses bitwise operations to efficiently solve the problem.

1. Initialize two variables `ones` and `twos` to 0. These variables are used to keep track of the bits that appear once and twice, respectively.
2. Iterate over each number in the input list `nums`.
   - XOR (`^`) the current number with the bitwise complement of `twos` and store the result in `ones`. This operation will set the bits that appear once in `ones`.
   - XOR (`^`) the current number with the bitwise complement of `ones` and store the result in `twos`. This operation will set the bits that appear twice in `twos`.
3. Repeat the loop for all numbers in `nums`, and after the loop, the variable `ones` will contain the single number that appears only once.

### Space Complexity

The space complexity of the code is O(1) since it uses a constant amount of additional space. The space required remains the same regardless of the size of the input list.

### Time Complexity

The time complexity of the code is O(n), where n is the number of elements in the input list `nums`. The code iterates over each number once, performing constant time operations (bitwise XOR and AND) for each number. The time complexity scales linearly with the size of the input list.

Overall, the code achieves an efficient linear time complexity and constant space complexity, making it an optimal solution for finding the single number in the given scenario. It leverages bitwise operations to efficiently keep track of the numbers that occur once and twice, providing an elegant solution with minimal space usage.

```dart
class Solution {
  int singleNumber(List<int> nums) {
    int ones = 0;
    int twos = 0;

    for (int i = 0; i < nums.length; i++) {
      final int number = nums[i];
      ones ^= (number & ~twos);
      twos ^= (number & ~ones);
    }

    return ones;
  }
}
```
