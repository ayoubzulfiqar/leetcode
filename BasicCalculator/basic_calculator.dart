/*

-* 224. Basic Calculator *-

Given a string s representing a valid expression, implement a basic calculator to evaluate it, and return the result of the evaluation.

Note: You are not allowed to use any built-in function which evaluates strings as mathematical expressions, such as eval().



Example 1:

Input: s = "1 + 1"
Output: 2
Example 2:

Input: s = " 2-1 + 2 "
Output: 3
Example 3:

Input: s = "(1+(4+5+2)-3)+(6+8)"
Output: 23


Constraints:

1 <= s.length <= 3 * 105
s consists of digits, '+', '-', '(', ')', and ' '.
s represents a valid expression.
'+' is not used as a unary operation (i.e., "+1" and "+(2 + 3)" is invalid).
'-' could be used as a unary operation (i.e., "-1" and "-(2 + 3)" is valid).
There will be no two consecutive operators in the input.
Every number and running calculation will fit in a signed 32-bit integer.

*/
import 'dart:collection';

class A {
  int calculate(String s) {
    int sign = 1;
    int result = 0;
    int number = 0;

    int n = s.length;
    List<int> st = [];

    for (int i = 0; i < n; i++) {
      String c = s[i];
      if (c.codeUnitAt(0) >= '0'.codeUnitAt(0) &&
          c.codeUnitAt(0) <= '9'.codeUnitAt(0)) {
        number = number * 10 + (c.codeUnitAt(0) - '0'.codeUnitAt(0));
      }
      if (c == '-') {
        // number completed.
        // update result
        result += (sign) * (number);
        number = 0;
        sign = -1;
      }
      if (c == '+') {
        // number completed
        // update result
        result += (sign) * (number);
        number = 0;
        sign = 1;
      }
      if (c == '(') {
        // number completed, result updated already before when we encountered +/- before opening bracket
        st.add(result);
        // so that sign remains at the top (signifies sign before opening bracket was encountered)
        st.add(sign);
        result = 0; // building result between brackets from scratch
        sign = 1;
      }
      if (c == ')') {
        // number is completed
        // update result
        result += (sign) * (number);
        number = 0;
        result *= st.first; // multiplying with sign before opening bracket
        st.removeLast();
        result += st.first; // result constructed before current context.
        st.removeLast();
      }
    }

    // last no space character in case is a number itself , we need to use the number also.
    result += (sign) * number;

    return result;
  }
}

class B {
  bool isDigit(String? s) {
    if (s == null) {
      return false;
    }
    return int.tryParse(s) != null;
  }

  int calculate(String s) {
    List<int> stack = [];
    int result = 0;
    int number = 0;
    int sign = 1;
    for (int i = 0; i < s.length; i++) {
      String c = s[i];
      if (isDigit(c)) {
        number = 10 * number + (c.codeUnitAt(0) - '0'.codeUnitAt(0));
      } else if (c == '+') {
        result += sign * number;
        number = 0;
        sign = 1;
      } else if (c == '-') {
        result += sign * number;
        number = 0;
        sign = -1;
      } else if (c == '(') {
        //we push the result first, then sign;
        stack.add(result);
        stack.add(sign);
        //reset the sign and result for the value in the parenthesis
        sign = 1;
        result = 0;
      } else if (c == ')') {
        result += sign * number;
        number = 0;
        result *=
            stack.removeLast(); //stack.pop() is the sign before the parenthesis
        result += stack
            .removeLast(); //stack.pop() now is the result calculated before the parenthesis

      }
    }
    if (number != 0) result += sign * number;
    return result;
  }
}

class C {
  bool isDigit(String? s) {
    if (s == null) {
      return false;
    }
    return int.tryParse(s) != null;
  }

  int calculate(String s) {
    // all possible case: "+", "-", "(", ")", " ", "1-9"
    // +: change sign to positive +1
    // -: change sign to negative -1
    // (: push current result value and sign onto the stack
    // ): pop the previous result value and sign off the stack and do the addition
    // " ": skip
    // 1-9: read all digits after current digit
    Queue<int> stack = Queue();
    // initialize result to be 0, sign to be 1
    int res = 0, sign = 1;

    int n = s.length;
    // iterate through all characters of the input
    for (int i = 0; i < n; i++) {
      String curr = s[i];
      switch (curr) {
        case '+':
          // make sign become positive to indicate we are adding a value
          sign = 1;
          break;
        case '-':
          // make sign become negative to indicate we are subtracting a value
          sign = -1;
          break;
        case '(':
          // pushing current result as well as the sign onto the stack
          stack.addFirst(res);
          stack.addFirst(sign);
          // reset result and sign
          res = 0;
          sign = 1;
          break;
        case ')':
          // popping previous result and sign off the stack and do the addition(subtraction)
          // with the current calculation result
          int prevSign = stack.removeFirst();
          int prevRes = stack.removeFirst();
          res = prevRes + prevSign * res;
          break;
        case ' ':
          // skip the empty spaces
          break;
        default:
          // in case current char is a digit, read the whole integer
          int startIdx = i;
          while (i < n && isDigit(s[i])) {
            i++;
          }
          int v = int.parse(s.substring(startIdx, i));
          res += sign * v;
          i--;
      }
    }
    return res;
  }
}

class D {
  int pos = 0;
  bool isNum(String curr) {
    int nums = curr.codeUnitAt(0) - '0'.codeUnitAt(0);
    return nums >= 0 && nums <= 9;
  }

  int solve(String s) {
    int sign = 1; // initial take as positive
    int nums = 0;
    int res = 0;
    while (pos < s.length) {
      String curr = s[pos++];
      if (curr == ' ') {
        continue;
      } else if (isNum(curr)) {
        nums = nums * 10 + curr.codeUnitAt(0) - '0'.codeUnitAt(0);
      } else if (curr == '(') {
        nums = solve(s);
      } else if (curr == ')') {
        res += nums * sign;
        return res;
      } else {
        res += sign * nums;
        sign = curr == '-' ? -1 : 1;
        nums = 0;
      }
    }
    int ret = res + (sign * nums);
    return ret;
  }

  int calculate(String s) {
    pos = 0;
    return solve(s);
  }
}
