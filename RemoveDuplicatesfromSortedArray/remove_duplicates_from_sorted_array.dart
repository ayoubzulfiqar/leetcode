/*

    -*  Remove Duplicates from Sorted Array *-

Given an integer array nums sorted in non-decreasing order,
remove the duplicates in-place such that each unique element appears only once.
The  order of the elements should be kept the same.

Since it is impossible to change the length of the array in some languages,
you must instead have the result be placed in the first part of the array nums.
More formally, if there are k elements after removing the duplicates,
then the first k elements of nums should hold the final result.
It does not matter what you leave beyond the first k elements.
Return k after placing the final result in the first k slots of nums.
Do not allocate extra space for another array.
You must do this by modifying the input array in-place with O(1) extra memory.

Custom Judge:

The judge will test your solution with the following code:

int[] nums = [...]; // Input array
int[] expectedNums = [...]; // The expected answer with correct length

int k = removeDuplicates(nums); // Calls your implementation

assert k == expectedNums.length;
for (int i = 0; i < k; i++) {
    assert nums[i] == expectedNums[i];
}
If all assertions pass, then your solution will be accepted.



Example 1:

Input: nums = [1,1,2]
Output: 2, nums = [1,2,_]
Explanation: Your function should return k = 2, with the first two elements of nums being 1 and 2 respectively.
It does not matter what you leave beyond the returned k (hence they are underscores).


Example 2:

Input: nums = [0,0,1,1,1,2,2,3,3,4]
Output: 5, nums = [0,1,2,3,4,_,_,_,_,_]
Explanation: Your function should return k = 5, with the first five elements of nums being 0, 1, 2, 3, and 4 respectively.
It does not matter what you leave beyond the returned k (hence they are underscores).


Constraints:

1 <= nums.length <= 3 * 104
-100 <= nums[i] <= 100
nums is sorted in non-decreasing order.



 */

void main() {
  List<int> nums = <int>[1, 1, 2];
  List<int> numms = <int>[0, 0, 1, 1, 1, 2, 2, 3, 3, 4];
  final b = C().removeDuplicates(nums);
  final bb = C().removeDuplicates(numms);
  print(b);
  print(bb);
}

// BRUTE FORCE Solution
class A {
  int removeDuplicates(List<int> nums) {
    // keep track of the value
    int c = 1;
    // looping through every digit inside list
    for (int i = 1; i < nums.length; i++) {
      // if the digit is not equal to the index value of the list
      // remember :- digit start from 1 and index start from 0
      // so nums[i - 1] is to get the index
      if (nums[i] != nums[i - 1]) {
        // than the value will be  equal to the value of inside
        nums[c] = nums[i];
        // increment the value
        c++;
      }
    }
    return c;
  }

/*
Runtime: 456 ms, faster than 65.63% of Dart online submissions for Remove Duplicates from Sorted Array.
Memory Usage: 144.2 MB, less than 75.00% of Dart online submissions for Remove Duplicates from Sorted Array.
*/
}

class B {
  int removeDuplicates(List<int> nums) {
    // if the list is empty than we returning the zero
    if (nums.length == 0) return 0;
    int first = 0;
    int last = 0;
    while (last < nums.length) {
      if (nums[first] != nums[last]) {
        // first = first + 1;
        first += 1;
        nums[first] = nums[last];
      }
      // last = last + 1;
      last += 1;
    }

    // first = first + 1;
    return first += 1;
  }
/*
Runtime: 389 ms, faster than 93.75% of Dart online submissions for Remove Duplicates from Sorted Array.
Memory Usage: 143.9 MB, less than 84.38% of Dart online submissions for Remove Duplicates from Sorted Array.
*/
}

class C {
  int removeDuplicates(List<int> nums) {
    // i = indexValue :- index always start from zero
    int i = 0;
    // j = digitValue inside list
    int j = i + 1;

    // loop to check if the digitValue is shorter than length
    while (j < nums.length) {
      // if they both are not same
      if (nums[i] != nums[j]) {
        // we increment the index value
        i++;
        // than the index will be same as the digitValue
        nums[i] = nums[j];
      }

      j++;
    }
    return ++i;
  }

/*
Runtime: 491 ms, faster than 56.25% of Dart online submissions for Remove Duplicates from Sorted Array.
Memory Usage: 143 MB, less than 100.00% of Dart online submissions for Remove Duplicates from Sorted Array.
*/
}
