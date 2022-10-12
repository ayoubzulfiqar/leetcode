/*


 -* Binary Tree Paths *-



Given the root of a binary tree, return all root-to-leaf paths in any order.

A leaf is a node with no children.



Example 1:


Input: root = [1,2,3,null,5]
Output: ["1->2->5","1->3"]
Example 2:

Input: root = [1]
Output: ["1"]


Constraints:

The number of nodes in the tree is in the range [1, 100].
-100 <= Node.val <= 100

*/

// Definition for a binary tree node.

class TreeNode {
  int val;
  TreeNode? left;
  TreeNode? right;
  TreeNode([this.val = 0, this.left, this.right]);
}

/*


*/

class A {
// Runtime: 466 ms, faster than 50.00% of Dart online submissions for Binary Tree Paths.
// Memory Usage: 142.6 MB, less than 50.00% of Dart online submissions for Binary Tree Paths.
  List<String> binaryTreePaths(TreeNode? root) {
    List<String> res = [];
    if (root == null) return res;
    dfs(root, res, "");
    return res;
  }

  void dfs(TreeNode? root, List ls, String str) {
    if (root == null) return;
    str += (str.length == 0 ? "" : "->") + root.val.toString();
    if (root.left == null && root.right == null) {
      ls.add(str);
      return;
    }
    dfs(root.left, ls, str);
    dfs(root.right, ls, str);
  }
}

class B {
// wrong
  List binaryTreePaths(TreeNode? root) {
    List<String> res = [];
    StringBuffer sb = StringBuffer();
    if (root == null) return res;
    dfs(root, res, sb);
    return res;
  }

  void dfs(TreeNode? root, List ls, StringBuffer str) {
    if (root == null) return;
    str.write((str.length == 0 ? "" : "->") + root.val.toString());
    if (root.left == null && root.right == null) {
      ls.add(str.toString());
      return;
    }
    dfs(root.left, ls, str);
    str.length;
    dfs(root.right, ls, str);
    str.length;
  }
}

class C {
  List<String> binaryTreePaths(TreeNode? root) {
    List<String> res = [];
    if (root == null) {
      return res;
    }
    StringBuffer sb = StringBuffer();
    dfs(root, res, sb);
    return res;
  }

  void dfs(TreeNode root, List<String> res, StringBuffer sb) {
    if (root.left == null && root.right == null) {
      sb.write("" + root.val.toString());
      res.add(sb.toString());
      return;
    }
    if (root.left != null) {
      String prev = sb.toString();
      sb.write(root.val.toString() + "->");
      dfs(root.left!, res, sb);
      sb = StringBuffer([prev]);
    }
    if (root.right != null) {
      sb.write(root.val.toString() + "->");
      dfs(root.right!, res, sb);
    }
  }
}
