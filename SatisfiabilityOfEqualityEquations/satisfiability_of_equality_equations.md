# ✅ DART || simple fast easy || with explanation

* To solve this, we will follow these steps −

* Define a method called getParent(), this will take character x and the map m, this will work as follows −

* if m[x] = x, then return x,

* otherwise set m[x] := getParent(m[x], m) and return m[x]

* From the main method, do the following −

* define two arrays equal and notEqual, create a map called parent

* n := size of e

* for i in range 0 to n – 1

* set parent[e[i, 0]] := e[i, 0], parent[e[i, 3]] := e[i, 3]

* if e[i, 1] is equal sign, then insert i into equal array, otherwise insert i into notEqual array

* for i in range 0 to size of equal – 1

* index := equal[i], set u, v as e[index, 0] and e[index, 3]

* parent[getParent(u, parent)] := parent[getParent(v, parent)]

* for i in range 0 to size of notEqual – 1

* index := notEqual[i], set u, v as e[index, 0] and e[index, 3]

* if getParent(u, parent) = getParent(v, parent), then return false

* return true

```dart
class Solution {
// Runtime: 487 ms, faster than 100.00% of Dart online submissions for Satisfiability of Equality Equations.
// Memory Usage: 142.4 MB, less than 100.00% of Dart online submissions for Satisfiability of Equality Equations.
  bool equationsPossible(List<String> equations) {
    String getParent(String? x, Map<String, String> m) {
      if (m[x] == x) return x!;
      return m[x!] = getParent(m[x], m);
    }

    List<int> equal = List.empty(growable: true);
    List<int> notEqual = List.empty(growable: true);
    Map<String, String> parent = {};
    int n = equations.length;
    for (int i = 0; i < n; i++) {
      parent[equations[i][0]] = equations[i][0];
      parent[equations[i][3]] = equations[i][3];
      if (equations[i][1] == '=') {
        equal.add(i);
      } else {
        notEqual.add(i);
      }
    }
    for (int i = 0; i < equal.length; i++) {
      int idx = equal[i];
      String u = equations[idx][0];
      String v = equations[idx][3];
      parent[getParent(u, parent)] = parent[getParent(v, parent)]!;
    }
    for (int i = 0; i < notEqual.length; i++) {
      int idx = notEqual[i];
      String u = equations[idx][0];
      String v = equations[idx][3];
      if (getParent(u, parent) == getParent(v, parent)) return false;
    }
    return true;
  }
}
```
