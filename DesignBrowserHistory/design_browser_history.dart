/*


--* 1472. Design Browser History *--



You have a browser of one tab where you start on the homepage and you can visit another url, get back in the history number of steps or move forward in the history number of steps.

Implement the BrowserHistory class:

BrowserHistory(string homepage) Initializes the object with the homepage of the browser.
void visit(string url) Visits url from the current page. It clears up all the forward history.
string back(int steps) Move steps back in history. If you can only return x steps in the history and steps > x, you will return only x steps. Return the current url after moving back in history at most steps.
string forward(int steps) Move steps forward in history. If you can only forward x steps in the history and steps > x, you will forward only x steps. Return the current url after forwarding in history at most steps.
 

Example:

Input:
["BrowserHistory","visit","visit","visit","back","back","forward","visit","forward","back","back"]
[["leetcode.com"],["google.com"],["facebook.com"],["youtube.com"],[1],[1],[1],["linkedin.com"],[2],[2],[7]]
Output:
[null,null,null,null,"facebook.com","google.com","facebook.com",null,"linkedin.com","google.com","leetcode.com"]

Explanation:
BrowserHistory browserHistory = new BrowserHistory("leetcode.com");
browserHistory.visit("google.com");       // You are in "leetcode.com". Visit "google.com"
browserHistory.visit("facebook.com");     // You are in "google.com". Visit "facebook.com"
browserHistory.visit("youtube.com");      // You are in "facebook.com". Visit "youtube.com"
browserHistory.back(1);                   // You are in "youtube.com", move back to "facebook.com" return "facebook.com"
browserHistory.back(1);                   // You are in "facebook.com", move back to "google.com" return "google.com"
browserHistory.forward(1);                // You are in "google.com", move forward to "facebook.com" return "facebook.com"
browserHistory.visit("linkedin.com");     // You are in "facebook.com". Visit "linkedin.com"
browserHistory.forward(2);                // You are in "linkedin.com", you cannot move forward any steps.
browserHistory.back(2);                   // You are in "linkedin.com", move back two steps to "facebook.com" then to "google.com". return "google.com"
browserHistory.back(7);                   // You are in "google.com", you can move back only one step to "leetcode.com". return "leetcode.com"
 

Constraints:

1 <= homepage.length <= 20
1 <= url.length <= 20
1 <= steps <= 100
homepage and url consist of  '.' or lower case English letters.
At most 5000 calls will be made to visit, back, and forward.

*/

/*


class BrowserHistory {

  BrowserHistory(String homepage) {

  }
  
  void visit(String url) {

  }
  
  String back(int steps) {

  }
  
  String forward(int steps) {

  }
}

/**
 * Your BrowserHistory object will be instantiated and called as such:
 * BrowserHistory obj = BrowserHistory(homepage);
 * obj.visit(url);
 * String param2 = obj.back(steps);
 * String param3 = obj.forward(steps);
 */

*/

// import 'dart:math';

// class BrowserHistory {
//   late List<String> list;
//   int total = 0;
//   int current = 0;
//   BrowserHistory(String homepage) {
//     list = <String>[];
//     list.add(homepage);
//     total++;
//     current++;
//   }

//   void visit(String url) {
//     if (list.length > current) {
//       list[current] = url;
//     } else {
//       list.add(url);
//     }
//     current++;
//     total = current;
//   }

//   String back(int steps) {
//     current = max(1, current - steps);
//     return list.elementAt(current - 1);
//   }

//   String forward(int steps) {
//     current = min(total, current + steps);
//     return list.elementAt(current - 1);
//   }
// }

// /**
//  * Your BrowserHistory object will be instantiated and called as such:
//  * BrowserHistory obj = BrowserHistory(homepage);
//  * obj.visit(url);
//  * String param2 = obj.back(steps);
//  * String param3 = obj.forward(steps);
//  */

// Doubly Linked List

class Node {
  String? value;
  Node? next;
  Node? previous;
  Node(String source) {
    value = source;
    previous = next = null;
  }
}

class BrowserHistory {
  late Node root;
  BrowserHistory(String homepage) {
    root = Node(homepage);
  }

  void visit(String url) {
    Node node = Node(url);
    root.next = node;
    node.previous = root;
    root = node;
  }

  String back(int steps) {
    Node current = root;
    while (steps > 0 && current.previous != null) {
      current = current.previous!;
      steps--;
    }
    root = current;
    return current.value!;
  }

  String forward(int steps) {
    Node cur = root;
    while (steps > 0 && cur.next != null) {
      cur = cur.next!;
      steps--;
    }
    root = cur;
    return cur.value!;
  }
}
