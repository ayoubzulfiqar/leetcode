# 🔥 Minimum Window Substring 🔥 || 3 Solutions || Simple Fast and Easy || with Explanation

## Solution - 1

```dart
class Solution {
// Runtime: 529 ms, faster than 50.00% of Dart online submissions for Minimum Window Substring.
// Memory Usage: 149.5 MB, less than 100.00% of Dart online submissions for Minimum Window Substring.
  String minWindow(String s, String t) {
    List<int> ht = List.filled(100, 0);
    int i = 0, j = 0;
    List<int> cht = List.filled(100, 0);
    int m = s.length,
        n = t.length,
        cnt = 0,
        reqcnt = 0,
        min = double.maxFinite.toInt();
    String res = "";
    List<String> ss = s.split("");
    List<String> tt = t.split("");
    for (String ch in tt) cht[ch.codeUnitAt(0) - 'A'.codeUnitAt(0)]++;
    for (int num in cht) if (num > 0) reqcnt++;
    while (j <= m) {
      if (cnt == reqcnt) {
        if (min > (j - i + 1)) {
          min = j - i + 1;
          res = s.substring(i, j);
        }
        if (cht[ss[i].codeUnitAt(0) - 'A'.codeUnitAt(0)] > 0) {
          ht[ss[i].codeUnitAt(0) - 'A'.codeUnitAt(0)]--;
          if (ht[ss[i].codeUnitAt(0) - 'A'.codeUnitAt(0)] <
              cht[ss[i].codeUnitAt(0) - 'A'.codeUnitAt(0)]) cnt--;
        }
        i++;
      } else {
        if (j == m) break;
        if (cht[ss[j].codeUnitAt(0) - 'A'.codeUnitAt(0)] > 0) {
          ht[ss[j].codeUnitAt(0) - 'A'.codeUnitAt(0)]++;
          if (ht[ss[j].codeUnitAt(0) - 'A'.codeUnitAt(0)] ==
              cht[ss[j].codeUnitAt(0) - 'A'.codeUnitAt(0)]) cnt++;
        }
        j++;
      }
    }
    return res;
  }
}
```

## Solution - 2

- Initialize a vector called remaining, which contains the needed
matching numbers of each character in s.
- If there are still
characters needed to be contained (increment i in this case),
decrease the matching number of that character and check if it is
still non-negative. If it is, then it is the character in t, so
decrease the total required number required.
- If there is no more
characters required (increment start in this case), record min
and left if a smaller length is found. Recover the number of this
character in the remaining and if it is a character in t
increase required.

```dart
class Solution {
// Runtime: 555 ms, faster than 50.00% of Dart online submissions for Minimum Window Substring.
// Memory Usage: 142.8 MB, less than 100.00% of Dart online submissions for Minimum Window Substring.
  String minWindow(String s, String t) {
    if (s == "" || t == "") return "";
    if (s.isEmpty || t.isEmpty) return "";

    int n = s.length;
    int m = t.length;

    List<int> freq = List.filled(128, 0);
    int characters = 0;

    for (int i = 0; i < m; i++) {
      freq[t.codeUnitAt(i)]++;
      characters++;
    }

    int start = 0, end = 0;
    int min_length = double.maxFinite.toInt();
    int start_index = 0;

    while (end < n) {
      if (freq[s.codeUnitAt(end)] > 0) characters--;
      freq[s.codeUnitAt(end)]--;
      end++;

      while (characters == 0) {
        if (min_length > end - start) {
          min_length = end - start;
          start_index = start;
        }
        freq[s.codeUnitAt(start)]++;
        if (freq[s.codeUnitAt(start)] > 0) {
          characters++;
        }
        start++;
      }
    }

    return min_length == double.maxFinite.toInt()
        ? ""
        : s.substring(start_index, start_index + min_length);
  }
}
```

## Solution - 3

### Sliding window problem

- Use 2 pointers left and right and traverse upon string "s"(keep increasing size of window)
- If relevant letter(exists in t) is found in s count it scout[s[right]]++ ,also count total number of letters found until now
- If more letters have been found than required,try decreasing window size ,otherwise the window size will keep on increasing.
window size can be decreased when
either the left most element is irrelevant(doesn't occur in t)
or the leftmost element count is more than required (occurs again in string s )
when decreasing window size make sure to reduce count of leftmost char in s as now they don't exist in the window
otherwise keep on increasing window size from right
also update mini-window left and right indices to later on get resultant string

```dart
class Solution {
// Runtime: 309 ms, faster than 100.00% of Dart online submissions for Minimum Window Substring.
// Memory Usage: 158.3 MB, less than 50.00% of Dart online submissions for Minimum Window Substring.
  String minWindow(String s, String t) {
    int m = s.length, n = t.length;
    List<int> map = List.filled(128, 0);
    for (int i = 0; i < n; i++) map[t.codeUnitAt(i)]++;

    int count = 0, i = 0, j = 0, min = double.maxFinite.toInt(), si = -1;
    while (j < m) {
      if (map[s.codeUnitAt(j++)]-- > 0) count++;
      while (count == n) {
        if (j - i < min) {
          min = j - i;
          si = i;
        }
        if (++map[s.codeUnitAt(i++)] > 0) count--;
      }
    }
    return si == -1 ? "" : s.substring(si, si + min);
  }
}
```
