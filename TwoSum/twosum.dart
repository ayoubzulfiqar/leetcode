/*

* TWO SUM *
-------------


Given an array of integers numbers and an integer target, return indices of
the two numbers such that they add up to target.

You may assume that each input would have exactly one solution,
and you may not use the same element twice.

You can return the answer in any order.



Example 1:

Input: numbers = [2,7,11,15], target = 9
Output: [0,1]
Explanation: Because numbers[0] + numbers[1] == 9, we return [0, 1].

Example 2:

Input: numbers = [3,2,4], target = 6
Output: [1,2]

Example 3:

Input: numbers = [3,3], target = 6
Output: [0,1]




Constraints:

2 <= numbers.length <= 104
-109 <= numbers[i] <= 109
-109 <= target <= 109
Only one valid answer exists.


Follow-up: Can you come up with an algorithm that is less than O(n2) time complexity?

 */

void main() {
  final solution = Solution();

  List<int> a = <int>[2, 3, 4];
  int target = 5;

  final s = solution.twoSum(a, target);
//  print(s);

// when you print it will show the position of two value
//their sum will be equal to the target value
  // print(s);

  // SOLUTION - 2

  final solutions = AlgorithmicSolution();
  final ss = solutions.solution(a, target);
  // print(ss);

  final b = A();
  final ba = b.twoSum(a, target);
  // print(ba);

  final c = B();
  final ca = c.twoSum(a, target);
  print(ca);
}

/**
 *
 * SOLUTION
 *
 * this question is simple it ask us that the sum of any two value
 * inside list is should be equal to the target value
 *
 *
 * for example if i have a list
 * List<int> a = <int>[1,3,5,6]
 * and for example our target int is sum of two and those two elements can be
 * any of two inside our list such as 1 + 3, or 5 + 6 , but our target value is specific
 *  for example we write target is 4 so the it will sum the two and each value inside the
 * list till it reach it's result.
 *

 finally when you run the function and adding the value and print out it in the terminal

 * it will give the position of the values inside the list. That position indicates the
 * values because their sum will be the target value.
 *
 */
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

/**
 *
 *
 * SOLUTION - 2
 *
 * ALGORITHMIC APPROACH
 * -------------------- NOT Working
 */

class AlgorithmicSolution {
  // Runtime of this solution is 310ms
  List<int> solution(List<int> numbers, int target) {
    int left = 0;
    int right = numbers.length - 1;
    int tempSum = 0;
    while (left < right) {
      tempSum = numbers[left] + numbers[right];
      if (tempSum == target) {
        return [left + 1, right + 1];
      }
      if (tempSum > target) {
        right--;
      } else {
        left++;
      }
    }
    return [left, right];
  }
}

class A {
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
