/*

   -* Pseudo-Palindromic Paths in a Binary Tree *-



Given a binary tree where node values are digits from 1 to 9.
A path in the binary tree is said to be pseudo-palindromic if at least one permutation of the node
values in the path is a palindrome.

Return the number of pseudo-palindromic paths going from the root node to leaf nodes.



Example 1:


Input: root = [2,3,1,3,1,null,1]
Output: 2
Explanation: The figure above represents the given binary tree.
There are three paths going from the root node to leaf nodes:
the red path [2,3,3], the green path [2,1,1], and the path [2,3,1]. Among these paths only
red path and green path are pseudo-palindromic paths since the red path [2,3,3] can be rearranged in [3,2,3] (palindrome) and
the green path [2,1,1] can be rearranged in [1,2,1] (palindrome).


Example 2:


Input: root = [2,1,1,1,3,null,null,null,null,null,1]
Output: 1
Explanation: The figure above represents the given binary tree. There are three paths going from the root node to leaf nodes: the green path [2,1,1], the path [2,1,3,1], and the path [2,1]. Among these paths only the green path is pseudo-palindromic since [2,1,1] can be rearranged in [1,2,1] (palindrome).
Example 3:

Input: root = [9]
Output: 1


Constraints:

The number of nodes in the tree is in the range [1, 105].
1 <= Node.val <= 9


*/

// Definition for a binary tree node.
import 'dart:collection';

class TreeNode {
  int val;
  TreeNode? left;
  TreeNode? right;
  TreeNode([this.val = 0, this.left, this.right]);
}

class A {
  int answer = 0;
  int pseudoPalindromicPaths(TreeNode? root) {
    preOrder(root, 0);

    return answer;
  }

  void preOrder(TreeNode? root, int bitMask) {
    if (root == null) return;
    bitMask ^= (1 << root.val);
    if (root.left == null &&
        root.right == null &&
        ((bitMask & (bitMask - 1)) == 0)) {
      answer++;
    }
    preOrder(root.left, bitMask);
    preOrder(root.right, bitMask);
  }
}

class B {
  int pseudoPalindromicPaths(TreeNode? root) {
    int count = 0;
    void findPaths(TreeNode? root, int path) {
      if (root != null) {
        path ^= (1 << root.val);

        if (root.right == null && root.left == null) {
          if ((path & (path - 1)) == 0) count++;
        }

        findPaths(root.left, path);
        findPaths(root.right, path);

        path ^= (1 << root.val); //backtracking step

      }
    }

    int path = 0;
    findPaths(root, path);

    return count;
  }
}

class C {
  int pseudoPalindromicPaths(TreeNode? root) {
    int findPath(TreeNode? root, int mask) {
      if (root == null) return 0;
      // if root->val has occured odd times set to even times
      // else if root->val has occured even times set to odd times
      int k = 1 << root.val;
      mask = mask ^ k;

      if (root.left == null && root.right == null) {
        // if leaf node check how many numbers has occured odd times
        // if odd occurence are zero or one return true else false
        if (mask == 0) return 1;
        mask = mask & (mask - 1);
        if (mask == 0) return 1;
        return 0;
      }

      return findPath(root.left, mask) + findPath(root.right, mask);
    }

    int mask = 0;
    // zero means every number has occured even times
    return findPath(root, mask);
  }
}

class D {
  int pseudoPalindromicPaths(TreeNode? root) {
    int solve(TreeNode? root, HashSet<int> hash) {
      if (root == null) return 0;
      if (root.left == null && root.right == null) {
        //   hash[root.val]++;
        hash.add(root.val++);
        int odd = 0;
        // cout<<endl;
        for (int i = 0; i < 10; i++) {
          // cout<<hash[i]<<" ";
          if ((hash.elementAt(i) & 1) == 0) //frequency of digit is odd
          {
            odd++;
          }
          if (odd > 1) return 0;
        }

        return 1;
      }
      // hash[root.val]++;
      hash.add(root.val--);
      int left = solve(root.left, hash);
      int right = solve(root.right, hash);

      return left + right;
    }

    HashSet<int> hash = [10, 0] as HashSet<int>;
    // HashSet<int> h = HashMap.from(h)
    return solve(root, hash);
  }
}

class E {
  int pseudoPalindromicPaths(TreeNode? root) {
    int helper(TreeNode? root, List<int> array, int cnt) {
      if (root == null) return 0;
      cnt += (++array[root.val]) % 2 == 0 ? -1 : 1;
      int res = helper(root.left, array, cnt) +
          helper(root.right, array, cnt) +
          (root.left == null && root.right == null && cnt <= 1 ? 1 : 0);
      --array[root.val];
      return res;
    }

    List<int> array = [10];
    return helper(root, array, 0);
  }
}

class F {
  int count = 0;
  int pseudoPalindromicPaths(TreeNode? root) {
    void dfs(TreeNode? node, HashSet<int> unpaired) {
      if (node == null) return;

      if (!unpaired.add(node.val)) unpaired.remove(node.val);

      if (node.left == null && node.right == null) {
        if (unpaired.length <= 1) count++;
      }

      dfs(node.left, unpaired);
      dfs(node.right, unpaired);
    }

    dfs(root, HashSet());
    return count;
  }
}

class G {
  int pseudoPalindromicPaths(TreeNode? root) {
    HashMap<int, int> mp = HashMap();
    if (root == null) return 0;

    mp[root.val++];

    // mp.entries.elementAt(root.val++);

    if (root.left == null && root.right == null) {
      int count = 0;
      // for (int i in mp) if (i.remainder(2) != 0) count++;
      mp.forEach((key, value) {
        if ((mp[key]! % 2) == 1) count++;
      });
      mp[root.val--];

      if (count <= 1) return 1;
      return 0;
    }

    int x =
        pseudoPalindromicPaths(root.left) + pseudoPalindromicPaths(root.right);
    mp[root.val--];
    return x;
  }
}

class H {
  int pseudoPalindromicPaths(TreeNode? root) {
    int count = 0;

    recursiveFunction(TreeNode? node, Map<int, dynamic> map) {
      if (node == null) return;

      // storing/updating the frequency on map
      map[node.val] = (map[node.val] == map[node.val] || map[node.val] == 1);
      // If we are reaching at the end of the leaf we have to check the frequencies
      if (node.left == null && node.right == null) {
        bool? frequency = false;
        // for (int key in map) {
        //   // checking character having odd frequency for only one character.
        //   if (map[key] % 2 == 1) {
        //     if (!frequency)
        //       frequency = true;
        //     else
        //       return;
        //   }
        // }
        map.forEach((key, value) {
          if (map[key] % 2 == 1) {
            if (frequency == null) {
              frequency = true;
            } else {
              return;
            }
          }
        });
        count++;
      }
      // passing the hashmap to the child elements
      if (node.left == 1) recursiveFunction(node.left, {...map});
      if (node.right == 1) recursiveFunction(node.right, {...map});
    }

    ;
    recursiveFunction(root, {});
    return count;
  }
}
