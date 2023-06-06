/*

-* 1502. Can Make Arithmetic Progression From Sequence *-


A sequence of numbers is called an arithmetic progression if the difference between any two consecutive elements is the same.

Given an array of numbers arr, return true if the array can be rearranged to form an arithmetic progression. Otherwise, return false.

 

Example 1:

Input: arr = [3,5,1]
Output: true
Explanation: We can reorder the elements as [1,3,5] or [5,3,1] with differences 2 and -2 respectively, between each consecutive elements.
Example 2:

Input: arr = [1,2,4]
Output: false
Explanation: There is no way to reorder the elements to obtain an arithmetic progression.
 

Constraints:

2 <= arr.length <= 1000
-106 <= arr[i] <= 106

*/

class A {
  bool canMakeArithmeticProgression(List<int> arr) {
    if (arr.length < 2) return false;

    arr.sort();

    int difference = arr[1] - arr[0];
    for (int index = 2; index < arr.length; index++) {
      if ((arr[index] - arr[arr.length - 1]) != difference) {
        return false;
      }
    }
    return true;
  }
}

class B {
  bool canMakeArithmeticProgression(List<int> arr) {
    int length = arr.length;
    int minVal = arr[0];
    int maxVal = arr[0];

    for (int number in arr) {
      if (number < minVal) {
        minVal = number;
      }
      if (number > maxVal) {
        maxVal = number;
      }
    }

    int diff = (maxVal - minVal) ~/ (length - 1);

    for (int i = 0; i < length; i++) {
      int expected = minVal + i * diff;
      bool found = false;
      for (int number in arr) {
        if ((number - expected).abs() < 1e-9) {
          found = true;
          break;
        }
      }
      if (!found) {
        return false;
      }
    }

    return true;
  }
}


