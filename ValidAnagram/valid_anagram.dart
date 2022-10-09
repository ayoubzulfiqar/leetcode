/*


 -* Valid Anagram *-

Given two strings s and t, return true if t is an anagram of s, and false otherwise.

An Anagram is a word or phrase formed by rearranging the letters of a different word or phrase, typically using all the original letters exactly once.



Example 1:

Input: s = "anagram", t = "nagaram"
Output: true
Example 2:

Input: s = "rat", t = "car"
Output: false


Constraints:

1 <= s.length, t.length <= 5 * 104
s and t consist of lowercase English letters.


Follow up: What if the inputs contain Unicode characters? How would you adapt your solution to such a case?

*/

class A {
  bool isAnagram(String s, String t) {
    if (s.length != t.length) return false;
    final List<String> listOne = s.split('')..sort();
    final List<String> listTwo = t.split('')..sort();

    return listOne.join() == listTwo.join();
  }
}

class B {
  bool isAnagram(String s, String t) {
    if (s.length != t.length) return false;
    final List<String> listOne = s.split('');
    final List<String> listTwo = t.split('');
    for (int i = 0; i < listOne.length; i++) {
      int index = listTwo.indexWhere((element) => element == listOne[i]);
      if (index >= 0) {
        listTwo.removeAt(index);
      } else {
        return false;
      }
    }
    return true;
  }
}

class C {
  bool isAnagram(String s, String t) {
    if (s.length != t.length) return false;
    final Map<String, int> mapOne = {};
    final Map<String, int> mapTwo = {};

    for (int i = 0; i < s.length; i++) {
      mapOne[s[i]] = (mapOne[s[i]] ?? 0) + 1;
      mapTwo[t[i]] = (mapTwo[t[i]] ?? 0) + 1;
    }
    final mapOneKeys = mapOne.keys.toList();
    final mapOneValues = mapOne.values.toList();

    for (int i = 0; i < mapOne.length; i++) {
      final key = mapOneKeys[i];
      final value = mapOneValues[i];

      if (mapTwo[key] != value) return false;
    }
    return true;
  }
}
