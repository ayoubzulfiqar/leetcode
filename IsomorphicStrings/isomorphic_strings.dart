/*

 -* Isomorphic Strings *-

Given two strings s and t, determine if they are isomorphic.

Two strings s and t are isomorphic if the characters in s can be replaced to get t.

All occurrences of a character must be replaced with another character while preserving the order of characters. No two characters may map to the same character, but a character may map to itself.



Example 1:

Input: s = "egg", t = "add"
Output: true
Example 2:

Input: s = "foo", t = "bar"
Output: false
Example 3:

Input: s = "paper", t = "title"
Output: true


Constraints:

1 <= s.length <= 5 * 104
t.length == s.length
s and t consist of any valid ascii character.


*/

// class A {
//   bool isIsomorphic(String s, String t) {
//     Map<String, int>? table = {}, tTable = {};
//     for (int i = 0; i < s.length; i++) {
//       // 15 is magic number
//       int bit = (1 << (i % 15));

//       if( table[s[i]] != null){
//         table[s[i]] |= bit;
//       }

//       tTable[t[i]] |= bit;

//       if (table[s[i]] != tTable[t[i]]) {
//         return false;
//       }
//     }

//     return true;
//   }
// }

class B {
// Runtime: 625 ms, faster than 16.13% of Dart online submissions for Isomorphic Strings.
// Memory Usage: 140.6 MB, less than 100.00% of Dart online submissions for Isomorphic Strings.
  bool isIsomorphic(String s, String t) {
    // Base case: for different length of two strings...
    if (s.length != t.length) return false;
    // Create two maps for s & t strings...
    List<int> map1 = List.filled(256, 0);
    List<int> map2 = List.filled(256, 0);
    // Traverse all elements through the loop...
    for (int idx = 0; idx < s.length; idx++) {
      // Compare the maps, if not equal, return false...
      if (map1[s.codeUnitAt(idx)] != map2[t.codeUnitAt(idx)]) return false;
      // Insert each character if string s and t into seperate map...
      map1[s.codeUnitAt(idx)] = idx + 1;
      map2[t.codeUnitAt(idx)] = idx + 1;
    }
    return true; // Otherwise return true...
  }
}

class C {
// Runtime: 611 ms, faster than 16.13% of Dart online submissions for Isomorphic Strings.
// Memory Usage: 144.2 MB, less than 64.52% of Dart online submissions for Isomorphic Strings.
  bool isIsomorphic(String s, String t) {
    Map mapS = {}, mapT = {};
    for (int i = 0; i < s.length; i++) {
      if (mapS[s[i]] != null && mapT[t[i]] != null) {
        mapS[s[i]] = t[i];
        mapT[t[i]] = s[i];
      } else if (mapS[s[i]] != t[i] || mapT[t[i]] != s[i]) return false;
    }
    return true;
  }
}

class D {
  bool isIsomorphic(String s, String t) {
    Map cypher = Map();
    for (int i = 0; i < s.length; i++) {
      if (cypher.containsKey(s[i])) {
        //cypher.set(s[i], t[i]);
        cypher.forEach((key, value) {
          key = s[i];
          value = t[i];
        });
      } else if (cypher.entries.contains(s.codeUnitAt(i)) != t.codeUnitAt(i)) {
        return false;
      }
    }
    return cypher.values.length == cypher.length;
  }
}
