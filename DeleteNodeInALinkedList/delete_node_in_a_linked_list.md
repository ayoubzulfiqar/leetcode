# 🔥 Delete Node in a Linked List 🔥 || 3 Solutions || Simple Fast and Easy || with Explanation TC(1) || Space(1)

## Definition for singly-linked list

```dart
class TreeNode {
  int val;
  TreeNode? next;
  TreeNode([this.val = 0, this.next]);
}
```

## Solution - 1

```dart
class Solution {
  void deleteNode(TreeNode? node) {
    // Step 1: Set value of current node as value of next node

    node?.val = node.next!.val;

    // Step 2: Delete the next node from list
    node?.next = node.next?.next;
  }
}
```

## Solution - 2

```dart
class Solution {
  void deleteNode(TreeNode? node) {
    node = node?.next; //just copy
  }
}
```

## Solution - 3

```dart
class Solution {
  void deleteNode(TreeNode? node) {
    TreeNode? temp = node?.next; //store delete node in temp
    node?.val = node.next!.val; //copy the data
    node?.next = node.next!.next; //making link also break link
    deleteNode(temp); //delete the data because don't want memory leak
  }
}
```

## Disclaimer:-

### This Solution is not available in DART Programing language which is a bummer. Hurts my feeling. But as a man we should implement it no matter what. We are not bunch of wussies who gonna skip it if it's not available in one language we love. Instead we will conquer the sea and rivers and cross the mountains so see what's lies beyond our horizons
