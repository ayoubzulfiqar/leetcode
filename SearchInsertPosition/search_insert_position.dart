/*


 -* Search Insert Position  *-

Given a sorted array of distinct integers and a target value, return the index if the target is found. If not, return the index where it would be if it were inserted in order.

You must write an algorithm with O(log n) runtime complexity.



Example 1:

Input: nums = [1,3,5,6], target = 5
Output: 2
Example 2:

Input: nums = [1,3,5,6], target = 2
Output: 1
Example 3:

Input: nums = [1,3,5,6], target = 7
Output: 4


Constraints:

1 <= nums.length <= 104
-104 <= nums[i] <= 104
nums contains distinct values sorted in ascending order.
-104 <= target <= 104
*/

void main() {
  final List<int> nums = [1, 3, 5, 6];
  final int target = 5;
  final a = A().searchInsert(nums, target);
  print(a);
}

class A {
  // Binary Search
  int searchInsert(List<int> nums, int target) {
    // left index Remember index always start from 0
    int left = 0;
    // right index
    int right = nums.length - 1;
    // if the target value is less than and equal to the first index we will return 0
    if (target <= nums[0]) return 0;
    // if the target value is greater than tight value inside the list we will add  1 to get the value
    if (target > nums[right]) return right + 1;
    // mid to get the middle value
    double mid;
    // if the left value is smaller than the  right value because we have to arrange value
    // in ascending order
    while (left <= right) {
      // we take the left value and right value and divide them with two to get middle value
      mid = (left + right) / 2;
      // if the target is smaller than mid value of the two digit inside the list
      // and target is also greater than mid -1 value
      if (target <= nums[mid.toInt()] && target > nums[mid.toInt() - 1])
        // we will simply return the mid
        return mid.toInt();
      // if the target value  is smaller mid value of the list
      if (nums[mid.toInt()] < target)
        // we wil return the mid value + 1
        left = mid.toInt() + 1;
      else
        // else we will return the mid - 1
        right = mid.toInt() - 1;
    }

    return -1;

    // Remember:- You can ~/ if you don't wanna use toInt()
  }

/*
Runtime: 431 ms, faster than 72.97% of Dart online submissions for Search Insert Position.
Memory Usage: 144.3 MB, less than 13.51% of Dart online submissions for Search Insert Position.
*/
}

class B {
  int searchInsert(List<int> nums, int target) {
    // first left index
    int left = 0;
    // right index value
    int right = nums.length;
    // left is smaller than right
    while (left < right) {
      // mid value
      int mid = (left + right) ~/ 2;
      // if he middle value is smaller than target
      if (nums[mid] < target) {
        // we will return the middleIndex  + 1 to get the value
        left = mid + 1;
      } else {
        // else middleIndex value will be our right value
        right = mid;
      }
    }
    // return left
    return left;
  }
/*
Runtime: 381 ms, faster than 89.19% of Dart online submissions for Search Insert Position.
Memory Usage: 142.4 MB, less than 89.19% of Dart online submissions for Search Insert Position.
*/
}

class C {
  int searchInsert(List<int> nums, int target) {
    // looping through every element inside the list
    for (var i = 0; i < nums.length; i++) {
      // if the single value is same as target we will return that value
      if (nums[i] == target) {
        return i;
        // if the value is bigger than target value than again we will return that value
      } else if (nums[i] > target) return i;
    }
    // than after that we will return the whole list of list - both values from above
    return nums.length;
  }
/*
Runtime: 403 ms, faster than 83.78% of Dart online submissions for Search Insert Position.
Memory Usage: 144.5 MB, less than 13.51% of Dart online submissions for Search Insert Position.
*/
}
