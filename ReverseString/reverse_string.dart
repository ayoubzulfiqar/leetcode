/*



-* 344. Reverse String *-


Write a function that reverses a string. The input string is given as an array of characters s.

You must do this by modifying the input array in-place with O(1) extra memory.



Example 1:

Input: s = ["h","e","l","l","o"]
Output: ["o","l","l","e","h"]
Example 2:

Input: s = ["H","a","n","n","a","h"]
Output: ["h","a","n","n","a","H"]


Constraints:

1 <= s.length <= 105
s[i] is a printable ascii character.

*/

class A {
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

class B {
  void reverseString(List<String> s) {
    int left = 0, right = s.length - 1;
    while (left < right) {
      String temp = s[right];
      s[right--] = s[left];
      s[left++] = temp;
    }
  }
}

class C {
  void reverseString(List<String> s) {
    // Declare integer variable and initialize them
    int i = 0, j = 0, k = 0;
    // Initialize stack
    List<String> stack = [];
    // Initialize string
    String str = s.toString();
    // Push all elements into the stack
    for (i = 0; i < str.length; i++) {
      stack.add(s[i]);
    }
    // Initialize another array
    List<String> array = List.filled(s.length, "");
    // Pop elements from stack
    while (stack.length > 0) {
      s[j++] = stack.removeLast(); //Increment j accordingly
    }
    // Fill the other array with popped elements from stack
    for (k = 0; k < str.length; k++) {
      array[k] = str[k];
    }
  }
}

class D {
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
