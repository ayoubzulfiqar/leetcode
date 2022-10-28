/*


-* Group Anagrams *-

Given an array of strings strs, group the anagrams together. You can return the answer in any order.

An Anagram is a word or phrase formed by rearranging the letters of a different word or phrase, typically using all the original letters exactly once.



Example 1:

Input: strs = ["eat","tea","tan","ate","nat","bat"]
Output: [["bat"],["nat","tan"],["ate","eat","tea"]]
Example 2:

Input: strs = [""]
Output: [[""]]
Example 3:

Input: strs = ["a"]
Output: [["a"]]


Constraints:

1 <= strs.length <= 104
0 <= strs[i].length <= 100
strs[i] consists of lowercase English letters.



*/

import 'dart:collection';

class A {
// Runtime: 619 ms, faster than 57.69% of Dart online submissions for Group Anagrams.
// Memory Usage: 158.9 MB, less than 23.08% of Dart online submissions for Group Anagrams.
  String getSignature(String s) {
    // list to count each an hold each string as in 26 alphabets in English
    List<int> count = List.filled(26, 0);
    // iterating through each and every element
    for (int i = 0; i < s.length; i++) {
      // than we get the alphabet based on it's char value and keep incrementing it
      count[s.codeUnitAt(i) - 'a'.codeUnitAt(0)]++;
    }

    // string Buffer to write our values
    StringBuffer sb = StringBuffer();
    for (int i = 0; i < 26; i++) {
      if (count[i] != 0) {
        sb.write('a' + String.fromCharCode(i));
        sb.write(count[i]);
      }
    }
    return sb.toString();
  }

  List<List<String>> groupAnagrams(List<String> strs) {
    // Nested List to store w=our final result
    List<List<String>> result = [].map((e) => <String>[]).toList();
    // if it's empty of null we will return empty
    if (strs.isEmpty || strs.length == 0) {
      return result;
    }
    // if it's has something than we will ass inside a list all it's values
    if (strs.length == 1) {
      result.addAll([strs]);
      return result;
    }
    // HashMap to store values
    HashMap<String, List<String>> groups = HashMap();
    // iterating through each alphabet in input string
    for (String s in strs) {
      // getting the unique signature of each and every alphabet from the string
      String signature = getSignature(s);
      // if it is not present in map we will add it as key
      groups.putIfAbsent(signature, () => []);
      // and based on key we will add the each values
      groups[signature]!.add(s);
    }
    // nOw we will return the values as a list because of return type and because values are not iterable
    return groups.values.toList();
  }
}

class B {
  List<List<String>> groupAnagrams(List<String> strs) {
    // initialing our HashMap to store our key and values
    HashMap<String, List<String>> map = HashMap();

    // for each string character in our list of input string
    for (String s in strs) {
      // than we will initialize the list of in as alphabetical - 26 character in English Alphabetical
      // because we wanna use use specific space for each unique character
      List<int> count = List.filled(26, 0);
      // than we will  split the string into each individual character
      for (String c in s.split("")) {
        // than we will count based on the code unit of each english alphabetical word
        count[c.codeUnitAt(0) - 'a'.codeUnitAt(0)]++;
      }
      // than we will store in a temporary string based on it's char code
      String temp = String.fromCharCodes(count);
      // if the map does not have that alpha bet
      if (!map.containsKey(temp)) {
        // than we will add if it's absent inside a nested list
        map.putIfAbsent(temp, () => []);
      }
      // temp we will use as key in our map and s will be it' store value
      map[temp]!.add(s);
    }
    // than we will return it' s value as List because of return type is list and Values are not it's iterable
    return map.values.toList();
  }
}

class C {
  List<List<String>> groupAnagrams(List<String> strs) {
    HashMap<String, List<String>> map = HashMap();
    for (String str in strs) {
      List<String> chars = str.split("");
      chars.sort();

      String sortedStr = chars.toString();
      map.putIfAbsent(sortedStr, () => []);
      map[sortedStr]?.add(str);
    }

    return map.values.toList();
  }
}
