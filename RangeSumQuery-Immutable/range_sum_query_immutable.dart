/*



-* Range Sum Query - Immutable *-




Given an integer array nums, handle multiple queries of the following type:

Calculate the sum of the elements of nums between indices left and right inclusive where left <= right.
Implement the NumArray class:

NumArray(int[] nums) Initializes the object with the integer array nums.
int sumRange(int left, int right) Returns the sum of the elements of nums between indices left and right inclusive (i.e. nums[left] + nums[left + 1] + ... + nums[right]).


Example 1:

Input
["NumArray", "sumRange", "sumRange", "sumRange"]
[[[-2, 0, 3, -5, 2, -1]], [0, 2], [2, 5], [0, 5]]
Output
[null, 1, -1, -3]

Explanation
NumArray numArray = new NumArray([-2, 0, 3, -5, 2, -1]);
numArray.sumRange(0, 2); // return (-2) + 0 + 3 = 1
numArray.sumRange(2, 5); // return 3 + (-5) + 2 + (-1) = -1
numArray.sumRange(0, 5); // return (-2) + 0 + 3 + (-5) + 2 + (-1) = -3


Constraints:

1 <= nums.length <= 104
-105 <= nums[i] <= 105
0 <= left <= right < nums.length
At most 104 calls will be made to sumRange.



*/

// class NumArray {
//   List<int> arr = [];
//   NumArray(List<int> nums) {
//     this.arr = nums;
//   }

//   int sumRange(int left, int right) {
//     int sum = 0;
//     for (int i = left; i <= right; i++) sum += this.arr[i];
//     return sum;
//   }
// }
// class NumArray {
//   late List<int> nums;
//   late List<int> prefixSum;
//   NumArray(List<int> nums) {
//     this.nums = nums;
//     this.prefixSum = getPrefixSum();
//   }

//   int sumRange(int left, int right) {
//     if (left == 0) return prefixSum[right];
//     return prefixSum[right] - prefixSum[left - 1];
//   }

//   List<int> getPrefixSum() {
//     int sum = 0;
//     List<int> ans = List.filled(nums.length, 0);

//     for (int i = 0; i < nums.length; i++) {
//       sum += nums[i];
//       ans[i] = sum;
//     }

//     return ans;
//   }
// }

class NumArray {
  late List<int> prefixSum;

  NumArray(List<int> nums) {
    if (nums == 0) {
      throw ArgumentError("Panic: Input is Empty");
    }

    this.prefixSum = List.filled(nums.length + 1, 0);

    for (int i = 1; i <= nums.length; i++) {
      prefixSum[i] = prefixSum[i - 1] + nums[i - 1];
    }
  }

  int sumRange(int left, int right) {
    if (left < 0 || right >= prefixSum.length - 1) {
      throw RangeError("Panic: Input indices are out of bounds");
    }

    // Here both left and right are inclusive.
    // right maps to right+1 in prefixSum. left maps to left+1 in prefixSum.
    // To get the result subtract the prefixSum before left index from prefixSum at
    // right index.
    return prefixSum[right + 1] - prefixSum[left];
  }
}
