# ✅ DART || 4 solutions || simple fast easy

## Solution - 1

```dart
class Solution {
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
```

## Solution - 2

```dart
class Solution {
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
```

## Solution - 3

```dart
class Solution {
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
```

## [GitHub Link](https://github.com/ayoubzulfiqar/leetcode)
