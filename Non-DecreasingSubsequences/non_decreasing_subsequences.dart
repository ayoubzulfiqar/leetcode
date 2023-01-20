/*


-* 491. Non-decreasing Subsequences *-

Given an integer array nums, return all the different possible non-decreasing subsequences of the given array with at least two elements. You may return the answer in any order.

 

Example 1:

Input: nums = [4,6,7,7]
Output: [[4,6],[4,6,7],[4,6,7,7],[4,7],[4,7,7],[6,7],[6,7,7],[7,7]]
Example 2:

Input: nums = [4,4,3,2,1]
Output: [[4,4]]
 

Constraints:

1 <= nums.length <= 15
-100 <= nums[i] <= 100

*/

import 'dart:collection';

class A {
  List<List<int>> findSubsequences(List<int> nums) {
    List<List<int>> ans = [];
    // use a List to store the unique sub sequences
    dfs(nums, 0, <int>[], ans);
    return ans;
  }

  void dfs(List<int> nums, int s, List<int> path, List<List<int>> ans) {
    if (path.length > 1) ans.add(path.toList());

    HashSet<int> used = HashSet();

    for (int i = s; i < nums.length; ++i) {
      if (used.contains(nums[i])) continue;
      // if the path is empty or the current element is greater than or equal to the last element in the path
      if (path.isEmpty || nums[i] >= path.last) {
        // add the current element to the used and recursively call dfs
        used.add(nums[i]);
        path.add(nums[i]);
        // recursively call dfs without adding the current element to the path
        dfs(nums, i + 1, path, ans);
        path.removeLast(); // remove the last element from the path before returning
      }
    }
  }
}

class B {
  late List<List<int>> res;
  List<List<int>> findSubsequences(List<int> nums) {
    res = [];
    helper(<int>[], nums, 0);
    return res;
  }

  void helper(List<int> list, List<int> nums, int start) {
    HashSet<int> set = HashSet();
    if (start == nums.length) {
      return;
    }
    for (int i = start; i < nums.length; i++) {
      if (set.contains(nums[i])) {
        continue;
      }
      set.add(nums[i]);
      if (list.length == 0 || nums[i] >= list[list.length - 1]) {
        list.add(nums[i]);
        if (list.length > 1) {
          res.add(list.toList());
        }
        helper(list, nums, i + 1);
        list.remove(list.length - 1);
      }
    }
  }
}
