/*

 -* Break a Palindrome *-

Given a palindromic string of lowercase English letters palindrome, replace exactly one character with any lowercase English letter so that the resulting string is not a palindrome and that it is the lexicographically smallest one possible.

Return the resulting string. If there is no way to replace a character to make it not a palindrome, return an empty string.

A string a is lexicographically smaller than a string b (of the same length) if in the first position where a and b differ, a has a character strictly smaller than the corresponding character in b. For example, "abcc" is lexicographically smaller than "abcd" because the first position they differ is at the fourth character, and 'c' is smaller than 'd'.



Example 1:

Input: palindrome = "abccba"
Output: "aaccba"
Explanation: There are many ways to make "abccba" not a palindrome, such as "zbccba", "aaccba", and "abacba".
Of all the ways, "aaccba" is the lexicographically smallest.
Example 2:

Input: palindrome = "a"
Output: ""
Explanation: There is no way to replace a single character to make "a" not a palindrome, so return an empty string.


Constraints:

1 <= palindrome.length <= 1000
palindrome consists of only lowercase English letters.

*/
class A {
// Runtime: 447 ms, faster than 100.00% of Dart online submissions for Break a Palindrome.
// Memory Usage: 141 MB, less than 100.00% of Dart online submissions for Break a Palindrome.

  String breakPalindrome(String palindrome) {
    int n = palindrome.length;
    List<String> p = palindrome.split("");
    if (n == 1) {
      return "";
    }
    for (int i = 0; i < n ~/ 2; i++) {
      if (p[i] != String.fromCharCode(97)) {
        p[i] = String.fromCharCode(97);
        return p.join();
      }
    }
    p[n - 1] = String.fromCharCode(98);
    return p.join();
  }
}

class B {
// Runtime: 480 ms, faster than 100.00% of Dart online submissions for Break a Palindrome.
// Memory Usage: 141.2 MB, less than 100.00% of Dart online submissions for Break a Palindrome.
  String breakPalindrome(String palindrome) {
    // if the length is only one we will return empty string as
    // describe in first case
    if (palindrome.length == 1) return "";
    // splitting the string in to an array
    // because it's useful to work with char Codes because
    // there is not `CHAR` data type in dart
    List<String> chars = palindrome.split("");
    // if the first string in the array is "a"
    if (chars[0] != 'a') {
      // we will set it to the "a" again and return it
      // as describe in the case
      chars[0] = 'a';
      // and join them because our return type is string so
      // so join() will convert broken string to united string
      return chars.join();
    }
    // index
    int idx = 0;
    // assuming there is more than one number or string in the string array
    // if so than we wil move forward in the array idx++
    while (idx <= chars.length / 2 && chars[idx] == 'a') idx++;
    // if whole length - idx - another idx is still less than the 1 the second element

    if (chars.length - idx - idx <= 1)
      // we will set it to "b"
      // as describe in the edge case - edge is fancy term.
      chars[chars.length - 1] = 'b';
    else
      // else we will set it to "a"
      chars[idx] = 'a';
    // and we will return the joined string
    return chars.join();
  }
}

class C {
// Runtime: 330 ms, faster than 100.00% of Dart online submissions for Break a Palindrome.
// Memory Usage: 148.5 MB, less than 100.00% of Dart online submissions for Break a Palindrome.
  String breakPalindrome(String palindrome) {
    // if the length is only one we will return empty string as
    // describe in first case
    if (palindrome.length == 1) return "";
    int k = 0;
    // splitting the string in to an array
    // because it's useful to work with char Codes because
    // there is not `CHAR` data type in dart
    List<String> s = palindrome.split("");
    // looping oon each and every element of string in array
    for (int i = 0; i < s.length; i++) {
      // if any element match with the 'a' and the length is odd and nothing remains OR the i means
      // each element is not same tot eh mid of the whole array
      if (s[i] != 'a' && (s.length % 2 == 0 || i != (s.length - 1) / 2)) {
        // we will set it to "a" as describe in edge case
        s[i] = 'a';
        break;
      }
      // and we will move in life as k is moving on in this case
      k++;
    }
    // literally found
    int found = 0;
    // if we really really have found our love
    if (palindrome.length == k) {
      // than we set the founded love to it's index
      found = palindrome.lastIndexOf('a');
      // if founded somewhere else than we will set it to "b"
      s[found] = 'b';
    }
    // now we will join the marriage and move on in life
    return s.join();
  }
}

class D {
  String breakPalindrome(String palindrome) {
    // List<String> s = palindrome.split("");
    // since a single character is always palindrome
    if (palindrome.length == 1) return "";
    // making a string builder with the original string
    StringBuffer ans = StringBuffer();
    // to store the mid index. since changing the mid index would still keep the string as palindrome
    int mid = palindrome.length ~/ 2;

    for (int i = 0; i < palindrome.length; i++) {
      String c = palindrome[i];
      if (i != mid && c.codeUnitAt(0) != 'a'.codeUnitAt(0)) {
        // setting the first non - a character as a, to help make it lexicographically smallest
        ans.writeCharCode('a'.codeUnitAt(i));
        break;
      } else if (c.codeUnitAt(0) == 'a'.codeUnitAt(0) &&
          i == palindrome.length - 1) {
        // if all the letters are a, then making the last letter b
        ans.writeCharCode('b'.codeUnitAt(i));
        break;
      }
    }

    return ans.toString();
  }
}
