# 🔥 Find the Difference 🔥 || 6 Approaches || Simple Fast and Easy || with Explanation

## Solution - 1

```dart
class Solution {
  String findTheDifference(String s, String t) {
    int n = s.length;
    s.split("").sort();
    t.split("").sort();
    for (int i = 0; i < n; i++) {
      if (s[i] != t[i]) {
        return t[i];
      }
    }
    return s[n];
  }
}
```

## Solution - 2

```dart
class Solution {
  String findTheDifference(String s, String t) {
    HashMap<String, int> mp = HashMap();
    for (String c in s.split("")) {
      mp[c] = (mp[c] ?? 0) + 1;
    }
    for (String c in t.split("")) {
      if (((mp[c] ?? 0) - 1) < 0) return c;
    }
    return '\0';
  }
}
```

## Solution - 3

```dart
class Solution {
  String findTheDifference(String s, String t) {
    List<int> v = List.filled(26, 0);
    for (String c in s.split("")) v[c.codeUnitAt(0) - 'a'.codeUnitAt(0)] += 1;
    for (String c in t.split(""))
      if (--v[c.codeUnitAt(0) - 'a'.codeUnitAt(0)] < 0) return c;
    return '\0';
  }
}
```

## Solution - 4

```dart
class Solution {
  String findTheDifference(String s, String t) {
    int ret = '\0'.codeUnitAt(0);
    for (String c in s.split("")) ret ^= int.parse(c);
    for (String c in t.split("")) ret ^= int.parse(c);
    return ret.toString();
  }
}
```
