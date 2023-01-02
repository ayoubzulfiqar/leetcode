/*

-* 520. Detect Capital *-


We define the usage of capitals in a word to be right when one of the following cases holds:

All letters in this word are capitals, like "USA".
All letters in this word are not capitals, like "leet-code".
Only the first letter in this word is capital, like "Google".
Given a string word, return true if the usage of capitals in it is right.

 

Example 1:

Input: word = "USA"
Output: true
Example 2:

Input: word = "FlaG"
Output: false
 

Constraints:

1 <= word.length <= 100
word consists of lowercase and uppercase English letters.


*/

extension Equals on String {
  bool equals(Object anObject) {
    if (identical(this, anObject)) {
      return true;
    }
    if (anObject is String) {
      String anotherString = anObject;
      int n = codeUnits.length;
      if (n == anotherString.codeUnits.length) {
        List<int> v1 = codeUnits;
        List<int> v2 = anotherString.codeUnits;
        int i = 0;
        while (n-- != 0) {
          if (v1[i] != v2[i]) {
            return false;
          }
          i++;
        }
        return true;
      }
    }
    return false;
  }
}

class A {
  bool detectCapitalUse(String word) {
    return word.toUpperCase().equals(word) ||
        word.toLowerCase().equals(word) ||
        word.codeUnitAt(0) == word.toUpperCase() &&
            word
                .substring(1, word.length)
                .toLowerCase()
                .equals(word.substring(1, word.length));
  }
}

class B {
  bool detectCapitalUse(String word) {
    int count = 0;
    for (String char in word.split(''))
      if ('Z'.codeUnitAt(0) - char.codeUnitAt(0) >= 0) count++;
    return ((count == 0 || count == word.length) ||
        (count == 1 && 'Z'.codeUnitAt(0) - word.codeUnitAt(0) >= 0));
  }
}

class C {
  bool detectCapitalUse(String word) {
    if (word == "") return false;
    if (word.length == 1) return true;
    if (word.codeUnitAt(0) >= 'a'.codeUnitAt(0) &&
        word.codeUnitAt(1) < 'a'.codeUnitAt(0)) return false;
    for (int i = 2; i < word.length; i++) {
      if ((word.codeUnitAt(1) - 'a'.codeUnitAt(0) + 1) *
              (word.codeUnitAt(i) - 'a'.codeUnitAt(0) + 1) <
          0) {
        return false;
      }
    }
    return true;
  }
}
