#

## Solution - 1 Sliding Window


### Code Explanation

1. The `maxConsecutiveAnswers` function takes an `answerKey` string and an integer `k` as input. It calculates the maximum consecutive answers by calling the `flipper` function twice, once for flipping 'F' and once for flipping 'T'. It returns the maximum count among the two results.

2. The `flipper` function takes the `answerKey`, `k`, and the character `countLetter` as input. It initializes variables `max` and `count` to keep track of the maximum consecutive count and the current count, respectively. It also uses a `Queue` called `queue` to store the indices of flipped answers.

3. The function iterates through the `answerKey` string using a for loop. For each character at index `i`, it checks if it matches the `countLetter`. If it does, the `count` is incremented.

4. If the character doesn't match `countLetter`, it checks if there are remaining flips (`k > 0`). If there are, it performs the flip by adding the index `i` to the `queue`, decrementing `k`, and incrementing the `count`.

5. If there are no remaining flips (`k = 0`), it means the window has reached its maximum size. It updates the `max` value by comparing the current `count` with the previous maximum. Then, it removes the first encountered index from the `queue` and calculates the new `count` by subtracting the removed index from the current index.

6. After the loop, it performs a final check to update `max` if the last window's `count` is greater than the current maximum.

7. The function returns the final `max` value.

Now, let's analyze the space and time complexity of the algorithm:

**Space Complexity:** The space complexity of the algorithm is as follows:

- The `Queue` used to store the indices of flipped answers can have a maximum size of `k` elements, depending on the number of allowed flips. Therefore, the space complexity of the `Queue` is O(k).
- The other variables (`max`, `count`, and `letter`) used in the algorithm require constant space, so they don't contribute significantly to the overall space complexity.

Hence, the overall space complexity is O(k), where `k` represents the maximum number of flips allowed.

**Time Complexity:** The time complexity of the algorithm is as follows:

- The algorithm iterates through the `answerKey` string once using a for loop. Since the loop runs `n` times, where `n` is the length of the `answerKey`, the time complexity of the loop is O(n).
- Within the loop, the operations performed, such as comparing characters, adding/removing elements from the `Queue`, and updating variables, all take constant time.
  
Therefore, the overall time complexity of the algorithm is O(n), where `n` represents the length of the input `answerKey`.

In summary, the space complexity is O(k), and the time complexity is O(n), where `k` represents the maximum number of flips allowed, and `n` represents the length of the `answerKey`.

```dart
import 'dart:collection';
import 'dart:math';

class Solution {
  int maxConsecutiveAnswers(String answerKey, int k) {
    return max(flipper(answerKey, k, 'F'), flipper(answerKey, k, 'T'));
  }

  int flipper(String answerKey, int k, String countLetter) {
    int maximum = 0;
    int count = 0;
    final Queue<int> queue = Queue<int>();
    for (int i = 0; i < answerKey.length; i++) {
      final String letter = answerKey[i];
      if (letter == countLetter)
        count++;
      else if (k > 0) {
        queue.add(i);
        k--;
        count++;
      } else {
        queue.add(i);
        maximum = max(count, maximum);
        final int firstEncountered = queue.removeFirst();
        count = i - firstEncountered;
      }
    }
    maximum = max(count, maximum);
    return maximum;
  }
}
```

## Solution - 2 Linked List

### Code Explanation

The given code implements a solution to find the maximum number of consecutive answers in an answer key, considering a maximum number of flips allowed. The `maxConsecutiveAnswers` function takes an answer key (a string of 'T' and 'F' representing true and false answers) and the maximum number of flips allowed (`k`), and returns the maximum number of consecutive answers after performing flips.

The implementation uses a custom `LinkedList` class to keep track of the indices where flips occur. The `LinkedList` class has a `head` and `tail` node, and it provides methods to add elements to the end of the list (`add`), remove the first element (`removeFirst`), and check if the list is empty (`isEmpty`).

The `flipper` function is a helper function used by `maxConsecutiveAnswers`. It iterates over the answer key and maintains a count of consecutive answers of the given `countLetter` (either 'T' or 'F'). If a different letter is encountered, it checks if there are any remaining flips (`k > 0`). If there are flips available, it adds the current index to the `linkedList`, decrements `k`, and increments the count. If there are no flips available, it adds the current index to the `linkedList`, updates the `maximum` count if necessary, removes the first encountered index from the `linkedList`, and calculates the new count based on the removed index.

Finally, the function returns the maximum count found.

### Space Complexity

- The space complexity of the code is O(n), where n is the length of the answer key. This is because the `LinkedList` can store up to `k` indices, and in the worst case, if all indices require flips, the `linkedList` will contain `k` elements. Additionally, other variables like `maximum`, `count`, and `letter` require constant space.

### Time Complexity

- The time complexity of the code is O(n), where n is the length of the answer key. This is because the code iterates over the answer key once, performing constant time operations like comparisons, additions, and removals in the `linkedList`. The operations performed on the `linkedList` are all O(1) since the implementation uses a singly linked list and keeps track of the tail node.

```dart
class Node {
 late int value;
  Node? next;

  Node(int value) {
    this.value = value;
    this.next = null;
  }
}

class LinkedList {
  Node? head;
  Node? tail;

  LinkedList() {
    head = null;
    tail = null;
  }

  void add(int value) {
    Node newNode = Node(value);
    if (head == null) {
      head = newNode;
      tail = newNode;
    } else {
      tail?.next = newNode;
      tail = newNode;
    }
  }

  int? removeFirst() {
    if (head == null) return null;
    int? value = head?.value;
    head = head?.next;
    if (head == null) tail = null;
    return value;
  }

  bool isEmpty() {
    return head == null;
  }
}

class Solution {
  int maxConsecutiveAnswers(String answerKey, int k) {
    return max(flipper(answerKey, k, 'F'), flipper(answerKey, k, 'T'));
  }

  int flipper(String answerKey, int k, String countLetter) {
    int maximum = 0;
    int count = 0;
    final LinkedList linkedList = LinkedList();
    for (int i = 0; i < answerKey.length; i++) {
      final String letter = answerKey[i];
      if (letter == countLetter)
        count++;
      else if (k > 0) {
        linkedList.add(i);
        k--;
        count++;
      } else {
        linkedList.add(i);
        maximum = max(count, maximum);
        final int? firstEncountered = linkedList.removeFirst();
        if (firstEncountered != null) {
          count = i - firstEncountered;
        }
      }
    }
    maximum = max(count, maximum);
    return maximum;
  }
}
```

## Solution - 3

```dart
class Solution {
  int maxConsecutiveAnswers(String answerKey, int k) {
    int ans1 = solve(answerKey, k, 'T');
    int ans2 = solve(answerKey, k, 'F');
    return max(ans1, ans2);
  }

  int solve(String answerKey, int k, String c) {
    int i = 0;
    int j = 0;
    int count = 0;
    int n = answerKey.length;
    int answer = 0;
    while (j < n) {
      if (answerKey[j] == c) count++;
      while (i < n && count > k) {
        if (answerKey[i] == c) count--;
        i++;
      }
      answer = max(j - i + 1, answer);
      j++;
    }
    return answer;
  }
}
```
