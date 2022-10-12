/*

 -* Largest Perimeter Triangle *-

Given an integer array nums, return the largest perimeter of a triangle with a non-zero area, formed from three of these lengths. If it is impossible to form any triangle of a non-zero area, return 0.



Example 1:

Input: nums = [2,1,2]
Output: 5
Example 2:

Input: nums = [1,2,1]
Output: 0


Constraints:

3 <= nums.length <= 104
1 <= nums[i] <= 106


*/

import 'dart:math';

class A {
// Runtime: 426 ms, faster than 80.00% of Dart online submissions for Largest Perimeter Triangle.
// Memory Usage: 149.6 MB, less than 100.00% of Dart online submissions for Largest Perimeter Triangle.

  int largestPerimeter(List<int> nums) {
    nums.sort();
    for (int i = nums.length - 1; i > 1; --i)
      if (nums[i] < nums[i - 1] + nums[i - 2])
        return nums[i] + nums[i - 1] + nums[i - 2];
    return 0;
  }
}

class B {
// Runtime: 514 ms, faster than 60.00% of Dart online submissions for Largest Perimeter Triangle.
// Memory Usage: 150.2 MB, less than 20.00% of Dart online submissions for Largest Perimeter Triangle.

  //utility method to get max element at given index
  void swapToGetMax(List<int> nums, int index) {
    int max = 0, maxIndex = -1;
    for (int i = 0; i <= index; i++)
      if (max < nums[i]) {
        max = nums[i];
        maxIndex = i;
      }
    //actual swapping after finding max element in given range
    int temp = nums[index];
    nums[index] = max;
    nums[maxIndex] = temp;
  }

  int largestPerimeter(List<int> nums) {
    //if array has only 3 elements
    if (nums.length == 3) {
      if (nums[0] < nums[1] + nums[2] &&
          nums[1] < nums[0] + nums[2] &&
          nums[2] < nums[1] + nums[0])
        return nums[0] + nums[1] + nums[2];
      else
        return 0;
    }
    //for more than 3 elements, without doing explicit sorting
    int n = nums.length;
    //here we are putting max element at last index
    swapToGetMax(nums, n - 1);
    //here we are putting max element at second last index
    swapToGetMax(nums, n - 2);
    //here we are putting max element at third last index
    swapToGetMax(nums, n - 3);
    //in loop checking if nums[i]<nums[i-1]+nums[i-2] which this triplet will form the max perimeter
    for (int i = n - 1; i >= 2; i--) {
      if (nums[i] < nums[i - 1] + nums[i - 2])
        return nums[i] + nums[i - 1] + nums[i - 2];
      //if not then will find max element as (i-3)th largest element
      else if (i > 2) swapToGetMax(nums, i - 3);
    }
    return 0;
  }
}

class C {
// Runtime: 596 ms, faster than 40.00% of Dart online submissions for Largest Perimeter Triangle.
// Memory Usage: 150.3 MB, less than 20.00% of Dart online submissions for Largest Perimeter Triangle.
  int largestPerimeter(List<int> nums) {
    if (nums.length == 3) {
      if (nums[0] < nums[1] + nums[2] &&
          nums[1] < nums[0] + nums[2] &&
          nums[2] < nums[1] + nums[0])
        return nums[0] + nums[1] + nums[2];
      else
        return 0;
    }
    int n = nums.length;
    int maxi = 0;
    for (int i = 0; i < n - 2; i++) {
      for (int j = i + 1; j < n - 1; j++) {
        for (int k = j + 1; k < n; k++) {
          int a = nums[i];
          int b = nums[j];
          int c = nums[k];
          if (a < b + c && b < c + a && c < a + b) maxi = max(maxi, a + b + c);
        }
      }
    }
    if (maxi > 0) return maxi;
    return 0;
  }
}

class D {
  int largestPerimeter(List<int> nums) {
    //sort the vector
    nums.sort();
    //any triangle sum of smaller two side greater than 3rd side...so we check that condition, a+b>c where a<b<c
    int maxPerimeter = 0;

    for (int i = 0; i <= nums.length - 3; i++) {
      //check the triangle valid condition
      if (nums[i] + nums[i + 1] > nums[i + 2]) {
        maxPerimeter =
            max(maxPerimeter, nums[i] + nums[i + 1] + nums[i + 2]); //find max
      }
    }

    return maxPerimeter; //return the result
  }
}

class F {
  int largestPerimeter(List<int> nums) {
    nums.sort((a, b) => a - b);
    int i = nums.length - 1;
    while (i >= 0) {
      if (nums[i] < nums[i - 1] + nums[i - 2]) {
        return nums[i] + nums[i - 1] + nums[i - 2];
      } else {
        i--;
      }
    }
    return 0;
  }
}
