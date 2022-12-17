# 🔥 3 Approaches 🔥 || Simple Fast and Easy || with Explanation

## Explanation

Loop through tokens, push integers into a stack, and pop two from stack if token is not an integer, calculate the result, push result back into stack.

## Solution - 1 STACK

```dart
class Solution {
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
```

## Solution - 2

```dart
  bool isDigit(String s) {
    if (s.isEmpty) {
      return false;
    }
    return int.tryParse(s) != null;
  }
}
```

```dart
class Solution {
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
```

## Solution - 3

```dart
class Solution {
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
```
