/*


-* 451. Sort Characters By Frequency *-





Given a string s, sort it in decreasing order based on the frequency of the characters. The frequency of a character is the number of times it appears in the string.

Return the sorted string. If there are multiple answers, return any of them.

 

Example 1:

Input: s = "tree"
Output: "eert"
Explanation: 'e' appears twice while 'r' and 't' both appear once.
So 'e' must appear before both 'r' and 't'. Therefore "eetr" is also a valid answer.
Example 2:

Input: s = "cccaaa"
Output: "aaaccc"
Explanation: Both 'c' and 'a' appear three times, so both "cccaaa" and "aaaccc" are valid answers.
Note that "cacaca" is incorrect, as the same characters must be together.
Example 3:

Input: s = "Aabb"
Output: "bbAa"
Explanation: "bbaA" is also a valid answer, but "Aabb" is incorrect.
Note that 'A' and 'a' are treated as two different characters.
 

Constraints:

1 <= s.length <= 5 * 105
s consists of uppercase and lowercase English letters and digits.

*/

// class Pair {
//   late int val;
//   late String c;
//   Pair(String c, int val) {
//     this.c = c;
//     this.val = val;
//   }
// }

// class A {
//   String frequencySort(String s) {
//     // PriorityQueue for sorting elements on decreasing order based on frequency
//     // b.val - a.val => store pair objects based on decreasing order of frequency value
//     Queue<Pair> pq = Queue()..toList().sort((a, b) => b.val - a.val);

//     // HashMap to store elements and their current frequency
//     HashMap<String, int> hm = HashMap();
//     List<String> c = s.split("");
//     for (int i = 0; i < c.length; i++) {
//       int count = hm[c[i]] ?? 0;
//       //add element and current frequency in hashmap
//       hm[c[i]] = count + 1;
//     }
//     //add whole hashmap to priorityQueue
//     for (MapEntry<String, int> entry in hm.entries) {
//       Pair pair = new Pair(entry.key, entry.value);
//       pq.add(pair);
//     }
//     StringBuffer sb = StringBuffer("");
//     //extract value from priorityQueue and add it into answer string
//     while (pq.isNotEmpty) {
//       Pair pair = pq.removeFirst();
//       int count = pair.val;
//       String ch = pair.c;
//       // add character into answer string as many time as frequency (it appears in main string)
//       while (count-- > 0) {
//         sb.write(ch);
//       }
//     }
//     return sb.toString();
//   }
// }

import 'dart:collection';

class Pair {
  late final String c;
  late final int val;
  Pair(int val, String c) {
    this.c = c;
    this.val = val;
  }
}

class B {
  String frequencySort(String s) {
    HashMap<String, int> map = HashMap();
    for (String c in s.split("")) {
      map[c] = (map[c] ?? 0) + 1;
    }

    //heap
    Queue<String> pq = Queue()
      ..toList().sort((a, b) => (map[b]! - map[a]!)); //for decreasing order
    pq.addAll(map.keys);

    //putting in string builder
    StringBuffer sb = StringBuffer();
    while (!pq.isEmpty) {
      String c = pq.removeFirst();
      for (int i = 0; i < map[c]!; i++) {
        sb.write(c);
      }
    }
    return sb.toString();
  }
}

class C {
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
