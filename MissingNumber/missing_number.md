# 🔥 Missing Number 🔥 || 5 Approaches || Simple Fast and Easy || with Explanation

## Solution - 1 Brute Force

```dart
class Solution {
  int missingNumber(List<int> nums) {
    int sum = 0; // sum of all numbers initially 0
    // total is the sum of all numbers in the array
    int total = nums.length * (nums.length + 1) ~/ 2;
    for (int number in nums) {
      // iterate through the array
      sum += number; // add the number to the sum
    }
    // return the difference between the sum and the total that is the missing number
    return total - sum;
  }
}
```

## Solution - 2 Frequency Array

```dart
class Solution {
  int missingNumber(List<int> nums) {
    int size = nums.length;
    List<int> array = List.filled(size + 1, 0);
    for (int i = 0; i < size + 1; i++) {
      array[nums[i]]++;
    }
    int ans = 0;
    for (int i = 0; i < size; i++) {
      if (nums[i] == 0) {
        ans = i;
      }
    }
    return ans;
  }
}
```

## Solution - 3

```dart

class Solution {
  int missingNumber(List<int> nums) {
    int result = nums.length; // initialize result to size of vector
    int i = 0; // initialize i to 0
    for (int num in nums) {
      // for each number in vector
      result ^= num; // XOR result with number
      result ^= i; // XOR result with i
      i++; // increment i
    }
    return result; //
  }
}
```

## Solution - 4

```dart
import 'dart:collection';

class Solution {
  int missingNumber(List<int> nums) {
    HashMap map = HashMap();

    // every number in our list
    for (int i = 0; i < nums.length; i++) {
      // single value
      int number = nums[i];
      // adding it to the map
      map[number] = number;
    }
    // answer
    int ans = -1;
    // for 10000 words
    for (int i = 0; i < 10000; i++) {
      // if our map contain any digit
      if (map.containsKey(i)) {
        // we will continue
        continue;
      } else {
        // else if there is not match in any digit
        // we will assign it and return it
        ans = i;
        break;
      }
    }
    return ans;
  }
}
```

## Solution - 5

```dart
import 'dart:collection';

class Solution {
  int missingNumber(List<int> nums) {
    HashSet hashSet = HashSet();
    int answer = -1;
    for (int i = 0; i < nums.length; i++) {
      hashSet.add(nums[i]);
    }
    for (int i = 0; i < 10000; i++) {
      if (hashSet.contains(i)) {
        continue;
      } else {
        answer = i;
        break;
      }
    }
    return answer;
  }
}
```
