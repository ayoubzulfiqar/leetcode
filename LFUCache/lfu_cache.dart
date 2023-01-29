/*


-* 460. LFU Cache*-


Design and implement a data structure for a Least Frequently Used (LFU) cache.

Implement the LFUCache class:

LFUCache(int capacity) Initializes the object with the capacity of the data structure.
int get(int key) Gets the value of the key if the key exists in the cache. Otherwise, returns -1.
void put(int key, int value) Update the value of the key if present, or inserts the key if not already present. When the cache reaches its capacity, it should invalidate and remove the least frequently used key before inserting a new item. For this problem, when there is a tie (i.e., two or more keys with the same frequency), the least recently used key would be invalidated.
To determine the least frequently used key, a use counter is maintained for each key in the cache. The key with the smallest use counter is the least frequently used key.

When a key is first inserted into the cache, its use counter is set to 1 (due to the put operation). The use counter for a key in the cache is incremented either a get or put operation is called on it.

The functions get and put must each run in O(1) average time complexity.

 

Example 1:

Input
["LFUCache", "put", "put", "get", "put", "get", "get", "put", "get", "get", "get"]
[[2], [1, 1], [2, 2], [1], [3, 3], [2], [3], [4, 4], [1], [3], [4]]
Output
[null, null, null, 1, null, -1, 3, null, -1, 3, 4]

Explanation
// cnt(x) = the use counter for key x
// cache=[] will show the last used order for tiebreakers (leftmost element is  most recent)
LFUCache lfu = new LFUCache(2);
lfu.put(1, 1);   // cache=[1,_], cnt(1)=1
lfu.put(2, 2);   // cache=[2,1], cnt(2)=1, cnt(1)=1
lfu.get(1);      // return 1
                 // cache=[1,2], cnt(2)=1, cnt(1)=2
lfu.put(3, 3);   // 2 is the LFU key because cnt(2)=1 is the smallest, invalidate 2.
                 // cache=[3,1], cnt(3)=1, cnt(1)=2
lfu.get(2);      // return -1 (not found)
lfu.get(3);      // return 3
                 // cache=[3,1], cnt(3)=2, cnt(1)=2
lfu.put(4, 4);   // Both 1 and 3 have the same cnt, but 1 is LRU, invalidate 1.
                 // cache=[4,3], cnt(4)=1, cnt(3)=2
lfu.get(1);      // return -1 (not found)
lfu.get(3);      // return 3
                 // cache=[3,4], cnt(4)=1, cnt(3)=3
lfu.get(4);      // return 4
                 // cache=[4,3], cnt(4)=2, cnt(3)=3
 

Constraints:

0 <= capacity <= 104
0 <= key <= 105
0 <= value <= 109
At most 2 * 105 calls will be made to get and put.Design and implement a data structure for a Least Frequently Used (LFU) cache.

Implement the LFUCache class:

LFUCache(int capacity) Initializes the object with the capacity of the data structure.
int get(int key) Gets the value of the key if the key exists in the cache. Otherwise, returns -1.
void put(int key, int value) Update the value of the key if present, or inserts the key if not already present. When the cache reaches its capacity, it should invalidate and remove the least frequently used key before inserting a new item. For this problem, when there is a tie (i.e., two or more keys with the same frequency), the least recently used key would be invalidated.
To determine the least frequently used key, a use counter is maintained for each key in the cache. The key with the smallest use counter is the least frequently used key.

When a key is first inserted into the cache, its use counter is set to 1 (due to the put operation). The use counter for a key in the cache is incremented either a get or put operation is called on it.

The functions get and put must each run in O(1) average time complexity.

 

Example 1:

Input
["LFUCache", "put", "put", "get", "put", "get", "get", "put", "get", "get", "get"]
[[2], [1, 1], [2, 2], [1], [3, 3], [2], [3], [4, 4], [1], [3], [4]]
Output
[null, null, null, 1, null, -1, 3, null, -1, 3, 4]

Explanation
// cnt(x) = the use counter for key x
// cache=[] will show the last used order for tiebreakers (leftmost element is  most recent)
LFUCache lfu = new LFUCache(2);
lfu.put(1, 1);   // cache=[1,_], cnt(1)=1
lfu.put(2, 2);   // cache=[2,1], cnt(2)=1, cnt(1)=1
lfu.get(1);      // return 1
                 // cache=[1,2], cnt(2)=1, cnt(1)=2
lfu.put(3, 3);   // 2 is the LFU key because cnt(2)=1 is the smallest, invalidate 2.
                 // cache=[3,1], cnt(3)=1, cnt(1)=2
lfu.get(2);      // return -1 (not found)
lfu.get(3);      // return 3
                 // cache=[3,1], cnt(3)=2, cnt(1)=2
lfu.put(4, 4);   // Both 1 and 3 have the same cnt, but 1 is LRU, invalidate 1.
                 // cache=[4,3], cnt(4)=1, cnt(3)=2
lfu.get(1);      // return -1 (not found)
lfu.get(3);      // return 3
                 // cache=[3,4], cnt(4)=1, cnt(3)=3
lfu.get(4);      // return 4
                 // cache=[4,3], cnt(4)=2, cnt(3)=3
 

Constraints:

0 <= capacity <= 104
0 <= key <= 105
0 <= value <= 109
At most 2 * 105 calls will be made to get and put.

*/

/*


class LFUCache {

  LFUCache(int capacity) {

  }
  
  int get(int key) {

  }
  
  void put(int key, int value) {

  }
}


*/

// class LFUCache {
//   late int capacity;
//   int minFreq = 0;
//   HashMap<int, int> keyToVal = HashMap();
//   HashMap<int, int> keyToFreq = HashMap();
//   HashMap<int, LinkedHashSet<int>> freqToLRUKeys = HashMap();
//   LFUCache(int capacity) {
//     this.capacity = capacity;
//   }

//   int get(int key) {
//     if (!keyToVal.containsKey(key)) return -1;

//     final int freq = keyToFreq[key] ?? 0;
//     freqToLRUKeys[freq]?.remove(key);
//     if (freq == minFreq && freqToLRUKeys[freq]!.isEmpty) {
//       freqToLRUKeys.remove(freq);
//       ++minFreq;
//     }

//     // Increase key's freq by 1
//     // Add this key to next freq's list
//     putFreq(key, freq + 1);
//     return keyToVal[key] ?? 0;
//   }

//   void put(int key, int value) {
//     if (capacity == 0) return;
//     if (keyToVal.containsKey(key)) {
//       keyToVal[key] = value;
//       get(key); // Update key's count
//       return;
//     }

//     if (keyToVal.length == capacity) {
//       // Evict LRU key from the minFreq list
//       final int keyToEvict = freqToLRUKeys[minFreq]...iterator.current;
//       freqToLRUKeys[minFreq]?.remove(keyToEvict);
//       keyToVal.remove(keyToEvict);
//     }

//     minFreq = 1;
//     putFreq(key, minFreq); // Add new key and freq
//     keyToVal[key] = value; // Add new key and value
//   }

//   void putFreq(int key, int freq) {
//     keyToFreq[key] = freq;
//     freqToLRUKeys.putIfAbsent(freq, () => LinkedHashSet());
//     freqToLRUKeys[freq]?.add(key);
//   }
// }

// import 'dart:collection';

// class Node {
//   late int key;
//   late int val;
//   late Node next;
//   late Node prev;
//   int freq = 1;
//   Node(int k, int v) {
//     key = k;
//     val = v;
//   }
// }

// class DoublyLinkedList {
//   late Node head;
//   late Node tail;
//   DoublyLinkedList() {
//     head = Node(-1, -1);
//     tail = Node(-1, -1);
//     head.next = tail;
//     tail.prev = head;
//   }
//   void addNode(Node v) {
//     Node next = head.next;
//     head.next = v;
//     v.prev = head;
//     head.next = v;
//     v.next = next;
//     next.prev = v;
//   }

//   Node removeNode() {
//     Node node = tail.prev;
//     node.prev.next = tail;
//     tail.prev = node.prev;
//     return node;
//   }

//   Node removeNodeAt(Node v) {
//     Node prev = v.prev;
//     Node next = v.next;
//     prev.next = next;
//     next.prev = prev;
//     return v;
//   }

//   bool isEmpty() {
//     if (head.next == tail) return true;
//     return false;
//   }
// }

// class LFUCache {
//   HashMap<int, DoublyLinkedList> freqList = HashMap<int, DoublyLinkedList>();
//   HashMap<int, Node> lfuCache = HashMap<int, Node>();
//   late int capacity;
//   late int minFreq;
//   LFUCache(int capacity) {
//     this.capacity = capacity;
//     minFreq = 1;
//   }

//   int get(int key) {
//     if (lfuCache[key] == null) return -1;
//     Node v = lfuCache[key] ?? 0 as Node;
//     freqList[v.freq]?.removeNodeAt(v);
//     if (freqList[v.freq]!.isEmpty()) {
//       if (minFreq == v.freq) {
//         minFreq = v.freq + 1;
//       }
//     }
//     v.freq += 1;
//     if (freqList[v.freq] == null) {
//       DoublyLinkedList d = new DoublyLinkedList();
//       d.addNode(v);
//       freqList[v.freq] = d;
//     } else {
//       freqList[v.freq]?.addNode(v);
//     }
//     return v.val;
//   }

//   void put(int key, int value) {
//     if (capacity == 0) return;
//     if (lfuCache[key] != null) {
//       Node v = lfuCache[key] ?? 0 as Node;
//       freqList[v.freq]?.removeNodeAt(v);
//       if (freqList[v.freq]!.isEmpty()) {
//         if (minFreq == v.freq) minFreq = v.freq + 1;
//       }
//       v.freq += 1;
//       if (freqList[v.freq] == null) {
//         DoublyLinkedList d = new DoublyLinkedList();
//         d.addNode(v);
//         freqList[v.freq] = d;
//       } else {
//         freqList[v.freq]?.addNode(v);
//       }
//       v.val = value;
//     } else {
//       if (lfuCache.length == capacity) {
//         Node v = freqList[minFreq]!.removeNode();
//         lfuCache.remove(v.key);
//       }
//       Node newNode = new Node(key, value);
//       lfuCache[key] = newNode;
//       if (freqList[1] != null) {
//         freqList[1]?.addNode(newNode);
//       } else {
//         DoublyLinkedList d = new DoublyLinkedList();
//         d.addNode(newNode);
//         freqList[1] = d;
//       }
//       minFreq = 1;
//     }
//   }
// }

