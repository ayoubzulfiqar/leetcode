/*

 -* 338. Counting Bits *-

 Given an integer n, return an array ans of length n + 1 such that for each i (0 <= i <= n), ans[i] is the number of 1's in the binary representation of i.



Example 1:

Input: n = 2
Output: [0,1,1]
Explanation:
0 --> 0
1 --> 1
2 --> 10
Example 2:

Input: n = 5
Output: [0,1,1,2,1,2]
Explanation:
0 --> 0
1 --> 1
2 --> 10
3 --> 11
4 --> 100
5 --> 101


Constraints:

0 <= n <= 105


Follow up:

It is very easy to come up with a solution with a runtime of O(n log n). Can you do it in linear time O(n) and possibly in a single pass?
Can you do it without using any built-in function (i.e., like __builtin_popcount in C++)?


*/

class A {
  List<int> countBits(int n) {
    List<int> res = List.filled(n + 1, 0);

    for (int i = 0; i <= n; i++) {
      res[i] = solve(i, res);
    }
    return res;
  }

  int solve(int n, List<int> memo) {
    if (n == 0) return 0;
    if (n == 1) return 1;

    if (memo[n] != 0)
      // if memo of n answer is already available we will re-use it & not go further for calculation
      return memo[n];
    // but if you are coming for the first time then, store that value in memo
    if (n % 2 == 0) {
      memo[n] = solve(n ~/ 2, memo);
      return solve(n ~/ 2, memo);
    } else {
      memo[n] = 1 + solve(n ~/ 2, memo);
      return 1 + solve(n ~/ 2, memo);
    }
  }
}

class B {
  List<int> countBits(int n) {
    List<int> f = List.filled(n + 1, 0);
    for (int i = 1; i <= n; i++) f[i] = f[i >> 1] + (i & 1);
    return f;
  }
}

class C {
  List<int> countBits(int n) {
    List<int> answer = List.filled(n + 1, 0);
    int offset = 1;
    for (int i = 1; i < answer.length; i++) {
      if (offset * 2 == i) offset *= 2;
      answer[i] = 1 + answer[i - offset];
    }
    return answer;
  }
}
