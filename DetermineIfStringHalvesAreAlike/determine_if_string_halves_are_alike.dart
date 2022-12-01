/*


-* 1704. Determine if String Halves Are Alike *-



You are given a string s of even length. Split this string into two halves of equal lengths, and let a be the first half and b be the second half.

Two strings are alike if they have the same number of vowels ('a', 'e', 'i', 'o', 'u', 'A', 'E', 'I', 'O', 'U'). Notice that s contains uppercase and lowercase letters.

Return true if a and b are alike. Otherwise, return false.

 

Example 1:

Input: s = "book"
Output: true
Explanation: a = "bo" and b = "ok". a has 1 vowel and b has 1 vowel. Therefore, they are alike.
Example 2:

Input: s = "textbook"
Output: false
Explanation: a = "text" and b = "book". a has 1 vowel whereas b has 2. Therefore, they are not alike.
Notice that the vowel o is counted twice.
 

Constraints:

2 <= s.length <= 1000
s.length is even.
s consists of uppercase and lowercase letters.



*/

import 'dart:collection';

class A {
  bool halvesAreAlike(String s) {
    // set of Vowels
    HashSet<String> vowels =
        HashSet.of(['a', 'e', 'i', 'o', 'u', 'A', 'E', 'I', 'O', 'U']);

    // just to count each and every value of occurrence
    int count = 0;
    //loop for each element in the string
    for (int i = 0; i < s.length; i++) {
      // if they both match
      if (vowels.contains(s[i])) {
        // we will set the value to count
        count += (s.length - 2 * i - 1).sign;
      }
    }
    // than return based on the matching
    return count == 0;
  }
}

class B {
  bool halvesAreAlike(String s) {
    int firstCount = 0;
    int secondCount = 0;

    for (int i = 0; i < s.length ~/ 2; i++) {
      if (s[i] == 'a' ||
          s[i] == 'e' ||
          s[i] == 'i' ||
          s[i] == 'o' ||
          s[i] == 'u' ||
          s[i] == 'A' ||
          s[i] == 'E' ||
          s[i] == 'I' ||
          s[i] == 'O' ||
          s[i] == 'U') {
        firstCount++;
      }
    }
    for (int i = s.length ~/ 2; i < s.length; i++) {
      if (s[i] == 'a' ||
          s[i] == 'e' ||
          s[i] == 'i' ||
          s[i] == 'o' ||
          s[i] == 'u' ||
          s[i] == 'A' ||
          s[i] == 'E' ||
          s[i] == 'I' ||
          s[i] == 'O' ||
          s[i] == 'U') {
        secondCount++;
      }
    }
    if (firstCount == secondCount) return true;
    return false;
  }
}

class C {
  bool halvesAreAlike(String s) {
    List<String> ch = ['a', 'e', 'i', 'o', 'u', 'A', 'E', 'I', 'O', 'U'];

    int vow1 = 0;
    int vow2 = 0;

    for (int i = 0; i < s.length / 2; i++) {
      for (int k = 0; k < ch.length; k++) {
        if (s[i] == ch[k]) {
          vow1++;
        }
      }
    }

    for (int i = s.length ~/ 2; i < s.length; i++) {
      for (int k = 0; k < ch.length; k++) {
        if (s[i] == ch[k]) {
          vow2++;
        }
      }
    }

    if (vow1 == vow2) {
      return true;
    }

    return false;
  }
}

class D {
  bool halvesAreAlike(String s) {
    String st = "";
    st = s.toLowerCase();
    List<String> c = st.split("");
    int count = 0;
    for (int i = 0; i < c.length; i++) {
      if (i == 'a' || i == 'e' || i == 'i' || i == 'o' || i == 'u') {
        count++;
      }
    }

    return count % 2 == 0 ? true : false;
  }
}
