/*


-* 1339. Maximum Product of Splitted Binary Tree *-


Given the root of a binary tree, split the binary tree into two subtrees by removing one edge such that the product of the sums of the subtrees is maximized.

Return the maximum product of the sums of the two subtrees. Since the answer may be too large, return it modulo 109 + 7.

Note that you need to maximize the answer before taking the mod and not after taking it.

 

Example 1:


Input: root = [1,2,3,4,5,6]
Output: 110
Explanation: Remove the red edge and get 2 binary trees with sum 11 and 10. Their product is 110 (11*10)
Example 2:


Input: root = [1,null,2,3,4,null,null,5,6]
Output: 90
Explanation: Remove the red edge and get 2 binary trees with sum 15 and 6.Their product is 90 (15*6)
 

Constraints:

The number of nodes in the tree is in the range [2, 5 * 104].
1 <= Node.val <= 104



*/

// Definition for a binary tree node.
import 'dart:collection';
import 'dart:math';

class TreeNode {
  int val;
  TreeNode? left;
  TreeNode? right;
  TreeNode([this.val = 0, this.left, this.right]);
}

class A {
  int sum = 0;
  int maxProd = 0;
  int maxProduct(TreeNode? root) {
    dfs(root);
    int rootProd = checkMax(root);
    return (maxProd % (pow(10, 9) + 7)).toInt();
  }

  void dfs(TreeNode? root) {
    if (root == null) return null;
    sum += root.val;
    dfs(root.left);
    dfs(root.right);
  }

  int checkMax(TreeNode? root) {
    if (root == null) return 0;
    int l = checkMax(root.left);
    int r = checkMax(root.right);
    maxProd = max(maxProd, (l + r + root.val) * (sum - l - r - root.val));
    return l + r + root.val;
  }
}

class B {
  HashMap<TreeNode?, List<int>> map = HashMap();
  int mod = 1000000007;
  int res = 0;

  int maxProduct(TreeNode? root) {
    getSum(root);
    helper(root, 0);
    return (res % mod);
  }

  void helper(TreeNode? node, int pre) {
    if (node == null) return;
    int left = map[node]![0];
    int right = map[node]![1];
    res = max(res, left * (pre + node.val + right));
    res = max(res, right * (pre + node.val + left));
    helper(node.left, pre + node.val + right);
    helper(node.right, pre + node.val + left);
  }

  int getSum(TreeNode? node) {
    if (node == null) return 0;
    int left = getSum(node.left);
    int right = getSum(node.right);
    map[node] = [left, right];
    return left + right + node.val;
  }
}

class C {
  int res = 0;
  int maxProduct(TreeNode? root) {
    int mod = (1e9 + 7).toInt();
    int sum = allSum(root);
    inOrder(root, sum);

    int num1 = res;
    int num2 = sum - res;
    int ans = 0;
    // Calculate the product
    for (int i = 0; i < num1; i++) {
      ans += num2;
      if (ans > mod) {
        ans -= mod;
      }
    }

    return ans;
  }

  int inOrder(TreeNode? root, int sum) {
    int cur = 0;
    if (root == null) {
      return 0;
    }
    cur += inOrder(root.left, sum);
    cur += root.val;
    cur += inOrder(root.right, sum);
    int minClose = (res - sum ~/ 2).abs();
    int curClose = (cur - sum ~/ 2).abs();
    res = curClose < minClose ? cur : res;

    return cur;
  }

  int allSum(TreeNode? root) {
    if (root == null) {
      return 0;
    }
    return root.val + allSum(root.left) + allSum(root.right);
  }
}
