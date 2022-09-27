/*

 -* Push Dominoes *-


 There are n dominoes in a line, and we place each domino vertically upright. In the beginning,
 we simultaneously push some of the dominoes either to the left or to the right.

After each second, each domino that is falling to the left pushes the adjacent domino on the left.
Similarly, the dominoes falling to the right push their adjacent dominoes standing on the right.

When a vertical domino has dominoes falling on it from both sides, it stays still due to the balance of the forces.

For the purposes of this question, we will consider that a falling domino expends no additional
force to a falling or already fallen domino.

You are given a string dominoes representing the initial state where:

dominoes[i] = 'L', if the ith domino has been pushed to the left,
dominoes[i] = 'R', if the ith domino has been pushed to the right, and
dominoes[i] = '.', if the ith domino has not been pushed.
Return a string representing the final state.



Example 1:

Input: dominoes = "RR.L"
Output: "RR.L"
Explanation: The first domino expends no additional force on the second domino.
Example 2:


Input: dominoes = ".L.R...LR..L.."
Output: "LL.RR.LLRRLL.."


Constraints:

n == dominoes.length
1 <= n <= 105
dominoes[i] is either 'L', 'R', or '.'.

*/
import 'dart:math';

class A {
  // Two Pointers
// Time: O(n)O(n)
// Space: O(n)O(n)
// Runtime: 386 ms, faster than 100.00% of Dart online submissions for Push Dominoes.
// Memory Usage: 156.8 MB, less than 100.00% of Dart online submissions for Push Dominoes.

  String pushDominoes(String dominoes) {
    // splitting the the whole string into a list like each individual character
    List<String> finalString = dominoes.split("");
    // left falling domino
    int L = -1;
    // right falling domino
    int R = -1;
    // looping through the length off the dominoes
    for (int i = 0; i <= dominoes.length; ++i)
      // if the i same as the dominos length OR smae as the individual character or the splitting list
      // of spited list as above assuming from right size
      if (i == dominoes.length || finalString[i] == 'R') {
        // if the left is greater  than the right while right side is less than the individual character
        if (L < R) while (R < i) finalString[R++] = 'R';
        // than we will give the order to push from the right side
        // and our right side is will be equal to the character because we pushed so it's value will be changing
        R = i;
        // else if the individual character is same aas from the left
      } else if (finalString[i] == 'L') {
        // assuming the right side is less than left or left  and right is a negative value
        if (R < L || L == -1 && R == -1) {
          // we will push the trigger from the left side
          if (L == -1 && R == -1) ++L;
          // assuming the left is less than the each character
          // so we will increment it at the point of splitting string
          while (L < i) finalString[L++] = 'L';
        } else {
          // if it's not the case
          // than defining the left and right sides
          int l = R + 1;
          int r = i - 1;
          // assuming that the left is less than right
          while (l < r) {
            // increment from the left side by triggering from the right side
            // because the left value will increase as the right value decrease
            finalString[l++] = 'R';
            finalString[r--] = 'L';
          }
        }
        // assigning the left value to the character
        L = i;
      }
    // as a result we will return the resulting string and and join it to make it one single string
    return finalString.join();
  }
}

class B {
// Traversal solution in TC: O(n)
// Runtime: 407 ms, faster than 100.00% of Dart online submissions for Push Dominoes.
// Memory Usage: 157.4 MB, less than 100.00% of Dart online submissions for Push Dominoes.
  String pushDominoes(String dominoes) {
    // splitting the string into individual character
    List<String> s = dominoes.split("");
    // length of our whole string
    int n = dominoes.length;
    // lift side of the dominoes - holing the how many dominoes available on the left
    List<int> left = List.filled(n, 0);
    // right side of the dominoes - holing the how many dominoes available on the right
    List<int> right = List.filled(n, 0);
    // total sum value of both right and left - holing the how many dominoes available on both side
    List<int> sum = List.filled(n, 0);
    //R command from left to right
    int command = 0;
    // looping through the whole length - if the length is less than each character
    for (int i = 0; i < n; i++) {
      if (dominoes[i] == 'R')
        // our command will be from right side and assign the vle to i
        command = n;
      else if (dominoes[i] == 'L')
        command = 0;
      else if (dominoes[i] == '.') command = max(command - 1, 0);

      right[i] = command;
    }
    int p = 0;
    for (int i = n - 1; i >= 0; i--, p++) {
      if (dominoes[i] == 'L')
        command = n;
      else if (dominoes[i] == 'R')
        command = 0;
      else if (dominoes[i] == '.') command = max(command - 1, 0);

      left[i] = command * (-1);
    }
    for (int i = 0; i < n; i++) {
      sum[i] = right[i] + left[i];
      if (sum[i] == 0)
        s[i] = '.';
      else if (sum[i] > 0)
        s[i] = 'R';
      else
        s[i] = 'L';
    }
    return s.join();
  }
}

// extension on String {
//   operator >(String other) {
//     return double.parse(this) > double.parse(other);
//   }

//   operator >=(String other) {
//     return double.parse(this) >= double.parse(other);
//   }

//   operator <(String other) {
//     return double.parse(this) < double.parse(other);
//   }

//   operator <=(String other) {
//     return double.parse(this) <= double.parse(other);
//   }
// }

class C {
// Runtime: 538 ms, faster than 100.00% of Dart online submissions for Push Dominoes.
// Memory Usage: 154.9 MB, less than 100.00% of Dart online submissions for Push Dominoes.
  String pushDominoes(String dominoes) {
    List<String> d = dominoes.split("");
    // l is the left pointer
    int l = 0, n = dominoes.length;
    // r is the right pointer
    for (int r = 0; r < n; r++) {
      if (d[r] == '.') {
        // case 1. meeting `.`, then skip it
        continue;
      } else if ((d[r] == d[l]) || (d[l] == '.' && d[r] == 'L')) {
        // case 2. both end is equal, i.e. d[r] == d[l]
        // then fill all the dots between both end
        // e.g. L....L -> LLLLLL
        // e.g. R....R -> RRRRRR
        // case 2.1 if the left end is . and the right end is L,
        // i.e. d[l] == '.' && d[r] == 'L'
        // then we need to fill them from `l` to `r` in this case
        for (int k = l; k < r; k++) d[k] = d[r];
      } else if (d[l] == 'L' && d[r] == 'R') {
        // case 3. left end is L and right end is R
        // e.g. L.....R
        // then do nothing
      } else if (d[l] == 'R' && d[r] == 'L') {
        // case 4. left end is R and right end is L
        // if we have odd number of dots between them (let's say m dots),
        // then we can only add (m / 2) Ls and (m / 2) Rs.
        // p.s `/` here is integer division. e.g. 3 / 2 = 1
        // e.g. R...L -> RR.LL
        // if we have even number of dots between them (let's say m dots),
        // then we can only add (m / 2) Ls and (m / 2) Rs.
        // e.g. R....L -> RRRLLL
        int m = (r - l - 1) ~/ 2;
        for (int k = 1; k <= m; k++) {
          d[r - k] = 'L';
          d[l + k] = 'R';
        }
      }
      // update left pointer
      l = r;
    }
    // case 5. if the left dominoe is `R`, then fill all 'R' till the end
    // e.g. LL.R. -> LL.RR
    if (d[l] == 'R') for (int k = l; k < n; k++) d[k] = 'R';
    return d.join();
  }
}
