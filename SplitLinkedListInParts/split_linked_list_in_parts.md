# 🔥 Linear Splitting Algorithm 🔥 || Simple Fast and Easy || with Explanation 😈

## Intuition and Approach

The goal of this algorithm is to split a singly linked list into `k` nearly equal parts. It achieves this by calculating the length of the linked list and then distributing the elements into `k` parts while considering the possibility of extra elements.

**Approach**:

1. **Calculate List Length**:
   - Traverse the linked list from the beginning to the end while counting the number of nodes. This count represents the total length of the list.

2. **Distribute Elements**:
   - Determine the base length of each part by dividing the total length by `k`.
   - Calculate the number of extra elements by taking the remainder when dividing the total length by `k`.
   - Initialize a pointer `current` to the head of the linked list.

3. **Split the List**:
   - Iterate through `k` parts.
   - For each part, assign the `current` node as the starting node of that part.
   - Calculate the length of the current part, which is the base length plus one if there are extra elements remaining.
   - Move the `current` pointer to the end of the current part by traversing `currentLength - 1` nodes.
   - Disconnect the current part from the next part by setting the `next` pointer of the last node of the current part to `null`.
   - Repeat this process for all `k` parts.

4. **Return the Result**:
   - The result is an array of pointers to the heads of the `k` parts, each forming a separate linked list.

### Space Complexity

- The space complexity of this algorithm is O(k), where `k` represents the number of parts. It requires space to store an array of pointers to the head nodes of the parts.

### Time Complexity

- The time complexity of this algorithm is O(n), where `n` is the total number of nodes in the linked list.
- It involves two passes through the linked list: one to calculate the length and another to split it into `k` parts.
- The first pass (calculating the length) takes linear time as it iterates through all nodes.
- The second pass (splitting into parts) also takes linear time since it iterates through the nodes again while distributing them into `k` parts.

Overall, the algorithm efficiently splits the linked list into `k` nearly equal parts with linear time complexity and requires additional space for the resulting array of parts.

```dart
//  Definition for singly-linked list.
class ListNode {
  int val;
  ListNode? next;
  ListNode([this.val = 0, this.next]);
}

class Solution {
  List<ListNode?> splitListToParts(ListNode? head, int k) {
    ListNode? current = head;
    final List<ListNode?> answer = List<ListNode?>.filled(k, null);
    int ptr = 0;
    int listLength = 0;

    // Calculate the length of the linked list
    while (current != null) {
      listLength++;
      current = current.next;
    }

    // Calculate the extra elements in some parts
    int extra = listLength % k;
    // Calculate the base length for each part
    final int partLength = listLength ~/ k;
    current = head;

    while (current != null) {
      answer[ptr++] = current;
      // Calculate the length of the current part
      int currentLength = partLength - 1 + ((extra-- > 0) ? 1 : 0);

      // Move the current pointer to the end of the current part
      for (int i = 0; i < currentLength; i++) current = current?.next;

      // Disconnect the current part from the next part
      ListNode? temp = current?.next;
      current?.next = null;
      current = temp;
    }
    return answer;
  }
}
```

## [GitHub](https://github.com/ayoubzulfiqar/leetcode)
