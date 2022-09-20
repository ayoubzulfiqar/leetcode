/*


 -* Binary Tree Inorder Traversal *-


Given the root of a binary tree, return the inorder traversal of its nodes' values.



Example 1:
Input: root = [1,null,2,3]
Output: [1,3,2]


Example 2:
Input: root = []
Output: []


Example 3:
Input: root = [1]
Output: [1]


Constraints:

The number of nodes in the tree is in the range [0, 100].
-100 <= Node.val <= 100


*/

/*

This is one of the basic Tree questions. Since, it is a tree question, we can safely think the solution could be RECURSIVE.

Since, we are supposed to return a vector of integers, I declared that as the first line in my code.
Later, if the base condition, which is, if root == NULL it shall return the empty vector.
Else, we populate the initialized vector with left children of the current root, by calling the same function on Left child.
Then, we just push_back the root->val into the vector.
Later, we should call for root->right to insert the Right children.

By the way,
InOrder = Left, root, Right
PreOrder = root, Left, Right
PostOrder = Left, Right, root

Functions used in the code:
if only one data value: vector_name.insert( position_to_insert, data )
if another vector: vector_name.insert( position_to_insert , vector2_name.begin(),vector2_name.end() )
vector2_name is inserted at the desired location in vector_name. for this question it is vector_name.end().
vector_name.begin() -> returns a pointer where the vector starts
vector_name.end() -> returns a pointer where the vector ends

*/

//- Definition for a binary tree node.

class TreeNode {
  int val;
  TreeNode? left;
  TreeNode? right;
  TreeNode([this.val = 0, this.left, this.right]);
}

// Recursive
class A {
  // 70 / 70 test cases passed, but took too long.
  List<int> inorderTraversal(TreeNode? root) {
    List<int> res = <int>[];
    if (root == null) return res;
    helper(root, res);
    return res;
  }

  void helper(TreeNode? root, List<int> res) {
    if (root == null) return;
    helper(root.left, res);
    res.add(root.val);
    helper(root.right, res);
  }
}

// Stack
class B {
  List<int> inorderTraversal(TreeNode? root) {
    List stack = [];
    List<int> ans = [];
    while (root != null || stack.length != 0) {
      while (root != null) {
        stack.add(root);
        root = root.left;
      }
      root = stack.removeLast();
      ans.add(root!.val);
      root = root.right;
    }
    return ans;
  }

  // Runtime: 372 ms, faster than 80.00% of Dart online submissions for Binary Tree Inorder Traversal.
// Memory Usage: 140.2 MB, less than 86.67% of Dart online submissions for Binary Tree Inorder Traversal.
}

class C {
  // 70 / 70 test cases passed, but took too long.
  List<int> inorderTraversal(TreeNode? root) {
    List<int> ans = <int>[];
    inOrder(root, ans);
    return ans;
  }

  void inOrder(TreeNode? root, List<int> ans) {
    while (root != null) {
      if (root.left == null) {
        ans.add(root.val);
        root = root.right;
      } else {
        TreeNode? temp = getPreOrderSuccessor(root);
        temp.right = root;
        TreeNode? left = root.left;
        root.left = null;
        root = left!;
      }
    }
  }

  TreeNode getPreOrderSuccessor(TreeNode root) {
    TreeNode? node = root.left;
    while (node!.right != null) {
      node = node.right;
    }
    return node;
  }
}
