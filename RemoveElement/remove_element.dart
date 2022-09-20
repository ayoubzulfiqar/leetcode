/*


-* Remove Element *-


Given an integer array nums and an integer val, remove all occurrences of val in nums in-place. The relative order of the elements may be changed.

Since it is impossible to change the length of the array in some languages, you must instead have the result be placed in the first part of the array nums. More formally, if there are k elements after removing the duplicates, then the first k elements of nums should hold the final result. It does not matter what you leave beyond the first k elements.

Return k after placing the final result in the first k slots of nums.

Do not allocate extra space for another array. You must do this by modifying the input array in-place with O(1) extra memory.

Custom Judge:

The judge will test your solution with the following code:

int[] nums = [...]; // Input array
int val = ...; // Value to remove
int[] expectedNums = [...]; // The expected answer with correct length.
                            // It is sorted with no values equaling val.

int k = removeElement(nums, val); // Calls your implementation

assert k == expectedNums.length;
sort(nums, 0, k); // Sort the first k elements of nums
for (int i = 0; i < actualLength; i++) {
    assert nums[i] == expectedNums[i];
}
If all assertions pass, then your solution will be accepted.



Example 1:

Input: nums = [3,2,2,3], val = 3
Output: 2, nums = [2,2,_,_]
Explanation: Your function should return k = 2, with the first two elements of nums being 2.
It does not matter what you leave beyond the returned k (hence they are underscores).
Example 2:
f
Input: nums = [0,1,2,2,3,0,4,2], val = 2
Output: 5, nums = [0,1,4,0,3,_,_,_]
Explanation: Your function should return k = 5, with the first five elements of nums containing 0, 0, 1, 3, and 4.
Note that the five elements can be returned in any order.
It does not matter what you leave beyond the returned k (hence they are underscores).


Constraints:

0 <= nums.length <= 100
0 <= nums[i] <= 50
0 <= val <= 100
*/

void main() {
  final List<int> nums = [3, 2, 2, 3];
  final int val = 3;

  final a = A().removeElement(nums, val);
  print(a);
}

// BRUTE FORCE Solution
class A {
  int removeElement(List<int> nums, int val) {
    // index start from zero
    int index = 0;

    // looping on every element inside the list
    for (var i = 0; i < nums.length; i++) {
      // if the element is not same as value
      if (nums[i] != val) {
        // we increment thee value and assign it to the element of the list
        nums[index++] = nums[i];
        // index++;
      }
    }
    // we will return the index
    return index;
  }

/*
Runtime: 568 ms, faster than 5.41% of Dart online submissions for Remove Element.
Memory Usage: 142.3 MB, less than 86.49% of Dart online submissions for Remove Element.
*/
}

class B {
  int removeElement(List<int> nums, int val) {
    int a = 0;
    int b = 0;

    while (b < nums.length) {
      if (nums[a] == val) {
        if (nums[b] == val) {
          b += 1;
        } else {
          int temp = nums[a];
          nums[a] = nums[b];
          nums[b] = temp;
        }
      } else {
        a += 1;
        b += 1;
      }
    }
    return a;
  }

  // 113 / 113 test cases passed, but took too long.
}

class C {
  int removeElement(List<int> nums, int val) {
    // index of the list
    int index = 0;
    // value of the list
    int value = 0;
    // loop to see if the lent is not less than zero
    while (value < nums.length) {
      // if the value is same as the val
      if (nums[value] == val) {
        // loop to see the the length is greater and value inside the list is same as val
        while (value < nums.length && nums[value] == val) {
          // we will increment value
          value++;
        }
      }
      // if the value is still less than list length
      if (value < nums.length) {
        // nums[index]- start from zero and will equal to the value of the list
        nums[index] = nums[value];
        // increment index
        index++;
        // increment value
        value++;
      }
    }
    // returning the index
    return index;
  }

/*
Runtime: 327 ms, faster than 94.59% of Dart online submissions for Remove Element.
Memory Usage: 157.8 MB, less than 5.41% of Dart online submissions for Remove Element.
*/
}
// dynamic temp = nums.length;
