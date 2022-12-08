/*


-* 872. Leaf-Similar Trees *-



Consider all the leaves of a binary tree, from left to right order, the values of those leaves form a leaf value sequence.



For example, in the given tree above, the leaf value sequence is (6, 7, 4, 9, 8).

Two binary trees are considered leaf-similar if their leaf value sequence is the same.

Return true if and only if the two given trees with head nodes root1 and root2 are leaf-similar.

 

Example 1:


Input: root1 = [3,5,1,6,2,9,8,null,null,7,4], root2 = [3,5,1,6,7,4,2,null,null,null,null,null,null,9,8]
Output: true
Example 2:


Input: root1 = [1,2,3], root2 = [1,3,2]
Output: false
 

Constraints:

The number of nodes in each tree will be in the range [1, 200].
Both of the given trees will have values in the range [0, 200].

*/

// Definition for a binary tree node.
class TreeNode {
  int val;
  TreeNode? left;
  TreeNode? right;
  TreeNode([this.val = 0, this.left, this.right]);
}

// class A {
//   void findVal(TreeNode? root, List<int> r, int index) {
//     if (root == null) return;
//     if (root.left == null && root.right == null) {
//       r[index] = root.val;
//       index++;
//       return;
//     }
//     findVal(root.left, r, index);
//     findVal(root.right, r, index);
//   }

//   bool leafSimilar(TreeNode? root1, TreeNode? root2) {
//     List<int> r1 = List.filled(5000, 0);
//     List<int> r2 = List.filled(5000, 0);
//     int i = 0;
//     findVal(root1, r1, i);
//     int j = 0;
//     findVal(root2, r2, j);
//     if (i != j) return false;
//     for (int k = 0; k < j; ++k) {
//       if (r1[k] != r2[k]) return false;
//     }
//     return true;
//   }
// }

class B {
  int dfs(List<TreeNode?> s) {
    while (true) {
      TreeNode? node = s.removeLast();
      if (node?.right != null) s.add(node?.right);
      if (node?.left != null) s.add(node?.left);
      if (node?.left == null && node?.right == null) return node!.val;
    }
  }

  bool leafSimilar(TreeNode? root1, TreeNode? root2) {
    List<TreeNode?> s1 = [], s2 = [];
    s1.add(root1);
    s2.add(root2);
    while (s1.isNotEmpty && s2.isNotEmpty) if (dfs(s1) != dfs(s2)) return false;
    return s1.isEmpty && s2.isEmpty;
  }
}

class C {
  void getLeaf(TreeNode? root, List<int> l) {
    if (root == null) return;
    if (root.left == null && root.right == null) {
      l.add(root.val);
      return;
    }
    getLeaf(root.left, l);
    getLeaf(root.right, l);
  }

  bool leafSimilar(TreeNode? root1, TreeNode? root2) {
    List<int> l1 = [], l2 = [];
    getLeaf(root1, l1);
    getLeaf(root2, l2);
    if (l1.length != l2.length) return false;
    for (int i = 0; i < l1.length; ++i) if (l1[i] != l2[i]) return false;
    return true;
  }
}
