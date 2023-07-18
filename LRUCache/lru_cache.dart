/*

-* 146. LRU Cache *-


Design a data structure that follows the constraints of a Least Recently Used (LRU) cache.

Implement the LRUCache class:

LRUCache(int capacity) Initialize the LRU cache with positive size capacity.
int get(int key) Return the value of the key if the key exists, otherwise return -1.
void put(int key, int value) Update the value of the key if the key exists. Otherwise, add the key-value pair to the cache. If the number of keys exceeds the capacity from this operation, evict the least recently used key.
The functions get and put must each run in O(1) average time complexity.

 

Example 1:

Input
["LRUCache", "put", "put", "get", "put", "get", "put", "get", "get", "get"]
[[2], [1, 1], [2, 2], [1], [3, 3], [2], [4, 4], [1], [3], [4]]
Output
[null, null, null, 1, null, -1, null, -1, 3, 4]

Explanation
LRUCache lRUCache = new LRUCache(2);
lRUCache.put(1, 1); // cache is {1=1}
lRUCache.put(2, 2); // cache is {1=1, 2=2}
lRUCache.get(1);    // return 1
lRUCache.put(3, 3); // LRU key was 2, evicts key 2, cache is {1=1, 3=3}
lRUCache.get(2);    // returns -1 (not found)
lRUCache.put(4, 4); // LRU key was 1, evicts key 1, cache is {4=4, 3=3}
lRUCache.get(1);    // return -1 (not found)
lRUCache.get(3);    // return 3
lRUCache.get(4);    // return 4
 

Constraints:

1 <= capacity <= 3000
0 <= key <= 104
0 <= value <= 105
At most 2 * 105 calls will be made to get and put.



class LRUCache {

  LRUCache(int capacity) {

  }
  
  int get(int key) {

  }
  
  void put(int key, int value) {

  }
}

/**
 * Your LRUCache object will be instantiated and called as such:
 * LRUCache obj = LRUCache(capacity);
 * int param1 = obj.get(key);
 * obj.put(key,value);
 */

*/

// class LRUCache {

//   LRUCache(int capacity) {

//   }

//   int get(int key) {

//   }

//   void put(int key, int value) {

//   }
// }
// import 'dart:collection';

// class LRUCache {
//   late int cnt;
//   Map<int, int> mp = {};
//   Queue<int> dq = Queue();
//   Set<MapEntry<int, int>> st = {};
//   Map<int, int> val = {};
//   int res = 0;

//   LRUCache(int capacity) {
//     cnt = capacity;
//   }

//   int get(int key) {
//     if (mp.containsKey(key)) {
//       int v = val[key]!;
//       st.remove(MapEntry(v, key));
//       res++;
//       st.add(MapEntry(res, key));
//       val[key] = res;
//       return mp[key]!;
//     }
//     return -1; // Return -1 if the key is not present in the cache
//   }

//   void put(int key, int value) {
//     if (!mp.containsKey(key)) {
//       if (mp.length == cnt) {
//         int r = dq.removeFirst();
//         st.remove(MapEntry(val[r]!, r));
//         mp.remove(r);
//         val.remove(r);
//       }
//       res++;
//       mp[key] = value;
//       val[key] = res;
//       st.add(MapEntry(res, key));
//       dq.addLast(key);
//     } else {
//       int v = val[key]!;
//       st.remove(MapEntry(v, key));
//       res++;
//       st.add(MapEntry(res, key));
//       mp[key] = value;
//       val[key] = res;
//     }
//   }
// }

import 'dart:collection';

class LRUCacheOne {
  final Queue<int> leastUsedCache = Queue<int>();
  final List<int> usages = List<int>.filled(10001, 0);
  final List<int> keyValuePair = List<int>.filled(10001, -1);
  int size = 0;
  int cap = 0;

  LRUCacheOne(int capacity) {
    cap = capacity;
  }

  int get(int key) {
    if (keyValuePair[key] != -1) {
      leastUsedCache.add(key);
      usages[key]++;
    }
    return keyValuePair[key];
  }

  void put(int key, int value) {
    if (size < cap || keyValuePair[key] != -1) {
      if (keyValuePair[key] == -1) size++;
      leastUsedCache.add(key);
      usages[key]++;
      keyValuePair[key] = value;
      return;
    }
    while (usages[leastUsedCache.first] != 1) {
      usages[leastUsedCache.first]--;
      leastUsedCache.removeFirst();
    }
    keyValuePair[leastUsedCache.first] = -1;
    usages[leastUsedCache.first]--;
    leastUsedCache.removeFirst();
    leastUsedCache.add(key);
    usages[key]++;
    keyValuePair[key] = value;
  }
}

class LRUCacheFAST {
  late int k;
  final Map<int, List<int>> mp = Map();
  final Queue<int> q = Queue<int>();

  LRUCacheFAST(int capacity) {
    k = capacity;
  }

  int get(int key) {
    if (mp.containsKey(key)) {
      mp[key]![1]++;
      q.add(key);
      return mp[key]![0];
    }
    return -1;
  }

  void put(int key, int value) {
    if (mp.containsKey(key)) {
      mp[key]![0] = value;
      mp[key]![1]++;
      q.add(key);
    } else {
      mp[key] = [value, 1];
      q.add(key);
    }

    // Check if capacity is exceeded.
    if (mp.length > k) {
      while (q.isNotEmpty) {
        int ky = q.removeFirst();
        // Decrement the frequency of ky.
        mp[ky]![1]--;
        // If no more key present in the queue, that means it is the least recently used.
        if (mp[ky]![1] == 0) {
          mp.remove(ky);
          break;
        }
      }
    }
  }
}

//

class Node {
  late final int key;
  late final int val;
  Node? prev = null;
  Node? next = null;

  Node(this.key, this.val);
}

class LRUCache {
  late int cap;
  final Map<int, Node> mp = {};

  final Node head = Node(-1, -1);
  final Node tail = Node(-1, -1);

  LRUCache(int capacity) {
    cap = capacity;
    head.next = tail;
    tail.prev = head;
  }

  void addNode(Node newNode) {
    Node? temp = head.next;
    newNode.next = temp;
    newNode.prev = head;
    head.next = newNode;
    temp?.prev = newNode;
  }

  void deleteNode(Node delNode) {
    Node? delPrev = delNode.prev;
    Node? delNext = delNode.next;
    delPrev?.next = delNext;
    delNext?.prev = delPrev;
  }

  int get(int key) {
    if (mp.containsKey(key)) {
      Node resNode = mp[key]!;
      int res = resNode.val;
      deleteNode(resNode);
      addNode(resNode);
      mp[key] = head.next!;
      return res;
    }
    return -1;
  }

  void put(int key, int value) {
    if (mp.containsKey(key)) {
      Node existingNode = mp[key]!;
      mp.remove(key);
      deleteNode(existingNode);
    }
    if (mp.length == cap) {
      mp.remove(tail.prev!.key);
      deleteNode(tail.prev!);
    }
    addNode(Node(key, value));
    mp[key] = head.next!;
  }
}
