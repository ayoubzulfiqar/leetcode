/**


-* Valid Parenthesis *-


Given a string s containing just the characters '(', ')', '{', '}', '[' and ']',
determine if the input string is valid.

An input string is valid if:

Open brackets must be closed by the same type of brackets.
Open brackets must be closed in the correct order.


Example 1:

Input: s = "()"
Output: true


Example 2:

Input: s = "()[]{}"
Output: true


Example 3:

Input: s = "(]"
Output: false


Constraints:

1 <= s.length <= 104
s consists of parentheses only '()[]{}'.


*/

void main() {}

class A {
  // Almost Working
  bool isValid(String s) {
    if (s.isEmpty) return true;
    s.split("");

    List<String> parenthesisStack = [];
    for (var i = 0; i < s.length; i++) {
      if (s[i] == "(" ||
          s[i] == "{" ||
          s[i] == "[" && parenthesisStack.isEmpty) {
        return false;
      } else if (s[i] == "(" && parenthesisStack.last == ")" ||
          s[i] == "{" && parenthesisStack.last == "}" ||
          s[i] == "[" && parenthesisStack.last == "]") {
        parenthesisStack.removeLast();
      } else {
        parenthesisStack.add(s[i]);
      }
    }

    return parenthesisStack.length == 0;
  }
}

class B {
  bool isValid(String s) {
    // map of parenthesis that we are checking  basically
    Map<String, String> parenthesis = <String, String>{
      ")": "(",
      "}": "{",
      "]": "[",
    };

    // lis to  save the values inside
    List<String> list = <String>[];

    // for loop to check the every entered item in string
    for (String item in s.split("")) {
      // checking  if the entered string contain the values that inside are same
      if (parenthesis.containsKey(item)) {
        // if the it's zero and length is less than zero or negative
        // OR the it is not same aas the parenthesis  than we will return false
        if (list.length == 0 || list[list.length - 1] != parenthesis[item])
          return false;
        else {
          // removing the last values
          list.removeLast();
        }
      } else {
        // than adding to the list
        list.add(item);
      }
    }
    // if the entered value is empty than it will be false if not than it
    // it will  be true
    return list.length == 0;
  }
}

class D {
  // So Close to Working
  bool isValid(String s) {
    int braces = 0;
    int sBrackets = 0;
    int rBrackets = 0;
    for (var i in s.split('')) {
      switch (i) {
        case ('{'):
          braces++;
          break;
        case ('}'):
          braces--;
          break;
        case ('('):
          rBrackets++;
          break;
        case (')'):
          rBrackets--;
          break;
        case ('['):
          sBrackets++;
          break;
        case (']'):
          sBrackets--;
          break;
      }
    }
    return (braces == 0) & (sBrackets == 0) & (rBrackets == 0);
  }
}

class E {
  bool isValid(String s) {
    List<String> stack = <String>[];

    for (var i = 0; i < s.length; i++) {
      if ('([{'.contains(s[i])) {
        stack.add(s[i]);
      } else {
        if (s[i] == ')' &&
            stack.length != 0 &&
            stack[stack.length - 1] == '(') {
          stack.removeLast();
        } else if (s[i] == ']' &&
            stack.length != 0 &&
            stack[stack.length - 1] == '[') {
          stack.removeLast();
        } else if (s[i] == '}' &&
            stack.length != 0 &&
            stack[stack.length - 1] == '{') {
          stack.removeLast();
        } else {
          return false;
        }
      }
    }

    return stack.length == 0;
  }

  /*

  Runtime: 330 ms, faster than 66.67% of Dart online submissions for Valid Parentheses.
  Memory Usage: 140.4 MB, less than 100.00% of Dart online submissions for Valid Parentheses.
   */
}
