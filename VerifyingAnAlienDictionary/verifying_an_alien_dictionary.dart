/*



-* 953. Verifying an Alien Dictionary *-


In an alien language, surprisingly, they also use English lowercase letters, but possibly in a different order. The order of the alphabet is some permutation of lowercase letters.

Given a sequence of words written in the alien language, and the order of the alphabet, return true if and only if the given words are sorted lexicographically in this alien language.

 

Example 1:

Input: words = ["hello","leetcode"], order = "hlabcdefgijkmnopqrstuvwxyz"
Output: true
Explanation: As 'h' comes before 'l' in this language, then the sequence is sorted.
Example 2:

Input: words = ["word","world","row"], order = "worldabcefghijkmnpqstuvxyz"
Output: false
Explanation: As 'd' comes after 'l' in this language, then words[0] > words[1], hence the sequence is unsorted.
Example 3:

Input: words = ["apple","app"], order = "abcdefghijklmnopqrstuvwxyz"
Output: false
Explanation: The first three characters "app" match, and the second string is shorter (in size.) According to lexicographical rules "apple" > "app", because 'l' > '∅', where '∅' is defined as the blank character which is less than any other character (More info).
 

Constraints:

1 <= words.length <= 100
1 <= words[i].length <= 20
order.length == 26
All characters in words[i] and order are English lowercase letters.


*/
import 'dart:collection';
import 'dart:math';

class A {
  List<int> orderMap = List.filled(26, 0);
  bool isAlienSorted(List<String> words, String order) {
    for (int i = 0; i < order.length; i++) {
      orderMap[order.codeUnitAt(i) - 'a'.codeUnitAt(0)] = i;
    }

    for (int i = 1; i < words.length; i++) {
      if (!compare(words[i], words[i - 1])) return false;
    }
    return true;
  }

  bool compare(String s1, String s2) {
    int j = 0;
    while (j < s1.length && j < s2.length) {
      if (s1[j] == s2[j])
        j++;
      else if (orderMap[s1.codeUnitAt(j) - 'a'.codeUnitAt(0)] >
          orderMap[s2.codeUnitAt(j) - 'a'.codeUnitAt(0)])
        return true;
      else
        return false;
    }
    if (s1.length < s2.length) return false;
    return true;
  }
}

class B {
  bool isAlienSorted(List<String> words, String order) {
    HashMap<String, int> alpha = HashMap();
    for (int i = 0; i < order.length; i++) alpha[order[i]] = i;
    for (int i = 1; i < words.length; i++) {
      String a = words[i - 1], b = words[i];
      for (int j = 0; j < a.length; j++) {
        if (j == b.length) return false;
        String aChar = a[j], bChar = b[j];
        if ((alpha[aChar] ?? 0) < (alpha[bChar] ?? 0)) break;
        if ((alpha[aChar] ?? 0) > (alpha[bChar] ?? 0)) return false;
      }
    }
    return true;
  }
}

class C {
  List<int> x = List.filled(26, 0);
  bool isAlienSorted(List<String> words, String order) {
    for (int i = 0; i < order.length; ++i)
      x[order.codeUnitAt(i) - 'a'.codeUnitAt(0)] = i;
    for (int i = 0; i < words.length; ++i) {
      for (int j = i + 1; j < words.length; ++j) {
        String a = words[i], b = words[j];
        int ml = max(a.length, b.length);
        for (int m = 0; m < ml; ++m) {
          int p = a.length > m ? x[a.codeUnitAt(m) - 'a'.codeUnitAt(0)] : -1;
          int q = b.length > m ? x[b.codeUnitAt(m) - 'a'.codeUnitAt(0)] : -1;
          if (p < q) break;
          if (p > q) return false;
        }
      }
    }
    return true;
  }
}
