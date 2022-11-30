# 🔥 Is Subsequence 🔥 || 5 Approaches || Simple Fast and Easy || with Explanation

## Solution - 1

```dart
class Solution {
  bool isSubsequence(String s, String t) {
    if (s.length > t.length) return false;
    int j = 0;
    for (int i = 0; i < t.length && j < s.length; i++) {
      if (s[j] == t[i]) {
        j++;
      }
    }
    if (j == t.length) return true;
    return false;
  }
}
```

## Solution - 2

```dart
class Solution {
  bool isSubString(String s, String t, int m, int n) {
    if (m == 0) return true;
    if (n == 0) return false;

    // If last characters of two
    // strings are matching
    if (s[m - 1] == t[n - 1]) return isSubString(s, t, m - 1, n - 1);

    // If last characters are
    // not matching
    return isSubString(s, t, m, n - 1);
  }

  bool isSubsequence(String s, String t) {
    if (isSubString(s, t, s.length, t.length)) return true;

    return false;
  }
}

```

## Solution - 3

```dart
class Solution {
  int isSubs(String s1, String s2, int i, int j, List<List<int>> t) {
    if (i == 0 || j == 0) return 0;
    if (t[i][j] != -1) return t[i][j];
    if (s1[i - 1] == s2[j - 1])
      return t[i][j] = 1 + isSubs(s1, s2, i - 1, j - 1, t);
    else
      return t[i][j] = isSubs(s1, s2, i, j - 1, t);
  }

  bool isSubsequence(String s, String t) {
    int m = s.length;
    int n = t.length;

    // initializing dp matrix with -1

    if (m > n) return false;

    List<List<int>> f =
        List.filled(m + 1, 0).map((e) => List.filled(n + 1, -1)).toList();

    if (isSubs(s, t, m, n, f) == m) return true;
    return false;
  }
}
```

## Solution - 4

```dart
class Solution {
  bool isSubsequence(String s, String t) {
    for (int x = t.length - 1; x >= 0 && s.isNotEmpty; x--)
      if (t[x] == s[s.length - 1])
        s.split("").removeLast(); //treating subsequence string as a stack
    return s.isEmpty;
  }
}
```

## Solution - 5

```dart
class Solution {
  bool isSubsequence(String s, String t) {
    int p1 = 0;
    int p2 = 0;
    while (p1 < s.length) {
      while (p2 < t.length) {
        if (s[p1] == t[p2]) break;
        p2++;
      }
      if (p2 == t.length) return false;
      p1++;
      p2++;
    }
    return true;
  }
}
```
