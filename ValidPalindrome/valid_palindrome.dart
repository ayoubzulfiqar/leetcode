/*

 -* Valid Palindrome *-

 A phrase is a palindrome if, after converting all uppercase letters into lowercase letters and removing all non-alphanumeric characters, it reads the same forward and backward. Alphanumeric characters include letters and numbers.

Given a string s, return true if it is a palindrome, or false otherwise.



Example 1:

Input: s = "A man, a plan, a canal: Panama"
Output: true
Explanation: "amanaplanacanalpanama" is a palindrome.
Example 2:

Input: s = "race a car"
Output: false
Explanation: "raceacar" is not a palindrome.
Example 3:

Input: s = " "
Output: true
Explanation: s is an empty string "" after removing non-alphanumeric characters.
Since an empty string reads the same forward and backward, it is a palindrome.


Constraints:

1 <= s.length <= 2 * 105
s consists only of printable ASCII characters.


*/

class A {
// Runtime: 580 ms, faster than 53.41% of Dart online submissions for Valid Palindrome.
// Memory Usage: 147.8 MB, less than 32.95% of Dart online submissions for Valid Palindrome.
  bool isPalindrome(String s) {
    // replacing the whole string based on regex match
    s = s.toLowerCase().replaceAll(RegExp("[^a-zA-Z0-9]"), "");
    //building a new string and splitting it and turing into a single element and reversing it and than joining to build
    // a single string
    String t = s.toString().split("").reversed.join();
    // if the it is same both are same than true otherwise false
    return s == t;
  }
}

class B {
// Runtime: 576 ms, faster than 55.68% of Dart online submissions for Valid Palindrome.
// Memory Usage: 144.7 MB, less than 77.27% of Dart online submissions for Valid Palindrome.
  bool isPalindrome(String s) {
    s = s.toLowerCase().replaceAll(RegExp("[^a-zA-Z0-9]"), "");
    int left = 0, right = s.length - 1;

    while (left < right) {
      if (s[left] != s[right]) return false;

      left++;
      right--;
    }

    return true;
  }
}

class C {
// Runtime: 762 ms, faster than 11.36% of Dart online submissions for Valid Palindrome.
// Memory Usage: 145.2 MB, less than 63.64% of Dart online submissions for Valid Palindrome.
  bool isPalindrome(String s) {
    s = s.toLowerCase().replaceAll(RegExp("[^a-zA-Z0-9]"), "");
    int right = (s.length / 2).floor();
    int left = s.length % 2 == 0 ? right - 1 : right;

    while (left >= 0 && right < s.length) {
      if (s[left] != s[right]) return false;

      left--;
      right++;
    }

    return true;
  }
}

// Massive Range error
class D {
  bool isPalindrome(String s) {
    bool isLetterOrDigit(String input) => RegExp(r'^[\w\d]$').hasMatch(input);

    int i = 0, j = s.length - 1;

    while (i < j) {
      while (!isLetterOrDigit(s[i])) {
        i++;
      }
      while (!isLetterOrDigit(s[j])) {
        j--;
      }
      if (!(s[i++].toLowerCase() == s[j--].toLowerCase())) {
        return false;
      }
    }
    return true;
  }
}
