/*


 -* Ransom Note *-


 Given two strings ransomNote and magazine, return true if ransomNote can be constructed by using the letters from magazine and false otherwise.

Each letter in magazine can only be used once in ransomNote.



Example 1:

Input: ransomNote = "a", magazine = "b"
Output: false
Example 2:

Input: ransomNote = "aa", magazine = "ab"
Output: false
Example 3:

Input: ransomNote = "aa", magazine = "aab"
Output: true


Constraints:

1 <= ransomNote.length, magazine.length <= 105
ransomNote and magazine consist of lowercase English letters.






*/

/*





*/
import 'dart:collection';

class A {
  bool canConstruct(String ransomNote, String magazine) {
    // Base case
    if (ransomNote.length > magazine.length) return false;
    // .. English Alphabets
    List<int> alphabetCounter = List.filled(26, 0);
    // every element in the magazine
    // i represents as Index
    for (String i in magazine.split("")) {
      // saving the index value of each and every alphabet based on Character Code
      alphabetCounter[i.codeUnitAt(0) - 'a'.codeUnitAt(0)]++;
    }
    // every element in the ransom Note
    for (String i in ransomNote.split("")) {
      // if index is zero means we can not construct String because it does not exist
      if (alphabetCounter[i.codeUnitAt(0) - 'a'.codeUnitAt(0)] == 0) {
        return false;
      } else {
        // else we decrement that character exist
        alphabetCounter[i.codeUnitAt(0) - 'a'.codeUnitAt(0)]--;
      }
    }
    // all other possible cases
    return true;
  }
}

class B {
  bool canConstruct(String ransomNote, String magazine) {
    HashMap<String, int> map = HashMap();
    for (String c in magazine.split(""))
      map[c] = map.putIfAbsent(c, () => 0) + 1;

    for (String c in ransomNote.split("")) {
      if (!map.containsKey(c) || map[c]! < 1) return false;
      map[c] = map[c]! - 1;
    }

    return true;
  }
}
