/*

-* 2024. Maximize the Confusion of an Exam *-


A teacher is writing a test with n true/false questions, with 'T' denoting true and 'F' denoting false. He wants to confuse the students by maximizing the number of consecutive questions with the same answer (multiple trues or multiple falses in a row).

You are given a string answerKey, where answerKey[i] is the original answer to the ith question. In addition, you are given an integer k, the maximum number of times you may perform the following operation:

Change the answer key for any question to 'T' or 'F' (i.e., set answerKey[i] to 'T' or 'F').
Return the maximum number of consecutive 'T's or 'F's in the answer key after performing the operation at most k times.

 

Example 1:

Input: answerKey = "TTFF", k = 2
Output: 4
Explanation: We can replace both the 'F's with 'T's to make answerKey = "TTTT".
There are four consecutive 'T's.
Example 2:

Input: answerKey = "TFFT", k = 1
Output: 3
Explanation: We can replace the first 'T' with an 'F' to make answerKey = "FFFT".
Alternatively, we can replace the second 'T' with an 'F' to make answerKey = "TFFF".
In both cases, there are three consecutive 'F's.
Example 3:

Input: answerKey = "TTFTTFTT", k = 1
Output: 5
Explanation: We can replace the first 'F' to make answerKey = "TTTTTFTT"
Alternatively, we can replace the second 'F' to make answerKey = "TTFTTTTT". 
In both cases, there are five consecutive 'T's.
 

Constraints:

n == answerKey.length
1 <= n <= 5 * 104
answerKey[i] is either 'T' or 'F'
1 <= k <= n

*/

import 'dart:collection';
import 'dart:math';

class A {
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

//============================== Linked List
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

class B {
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

//========================

class C {
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


//==

