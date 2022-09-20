# TwoSum Solution for Dart

## First Solution

```dart
class Solution {
  // BRUTE FORCE SOLUTION - SIMPLE
  // Runtime of this solution is 362ms
  List<int> twoSum(List<int> numbers, int target) {
    // it indicates the whole length of the list
    int n = numbers.length;

// for loop for tracking the first value
    for (var i = 0; i < n - 1; i++) {
      // for loop for keep tracking the second value inside the list
      for (var j = i + 1; j < n; j++) {
        // condition that dictates the first of any value inside the list and second inside the
        // list should be equal to target
        if (numbers[i] + numbers[j] == target) {
          // then we return the list of first value and second
          return [i, j];
        }
      }
    }

    return [];
  }
}
```

## Second Solution

Using map to keeping an eye on the values of the list
Saddly in LeetCode the HashMap isnot working but it perfectly working outside the leetcode.
So I use Map instead of HashMap

```dart

class B {
  // In LeetCode the HashMap is not fully implemented
  // Runtime 503
  List<int> twoSum(List<int> nums, int target) {


// Map to keep an eye on the close range, simply correlation
    final Map<int, int> correspondence = Map<int, int>();

    // loop through the entire list values
    for (var i = 0; i < nums.length; i++) {
      // saving value inside a variable
      final int value = nums[i];

      // we are getting key in a very tricky way like target value which
      // we will enter and than we will subtract the single value
      //that we got from looping from the list.
      //
      final int key = target - value;
      if (correspondence.containsKey(key)) {
        // than we will return if int of the map and the second int
        // which shows the position in a list which two value will result the target value
        return [correspondence[key]!, i];
      }
      // here we defining that our key will i the digit inside of our list
      // if we don't do  this than it will return the value of the list which is inside the list
      correspondence[value] = i;

      // Remember = correspondence[missing] is Our key , correspondence[value] is Our Value

    }
    return [];
  }
}

```

## Third Solution

This work like a charm in terminal because dart does not keep track of the index number in list. I have create a extension to work with the list but for leetCode let's not make complicated

```dart
class Solution
// Working perfect in Terminal
// but runtime error inclusive range error

  List<int> twoSum(List<int> nums, int target) {
    List<int> result = <int>[];
    for (var i = 0; i < nums.length; i++) {
      int complement = target - nums[i];
      var index = nums.indexOf(complement, i + 1);
      if (nums[index] + nums[i] == target) {
        return result = [i, index];
      }
      break;
    }
    return result;
  }
}

```
