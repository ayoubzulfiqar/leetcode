/*


 -* Nim Game *-


You are playing the following Nim Game with your friend:

Initially, there is a heap of stones on the table.
You and your friend will alternate taking turns, and you go first.
On each turn, the person whose turn it is will remove 1 to 3 stones from the heap.
The one who removes the last stone is the winner.
Given n, the number of stones in the heap, return true if you can win the game assuming both you and your friend play optimally, otherwise return false.



Example 1:

Input: n = 4
Output: false
Explanation: These are the possible outcomes:
1. You remove 1 stone. Your friend removes 3 stones, including the last stone. Your friend wins.
2. You remove 2 stones. Your friend removes 2 stones, including the last stone. Your friend wins.
3. You remove 3 stones. Your friend removes the last stone. Your friend wins.
In all outcomes, your friend wins.
Example 2:

Input: n = 1
Output: true
Example 3:

Input: n = 2
Output: true


Constraints:

1 <= n <= 231 - 1


*/

class Solution {
  bool canWinNim(int n) {
    // if the remainder is not 0 because if there is remainder than nim will win
    return n % 4 != 0;
  }
}

class B {
  bool canWinNim(int n) {
    // if the number is less than zero or equal nothing to do here
    if (n <= 0) return false;
    // because we can pick 0-3 pick one time  so true
    if (n == 1 || n == 2 || n == 3) return true;
    // recursive to see after picking 0,1,2,3 if there is something left we lost
    if (canWinNim(n - 1) && canWinNim(n - 2) && canWinNim(n - 3)) return false;
    return true;
  }
}

class C {
  bool canWinNim(int n) {
    if (n >= 134882061) return n % 4 != 0;
    bool result = true;
    bool first = true;
    bool second = true;
    bool third = true;
    for (int i = 4; i <= n; i++) {
      result = (first && second && third) ? false : true;
      first = second;
      second = third;
      third = result;
    }
    return result;
  }
}
