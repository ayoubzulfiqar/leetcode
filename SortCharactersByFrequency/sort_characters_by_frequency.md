# 🔥 Sort Characters By Frequency 🔥 || Simple Fast and Easy || with Explanation

## Solution - 1

```dart
import 'dart:collection';

class Solution {
  String frequencySort(String s) {
    HashMap<String, int> map = HashMap();
    for (int i = 0; i < s.length; i++) {
      map[s[i]] = (map[s[i]] ?? 0) + 1;
    }
//         convert map into the list for comparison
    List<MapEntry<String, int>> list = map.entries.toList();

//         sorting the list for the elements
    list.sort((a, b) => b.value.compareTo(a.value));

    StringBuffer sb = StringBuffer();
    for (MapEntry<String, int> e in list) {
      int i = e.value;
      while (i > 0) {
        sb.write(e.key);
        i--;
      }
    }
    return sb.toString();
  }
}
```
