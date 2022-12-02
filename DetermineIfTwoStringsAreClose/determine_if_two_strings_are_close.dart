/*

-* 1657. Determine if Two Strings Are Close *-

Two strings are considered close if you can attain one from the other using the following operations:

Operation 1: Swap any two existing characters.
For example, abcde -> aecdb
Operation 2: Transform every occurrence of one existing character into another existing character, and do the same with the other character.
For example, aacabb -> bbcbaa (all a's turn into b's, and all b's turn into a's)
You can use the operations on either string as many times as necessary.

Given two strings, word1 and word2, return true if word1 and word2 are close, and false otherwise.

 

Example 1:

Input: word1 = "abc", word2 = "bca"
Output: true
Explanation: You can attain word2 from word1 in 2 operations.
Apply Operation 1: "abc" -> "acb"
Apply Operation 1: "acb" -> "bca"
Example 2:

Input: word1 = "a", word2 = "aa"
Output: false
Explanation: It is impossible to attain word2 from word1, or vice versa, in any number of operations.
Example 3:

Input: word1 = "cabbba", word2 = "abbccc"
Output: true
Explanation: You can attain word2 from word1 in 3 operations.
Apply Operation 1: "cabbba" -> "caabbb"
Apply Operation 2: "caabbb" -> "baaccc"
Apply Operation 2: "baaccc" -> "abbccc"
 

Constraints:

1 <= word1.length, word2.length <= 105
word1 and word2 contain only lowercase English letters.



*/

import 'dart:collection';
import 'dart:math';

class A {
  bool closeStrings(String word1, String word2) {
    List<int> freq1 = List.filled(26, 0);
    List<int> freq2 = List.filled(26, 0);
    for (int i = 0; i < word1.length; i++) {
      freq1[word1.codeUnitAt(i) - 'a'.codeUnitAt(0)]++;
    }
    for (int i = 0; i < word2.length; i++) {
      freq2[word2.codeUnitAt(i) - 'a'.codeUnitAt(0)]++;
    }
    for (int i = 0; i < 26; i++) {
      if ((freq1[i] == 0 && freq2[i] != 0) || (freq1[i] != 0 && freq2[i] == 0))
        return false;
    }
    freq1.sort();
    freq2.sort();
    for (int i = 0; i < 26; i++) {
      if (freq1[i] != freq2[i]) return false;
    }
    return true;
  }
}

class B {
  bool closeStrings(String word1, String word2) {
    HashSet<String> set1 = HashSet();
    for (String c in word1.split("")) {
      set1.add(c);
    }
    for (String c in word2.split("")) {
      if (set1.contains(c)) {
        set1.remove(c);
      }
    }
    if (set1.length != 0) {
      return false;
    }
    List<int> l1 = [];
    List<int> l2 = [];
    Map<String, int> map1 = HashMap();
    Map<String, int> map2 = HashMap();
    for (String c in word1.split("")) {
      if (!map1.containsKey(c)) {
        map1[c] = 1;
      } else {
        map1[c] = (map1[c] ?? 0) + 1;
      }
    }
    for (String c in word2.split("")) {
      if (!map2.containsKey(c)) {
        map2[c] = 1;
      } else {
        map2[c] = (map2[c] ?? 0) + 1;
      }
    }
    for (int p in map1.values) {
      l1.add(p);
    }
    for (int p in map2.values) {
      l2.add(p);
    }
    // Collections.sort(l1);
    l1.sort();
    // Collections.sort(l2);
    l2.sort();
    StringBuffer sb1 = StringBuffer();
    StringBuffer sb2 = StringBuffer();
    for (int p in l1) {
      sb1.write(String.fromCharCode(p));
    }
    for (int p in l2) {
      sb2.write(String.fromCharCode(p));
    }
    return sb1.toString() == sb2.toString();
  }
}

class C {
  bool closeStrings(String word1, String word2) {
    if (word1.length > word2.length || word1.length < word2.length) {
      return false;
    }
    List<int> w1 = List.filled(26, 0);
    List<int> w2 = List.filled(26, 0);
    int maxi = 0;
    for (int i = 0; i < word1.length; i++) {
      w1[word1.codeUnitAt(i) - 'a'.codeUnitAt(0)] += 1;
      maxi = max(maxi, w1[word1.codeUnitAt(i) - 'a'.codeUnitAt(0)]);
    }
    for (int i = 0; i < word2.length; i++) {
      w2[word2.codeUnitAt(i) - 'a'.codeUnitAt(0)] += 1;
      maxi = max(maxi, w2[word2.codeUnitAt(i) - 'a'.codeUnitAt(0)]);
    }
    for (int i = 0; i < 26; i++) {
      if ((w1[i] != 0 && w2[i] == 0) || (w1[i] == 0 && w2[i] != 0)) {
        return false;
      }
    }
    List<int> f = List.filled(maxi + 1, 0);
    for (int i = 0; i < 26; i++) {
      f[w1[i]] += 1;
    }
    for (int i = 0; i < 26; i++) {
      f[w2[i]] -= 1;
    }
    for (int i = 1; i <= maxi; i++) {
      if (f[i] > 0) {
        return false;
      }
    }
    return true;
  }
}
