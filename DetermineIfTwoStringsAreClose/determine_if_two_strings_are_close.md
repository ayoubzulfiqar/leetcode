# 🔥 Determine if Two Strings Are Close 🔥 || 3 Approaches|| Simple Fast and Easy || with Explanation

## Solution - 1

```dart
class Solution {
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
```

## Solution - 2

```dart
class Solution {
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
    l1.sort();
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
```

## Solution - 3

```dart
class Solution {
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
```
