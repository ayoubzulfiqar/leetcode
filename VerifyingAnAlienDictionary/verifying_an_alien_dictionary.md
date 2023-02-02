# 🔥 3 Approaches 🔥 || Simple Fast and Easy || with Explanation

## Intuition

Lets first crack normal word comparisons, how did we arrive at the below conclusions?? We have a map in our head that
a --1 b--2 or z>x
hello , leetcode – true
hello, hi – true
app, apple – true

Similarly we just give a defined map and ask the computer to compare like us. :)

## Approach

Use a orderMap array to store the new order of letters.(I prefer array over hashmap, since inserting takes time in hashmap).
Write a custom compare method which returns false if the order has to be reverse.

1. In the compare method initiate j = 0;
2. write a while loop and check if j < s1.length and s2.length.
3. compare each letter with the new orderMap.
if letters are same j++;
if letter of s1> s2 return true
else return false
4. Special case for words like app, apple, if s1.length<s2.length return false
return true

## Code

```dart
class Solution {
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
```

## Approach

The naive approach here would be to iterate through pairs of consecutive words in our input array (W) and compare the position of each letter in the input alphabet (O), moving letter by letter until we find a discrepancy and can determine which word comes first lexicographically.

As this is an Easy question, this method works, but with a time complexity of O(N *M* P) where N is the length of W, M is the average length of each word in W, and P is the length of O.

Rather than repetitively finding the position of a character in O, however, we can create a lookup table of indexes from O (alpha) at a time complexity of O(P) and turn every position lookup into a simple O(1) operation. That changes the overall time complexity to O(N * M + P).

Then, as noted before, we can just iterate through word pairs (a, b) in W, then iterate through comparative characters (aChar, bChar) in those two words and evaluate them based on their lexicographical indexes (aix, bix).

If aix < bix or if we reach the end of a, then the two words are in correct lexicographical order and we should move to the next pair of words. If aix > bix or if we reach the end of b, the two words are not in correct lexicographical order and we should return false.

If we reach the end without exiting, we should return true.

## Complexity

Time complexity: O(N * M + P).
Space complexity: O(n)

## Code

```dart
import 'dart:collection';

class Solution {
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
```

## Code = 3

```dart
class Solution {
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
```
