# 🔥 2 Approaches 🔥 || Simple Fast and Easy || with Explanation

## Solution - Recursion - Depth First Search

### Approach for this Problem

Create an empty set 's' to store all the words in the given array of strings.
Iterate through the array of strings and insert each word into the set 's'.
Create an empty vector 'concatenateWords' to store all the concatenated words.
Iterate through the array of strings again, for each word, check if it is a concatenated word using the function 'checkConcatenate(word)'.
In the 'checkConcatenate(word)' function, use a for loop to iterate through each substring of the word, starting from index 1 to the second last index of the word.
For each substring, check if the prefix and suffix of the substring exists in the set 's'.
If the prefix and suffix both exist in the set 's', then return true, indicating that the word is a concatenated word.
If the function 'checkConcatenate(word)' returns true, then insert the word into the 'concatenateWords' vector.
Return the 'concatenateWords' vector.

### Time Complexity and Space Complexity

- Time complexity: O(n^2*m) //where n is the number of words in the input array and m is the average length of the words.
- Space complexity: O(n*m) //where n is the number of words in the input array and m is the average length of the words.

### Code

```dart
import 'dart:collection';

class Solution {
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
```

## Solution - 2 DP

### Code

```dart
class Solution {
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
```
