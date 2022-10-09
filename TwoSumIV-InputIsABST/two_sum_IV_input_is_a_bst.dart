/*

 -* Two Sum IV - Input is a BST *-

Given the root of a Binary Search Tree and a target number k, return true if there exist two elements in the BST such that their sum is equal to the given target.



Example 1:


Input: root = [5,3,6,2,4,null,7], k = 9
Output: true
Example 2:


Input: root = [5,3,6,2,4,null,7], k = 28
Output: false


Constraints:

The number of nodes in the tree is in the range [1, 104].
-104 <= Node.val <= 104
root is guaranteed to be a valid binary search tree.

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
// Runtime: 544 ms, faster than 100.00% of Dart online submissions for Two Sum IV - Input is a BST.
// Memory Usage: 150 MB, less than 100.00% of Dart online submissions for Two Sum IV - Input is a BST.
  List<int> array = [];
  // inOrder to reading the tree top to bottom
  void inorder(TreeNode? root) {
    // if our root is null means there is nothing to begin with
    if (root == null) return;
    // reading the tree from left side
    inorder(root.left);
    // adding the value inside the array
    array.add(root.val);
    // than reading the tree from left side
    inorder(root.right);
  }

  bool findTarget(TreeNode? root, int k) {
    // if the root is null means we have found nothing
    if (root == null) return false;
    // than simply we will return the root of the tree
    inorder(root);
    // first pointer - beginning of the array (Left Side)
    int low = 0;
    // second pointer - end of the array (Right Side)
    int high = array.length - 1;
    // assuming all the value on the left side means low side of the array is smaller than the right side
    while (low < high) {
      // if the sum of the first value and the last value from both side is same as target than turn true
      if (array[low] + array[high] == k)
        return true;
      // if sum is less than the target value means the target value is on right side of the array
      else if (array[low] + array[high] < k)
        // than we will move forward toward the right side
        low++;
      else
        // if sum is greater than the target value means the target value is on right side of the array
        // than we will move backward toward the right side
        high--;
    }
    // if everything sucks than we will return false
    return false;
  }
}

class B {
// Runtime: 689 ms, faster than 100.00% of Dart online submissions for Two Sum IV - Input is a BST.
// Memory Usage: 159.9 MB, less than 100.00% of Dart online submissions for Two Sum IV - Input is a BST.
  bool findTarget(TreeNode? root, int k) {
    // if the root is null means we have nothing
    if (root == null) return false;
    // to sort our tree
    List<int> array = [];
    // looking for target - extra variable
    int target = k;
    //level order traversal and storing values in list
    Queue<TreeNode?> queue = Queue();
    // adding our root to the queue
    queue.add(root);
    // assuming nothing is empty
    while (queue.isNotEmpty) {
      // if so we will remove the first value
      TreeNode tempNode = queue.removeFirst()!;
      // than we will add the value into the array for sorting - means arranging the values
      array.add(tempNode.val);
      // if the left side have values and it's not null
      if (tempNode.left != null) {
        // we will add all the value into the queue
        queue.add(tempNode.left);
      }
      // if the right side is not null - means not empty than we will also  add them
      if (tempNode.right != null) {
        queue.add(tempNode.right);
      }
    }
    // if our array is only have one value or 0 means less than blah blah we have nothing
    if (array.length <= 1) return false;
    //simple two sum logic
    // lopping through each and every element
    for (int i = 0; i < array.length; i++) {
      // the temp value if the target value - the each and every element
      int temp = target - array.elementAt(i);
      // if our array contain that value
      if (array.contains(temp)) {
        // and it matches with array value at any point
        int pos = array.indexOf(temp);
        // if the element and the position matches Congratulation -*You are Married*-
        if (i == pos) continue;
        return true;
      }
    }
    // otherwise she Rejected your proposal -* Better Luck Next Time Bro*-
    return false;
  }
}

class C {
// Runtime: 571 ms, faster than 100.00% of Dart online submissions for Two Sum IV - Input is a BST.
// Memory Usage: 153.4 MB, less than 100.00% of Dart online submissions for Two Sum IV - Input is a BST.
  HashSet hashSet = HashSet();
  bool findTarget(TreeNode? root, int k) {
    if (root == null) return false;
    //Now k= num1 + num2 then here num1 is data and num2 is root.val
    int data = k - root.val;
    if (hashSet.contains(data)) {
      //Check the data is contain set
      return true;
    } else {
      hashSet.add(root.val);
    }
    return findTarget(root.left, k) ? true : findTarget(root.right, k);
  }
}
