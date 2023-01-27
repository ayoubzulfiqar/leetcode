/*



-* 472. Concatenated Words *-

Given an array of strings words (without duplicates), return all the concatenated words in the given list of words.

A concatenated word is defined as a string that is comprised entirely of at least two shorter words in the given array.

 

Example 1:

Input: words = ["cat","cats","catsdogcats","dog","dogcatsdog","hippopotamuses","rat","ratcatdogcat"]
Output: ["catsdogcats","dogcatsdog","ratcatdogcat"]
Explanation: "catsdogcats" can be concatenated by "cats", "dog" and "cats"; 
"dogcatsdog" can be concatenated by "dog", "cats" and "dog"; 
"ratcatdogcat" can be concatenated by "rat", "cat", "dog" and "cat".
Example 2:

Input: words = ["cat","dog","catdog"]
Output: ["catdog"]
 

Constraints:

1 <= words.length <= 104
1 <= words[i].length <= 30
words[i] consists of only lowercase English letters.
All the strings of words are unique.
1 <= sum(words[i].length) <= 105





*/

import 'dart:collection';

class A {
  bool checkConcatenate(String word, Set<String> s) {
    for (int i = 1; i < word.length; i++) {
      String prefixWord = word.substring(0, i);
      String suffixWord = word.substring(i, word.length);
      if (s.contains(prefixWord) &&
          (s.contains(suffixWord) || checkConcatenate(suffixWord, s)))
        return true;
    }
    return false;
  }

  List<String> findAllConcatenatedWordsInADict(List<String> words) {
    HashSet<String> s = HashSet();
    List<String> concatenateWords = [];
    for (String word in words) s.add(word);
    for (String word in words) {
      if (checkConcatenate(word, s) == true) concatenateWords.add(word);
    }
    return concatenateWords;
  }
}

class B {
  List<String> findAllConcatenatedWordsInADict(List<String> words) {
    HashSet<String> wordsSet = HashSet();
    for (String word in words) wordsSet.add(word);
    List<String> res = [];

    for (String word in words) {
      int n = word.length;
      List<int> dp = List.filled(n + 1, 0);
      dp[0] = 1;
      for (int i = 0; i < n; i++) {
        if (dp[i] != 0) continue;
        for (int j = i + 1; j <= n; j++) {
          if (j - i < n && wordsSet.contains(word.substring(i, j - i))) {
            dp[j] = 1;
          }
        }
        if (dp[n] == 0) {
          res.add(word);
          break;
        }
      }
    }
    return res;
  }
}

class C {
  List<String> findAllConcatenatedWordsInADict(List<String> words) {
    List<String> result = [];
    HashSet<String> set = HashSet();
    for (String word in words) set.add(word);
    for (String word in words) helper(result, set, word);
    return result;
  }

  void helper(List<String> list, HashSet<String> set, String word) {
    if (word.length == 0) return;
    List<bool> dp = List.filled(word.length + 1, false);
    dp[0] = true;
    for (int i = 0; i < word.length; i++) {
      if (!dp[i]) continue;
      for (int j = i + 1; j < dp.length; j++) {
        if (i == 0 && j == word.length) continue;
        if (set.contains(word.substring(i, j))) dp[j] = true;
      }
    }
    if (dp[dp.length - 1]) list.add(word);
  }
}
