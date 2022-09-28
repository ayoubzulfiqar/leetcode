/*

 -* Single Number *-

Given a non-empty array of integers nums, every element appears twice except for one. Find that single one.

You must implement a solution with a linear runtime complexity and use only constant extra space.



Example 1:

Input: nums = [2,2,1]
Output: 1
Example 2:

Input: nums = [4,1,2,1,2]
Output: 4
Example 3:

Input: nums = [1]
Output: 1


Constraints:

1 <= nums.length <= 3 * 104
-3 * 104 <= nums[i] <= 3 * 104
Each element in the array appears twice except for one element which appears only once.



*/

import 'dart:collection';

class A {
// Runtime: 528 ms, faster than 44.87% of Dart online submissions for Single Number.
// Memory Usage: 146.1 MB, less than 78.20% of Dart online submissions for Single Number.
  int singleNumber(List<int> nums) {
    // holding our result
    int digit = 0;
    // looping through each element in the list
    for (int i = 0; i < nums.length; i++) {
      // using bit-wise XOR operator
      /*
      A bitwise XOR is a binary operation that takes two bit patterns of equal
      length and performs the logical exclusive OR operation on each pair of corresponding bits.
      The result in each position is 1 if only one of the bits is 1,
      but will be 0 if both are 0 or both are 1.
      */
      //digit = digit ^ nums[i];
      digit ^= nums[i];
    }
    return digit;
  }
}

class B {
  // If we can sort the numbers, then we will have all pair of numbers adjacent to each other.
// Then, we can check pair of numbers where they are not equal.
// Runtime: 718 ms, faster than 11.54% of Dart online submissions for Single Number.
// Memory Usage: 146.8 MB, less than 55.13% of Dart online submissions for Single Number.
  int singleNumber(List<int> nums) {
    // getting the index value of the list
    int index = nums.length - 1;
    // sorting the list
    nums.sort();
    // holding our value
    int value = 0;
    // if the value is less than the index value
    while (value < index) {
      // if the value is not same as the next value than we will return the value

      if (nums[value] != nums[value + 1]) return nums[value];

      /// otherwise the third value
      value += 2;
    }
    //check for last element
    // if the mod of the the index value is equal to 1
    // than we will return the previous value
    if (index % 2 == 1) return nums[index - 1];

    return -1;
  }
}

class C {
// Runtime: 601 ms, faster than 24.36% of Dart online submissions for Single Number.
// Memory Usage: 147.2 MB, less than 52.56% of Dart online submissions for Single Number.
  int singleNumber(List<int> nums) {
    // whole llenght of the list
    int length = nums.length;
    // if the list have only one value thn we will return that value which is
    // at first index
    if (length == 1) return nums[0];
    // sorting the list
    nums.sort();
    // if the value aat second index is not same as the first index
    // we will return the first index
    if (nums[1] != nums[0]) return nums[0];
    // checking backward
    if (nums[length - 1] != nums[length - 2]) return nums[length - 1];
    // looping through
    for (int i = 1; i < length - 1; i++) {
      if (nums[i] != nums[i - 1] && nums[i] != nums[i + 1]) return nums[i];
    }
    return -1;
  }
}

class D {
/*

ssuming our array has all pairs. i.e. we don’t have a single number. Then, following is true:

2 (sum of unique numbers) = (sum of all numbers)
Now, if we know one of the number is missing in pairs. Following must be true:

2 (sum of unique numbers) - (sum of all numbers) = Missing Number
*/

// Runtime: 690 ms, faster than 14.10% of Dart online submissions for Single Number.
// Memory Usage: 153 MB, less than 15.38% of Dart online submissions for Single Number.
  int singleNumber(List<int> nums) {
    int l = nums.length;
    HashSet<int> hashSet = HashSet<int>();

    int sum = 0;
    int uniqueElementSum = 0;

    for (int i = 0; i < l; i++) {
      if (!hashSet.contains(nums[i])) {
        hashSet.add(nums[i]);
        uniqueElementSum += nums[i];
      }

      //all sum
      sum += nums[i];
    }

    return 2 * uniqueElementSum - sum;
  }
}

class E {
  int singleNumber(List<int> nums) {
    final Map<int, int?> map = {};
    for (int element in nums) {
      map[element] = (map[element] ?? 0) + 1;
    }
    int result = 0;
    map.forEach((key, value) {
      if (value == 1) result = key;
    });
    return result;
  }
}

class F {
  int singleNumber(List<int> nums) {
    int n = nums.length; // extracting the size of the array

    // traverse from the array
    for (int i = 0; i < n - 1; i++)
      nums[i + 1] = nums[i] ^ nums[i + 1]; // (prev answer xor current index)

    return nums[n - 1]; // return left over element
  }
}
