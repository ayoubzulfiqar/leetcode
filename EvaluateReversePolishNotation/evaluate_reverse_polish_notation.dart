/*

-* 150. Evaluate Reverse Polish Notation *-



Evaluate the value of an arithmetic expression in Reverse Polish Notation.

Valid operators are +, -, *, and /. Each operand may be an integer or another expression.

Note that division between two integers should truncate toward zero.

It is guaranteed that the given RPN expression is always valid. That means the expression would always evaluate to a result, and there will not be any division by zero operation.

 

Example 1:

Input: tokens = ["2","1","+","3","*"]
Output: 9
Explanation: ((2 + 1) * 3) = 9
Example 2:

Input: tokens = ["4","13","5","/","+"]
Output: 6
Explanation: (4 + (13 / 5)) = 6
Example 3:

Input: tokens = ["10","6","9","3","+","-11","*","/","*","17","+","5","+"]
Output: 22
Explanation: ((10 * (6 / ((9 + 3) * -11))) + 17) + 5
= ((10 * (6 / (12 * -11))) + 17) + 5
= ((10 * (6 / -132)) + 17) + 5
= ((10 * 0) + 17) + 5
= (0 + 17) + 5
= 17 + 5
= 22
 

Constraints:

1 <= tokens.length <= 104
tokens[i] is either an operator: "+", "-", "*", or "/", or an integer in the range [-200, 200].

*/

import 'dart:collection';

class A {
  int evalRPN(List<String> tokens) {
    late int a, b;
    List<int> s = [];
    for (String token in tokens) {
      try {
        s.add(int.parse(token));
      } catch (e) {
        a = s.removeLast();
        b = s.removeLast();
        switch (token) {
          case "+":
            s.add(b + a);
            break;
          case "-":
            s.add(b - a);
            break;
          case "*":
            s.add(b * a);
            break;
          case "/":
            s.add(b ~/ a);
            break;
        }
      }
    }
    return s.removeLast();
  }
}

class B {
  int evalRPN(List<String> tokens) {
    if (tokens.isEmpty || tokens.length == 0) {
      return 0;
    }
    int len = tokens.length;
    List<int> result = List.filled(len, 0);
    int pointer = 0;
    for (int i = 0; i < len; i++) {
      String current = tokens[i];
      if (isDigit(current[current.length - 1])) {
        result[pointer++] = int.parse(current);
      } else {
        if (current == "+") {
          result[pointer - 2] += result[--pointer];
        } else if (current == "-") {
          result[pointer - 2] -= result[--pointer];
        } else if (current == "*") {
          result[pointer - 2] *= result[--pointer];
        } else {
          result[pointer - 2] ~/= result[--pointer];
        }
      }
    }
    return result[0];
  }

  bool isDigit(String s) {
    if (s.isEmpty) {
      return false;
    }
    return int.tryParse(s) != null;
  }
}

class C {
  int evalRPN(List<String> tokens) {
    List<int> s = [];
    HashSet<String> op = HashSet()..addAll(["+", "-", "*", "/"]);
    for (String c in tokens) {
      if (op.contains(c)) {
        int p2 = s.removeLast();
        int p1 = s.removeLast();
        s.add(execOp(p1, p2, c));
      } else {
        s.add(int.parse(c));
      }
    }

    return s.removeLast();
  }

  int execOp(int p1, int p2, String op) {
    switch (op) {
      case "+":
        return p1 + p2;
      case "-":
        return p1 - p2;
      case "*":
        return p1 * p2;
      case "/":
        return p1 ~/ p2;
    }

    return 0;
  }
}
