/*

*/

import 'dart:collection';

class A {
  List<int> topKFrequent(List<int> words, int k) {
    final HashMap<int, int> hashMap = HashMap<int, int>();

    for (final int word in words) {
      if (hashMap[word] == null) {
        hashMap[word] = 1;
      } else {
        hashMap[word] = hashMap[word]! + 1;
      }
    }

    final List<MapEntry<int, int>> sortedHashMap =
        hashMap.entries.toList(growable: true)
          ..sort((a, b) {
            if (a.value.compareTo(b.value) == 0) {
              return a.key.compareTo(b.key);
            }
            return b.value.compareTo(a.value);
          });

    return sortedHashMap.sublist(0, k).map((e) => e.key).toList();
  }
}
