/*

-- 1424. Diagonal Traverse II--


Given a 2D integer array nums, return all elements of nums in diagonal order as shown in the below images.

 

Example 1:


Input: nums = [[1,2,3],[4,5,6],[7,8,9]]
Output: [1,4,2,7,5,3,8,6,9]
Example 2:


Input: nums = [[1,2,3,4,5],[6,7],[8],[9,10,11],[12,13,14,15,16]]
Output: [1,6,2,8,7,3,9,4,12,10,5,13,11,14,15,16]
 

Constraints:

1 <= nums.length <= 105
1 <= nums[i].length <= 105
1 <= sum(nums[i].length) <= 105
1 <= nums[i][j] <= 105

*/

import 'dart:collection';


class Solution {
  List<int> findDiagonalOrder(List<List<int>> nums) {
    final HashMap<int, List<int>> diagonals = HashMap();
    final List<int> ans = <int>[];
  final  int n = nums.length;

    for (int i = 0; i < n; i++) {
      final int m = nums[i].length;
      for (int j = 0; j < m; j++) {
        final int sum = i + j;
        if (!diagonals.containsKey(sum)) {
          diagonals[sum] = <int>[];
        }
        diagonals[sum]?.add(nums[i][j]);
      }
    }

    diagonals.forEach((sum, arr) {
      for (int i = arr.length - 1; i >= 0; i--) {
        ans.add(arr[i]);
      }
    });

    return ans;
  }
}
