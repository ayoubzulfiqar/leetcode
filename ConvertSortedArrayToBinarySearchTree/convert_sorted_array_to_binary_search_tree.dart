/*

  -*   Convert Sorted Array to Binary Search Tree *-


Given an integer array nums where the elements are sorted in ascending order, convert it to a height-balanced binary search tree.

A height-balanced binary tree is a binary tree in which the depth of the two subtrees of every node never differs by more than one.



Example 1:


Input: nums = [-10,-3,0,5,9]
Output: [0,-3,9,-10,null,5]
Explanation: [0,-10,5,null,-3,null,9] is also accepted:

Example 2:


Input: nums = [1,3]
Output: [3,1]
Explanation: [1,null,3] and [3,1] are both height-balanced BSTs.


Constraints:

1 <= nums.length <= 104
-104 <= nums[i] <= 104
nums is sorted in a strictly increasing order.

*/

// Definition for a binary tree node.
class TreeNode {
  int val;
  TreeNode? left;
  TreeNode? right;
  TreeNode([this.val = 0, this.left, this.right]);
}

class A {
// Runtime: 428 ms, faster than 100.00% of Dart online submissions for Convert Sorted Array to Binary Search Tree.
// Memory Usage: 144.5 MB, less than 40.00% of Dart online submissions for Convert Sorted Array to Binary Search Tree.

  TreeNode? sortedArrayToBST(List<int> nums) {
    // index value of our list nums
    int index = nums.length - 1;
    // nums is our whole list and 0  is first value and index is our index start from 0
    return populate(nums, 0, index);
  }

  TreeNode? populate(List<int> numbers, int from, int to) {
    if (from > to && numbers.length == 0) return null;

    // finding mid point from a list
    int mid = (from + to) ~/ 2;
    // our tree node will hold the result the mid value
    TreeNode? result = TreeNode(numbers[mid]);
    // if the mid value is greater than we will populate left side of the TreeNode
    if (mid > from) result.left = populate(numbers, from, (mid - 1));
    // if the mid value is less than we will populate right side of the TreeNode
    if (mid < to) result.right = populate(numbers, mid + 1, to);

    return result;
  }
}

class B {
  TreeNode? sortedArrayToBST(List<int> nums) {
    return createTree(nums, 0, nums.length - 1);
  }

  createTree(List<int> nums, int start, int end) {
    // base case :
    if (start == end) return TreeNode(nums[start]);
    if (start > end) return null;

    // create the node :
    int mid = ((start + end) / 2).floor();
    var node = TreeNode(nums[mid]);

    // find the children of the node :
    node.left = createTree(nums, start, mid - 1);
    node.right = createTree(nums, mid + 1, end);

    // return the node with its children :
    return node;
  }
}
