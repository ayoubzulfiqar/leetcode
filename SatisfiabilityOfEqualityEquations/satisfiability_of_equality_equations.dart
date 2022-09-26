/*

 -* Satisfiability Of Equality Equations *-


You are given an array of strings equations that represent relationships between variables where each string equations[i] is of length 4 and takes one of two different forms: "xi==yi" or "xi!=yi".Here, xi and yi are lowercase letters (not necessarily different) that represent one-letter variable names.

Return true if it is possible to assign integers to variable names so as to satisfy all the given equations, or false otherwise.



Example 1:

Input: equations = ["a==b","b!=a"]
Output: false
Explanation: If we assign say, a = 1 and b = 1, then the first equation is satisfied, but not the second.
There is no way to assign the variables to satisfy both equations.
Example 2:

Input: equations = ["b==a","a==b"]
Output: true
Explanation: We could assign a = 1 and b = 1 to satisfy both equations.


Constraints:

1 <= equations.length <= 500
equations[i].length == 4
equations[i][0] is a lowercase letter.
equations[i][1] is either '=' or '!'.
equations[i][2] is '='.
equations[i][3] is a lowercase letter.


*/

class A {
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

// extension CharAt<T> on String {
//   String charAt(String subject, int position) {
//     if (subject is! String ||
//         subject.length <= position ||
//         subject.length + position < 0) {
//       return '';
//     }

//     int _realPosition = position < 0 ? subject.length + position : position;

//     return subject[_realPosition];
//   }
// }

// extension Operator on String {
//   operator -(String other) {
//     return double.parse(this) - double.parse(other);
//   }
// }

// class B {
//   // 256
//   List<int> parent = List.filled(26, 0);
//   int find(int c) {
//     return parent[c] == c ? c : find(parent[c]);
//   }

//   bool equationsPossible(List<String> equations) {
//     for (int i = 0; i < 26; i++) {
//       parent[i] = i;
//     }
//     for (String s in equations) {
//       var c1 = s[0];
//       var c2 = s[3];
//       if (s[1] == '=') {
//         int i1 = find(c1 - 'a');
//         int i2 = find(c2 - 'a');
//         if (i1 != i2) {
//           parent[i1] = i2;
//         }
//       } else if (c1 == c2) {
//         return false;
//       }
//     }
//     for (String s in equations) {
//       if (s[1] == '!') {
//         int x = find(s[0] - 'a');
//         int y = find(s[3] - 'a');
//         if (x == y) {
//           return false;
//         }
//       }
//     }
//     return true;
//   }
// }

// class C {
//   bool equationsPossible(List<String> equations) {}
// }

// class D {
//   bool equationsPossible(List<String> equations) {}
// }

// class E {
//   bool equationsPossible(List<String> equations) {}
// }
