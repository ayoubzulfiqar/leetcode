# 🔥 Reverse String 🔥 || 3 Approaches || Simple Fast and Easy || with Explanation

## Solution - 1

```dart
class Solution {
  void solve(List<String> s, int left, int right) {
    if (left >= right) return;
    String temp = s[left];
    s[left] = s[right];
    s[right] = temp;
    solve(s, ++left, --right);
  }

  void reverseString(List<String> s) {
    int left = 0;
    int right = s.length - 1;
    solve(s, left, right);
  }
}
```

## Solution - 2

```dart
class Solution {
  void reverseString(List<String> s) {
    int left = 0, right = s.length - 1;
    while (left < right) {
      String temp = s[right];
      s[right--] = s[left];
      s[left++] = temp;
    }
  }
}
```

## Solution - 3

```dart
class Solution {
  void reverseString(List<String> s) {
    //create a stack
    List<String> st = [];
    //loop through the string, to add all the string elements in stack
    for (int i = 0; i < s.length; i++) {
      //create a variable to add the values
      String ch = s[i];
      st.add(ch);
    }
    //empty the original string
    s.clear();
    //add the stack elements to the string
    while (!st.isEmpty) {
      String ch = st.first;
      //reversed
      s.add(ch);
      st.removeLast();
    }
  }
}
```
