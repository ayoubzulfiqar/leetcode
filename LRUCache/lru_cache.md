# 🔥 FASTEST LRU Cache 🔥 || Simple Fast and Easy || with Explanation 😈

## **Intuition and Approach:**

This code implements an LRUCache (Least Recently Used Cache) using a combination of a `Map` and a `Queue`. The LRUCache is designed to store key-value pairs with a fixed capacity. When the capacity is exceeded, the least recently used (LRU) key-value pair is evicted from the cache.

## **Explanation:**

1. The `LRUCache` class contains the following data members:
   - `k`: An integer representing the capacity of the cache.
   - `mp`: A `Map` that stores key-value pairs. The key is an integer representing the key, and the value is a list of two integers: the actual value and the frequency of usage.
   - `q`: A `Queue` that keeps track of the order of keys based on their usage. The front of the queue represents the least recently used key, and the rear represents the most recently used key.

2. The `LRUCache` constructor initializes the capacity `k`.

3. The `get` method is used to retrieve the value associated with a given key from the cache. If the key exists, its frequency of usage is incremented, and the key is moved to the rear of the queue (indicating it was recently used). The value associated with the key is returned; otherwise, -1 is returned if the key does not exist in the cache.

4. The `put` method is used to add a new key-value pair to the cache. If the key already exists, its value is updated, the frequency of usage is incremented, and the key is moved to the rear of the queue (indicating it was recently used). If the key is not present in the cache, a new key-value pair is created, added to the `Map`, and the key is added to the rear of the queue. If the cache capacity is exceeded after inserting the new key-value pair, the least recently used key-value pair (front of the queue) is evicted from the cache.

## **Space Complexity:**

- The space complexity of the LRUCache is O(k), where k is the capacity of the cache. This is because the `Map` (`mp`) and `Queue` (`q`) store a maximum of k elements.

## **Time Complexity:**

- The time complexity of the `get` method is O(1) as it involves simple lookups and queue operations.
- The time complexity of the `put` method is also O(1) on average. The worst-case time complexity occurs when the cache reaches its capacity and the least recently used key-value pair needs to be evicted. In this case, a while loop iterates through the `Queue` to find and remove the LRU element. However, since each element can be evicted at most once, the overall amortized time complexity remains constant for the `put` method.

```dart

class LRUCache {
  late int k;
  final Map<int, List<int>> mp = Map();
  final Queue<int> q = Queue<int>();

  LRUCache(int capacity) {
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
```

## Using Array But Not Recommended - (More Memory Consumption and Not Very Fast)

```dart
import 'dart:collection';

class LRUCache {
  final Queue<int> leastUsedCache = Queue<int>();
  final List<int> usages = List<int>.filled(10001, 0);
  final List<int> keyValuePair = List<int>.filled(10001, -1);
  int size = 0;
  int cap = 0;

  LRUCache(int capacity) {
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
```

## DoublyLinked List

**Intuition and Approach:**

This code implements an LRUCache (Least Recently Used Cache) using a combination of a `Map` and a linked list of `Node` objects. The LRUCache is designed to store key-value pairs with a fixed capacity. When the capacity is exceeded, the least recently used (LRU) key-value pair is evicted from the cache.

### **Explanation:**

1. The `Node` class represents individual nodes in a doubly linked list, each holding a `key` and a `val` (value) representing the key-value pair.

2. The `LRUCache` class contains the following data members:
   - `cap`: An integer representing the capacity of the cache.
   - `mp`: A `Map` that stores key-value pairs, where the key is an integer representing the key, and the value is a `Node` representing the key-value pair stored in the linked list.
   - `head`: The dummy `Node` that acts as the head of the doubly linked list.
   - `tail`: The dummy `Node` that acts as the tail of the doubly linked list.

3. The `LRUCache` constructor initializes the capacity `cap`, and sets up the dummy head and tail nodes of the doubly linked list.

4. The `addNode` method adds a new `Node` to the front (after the dummy head) of the doubly linked list.

5. The `deleteNode` method removes a given `Node` from the doubly linked list.

6. The `get` method is used to retrieve the value associated with a given key from the cache. If the key exists, its corresponding `Node` is moved to the front of the doubly linked list (indicating it was recently used), and its value is returned. If the key does not exist in the cache, -1 is returned.

7. The `put` method is used to add a new key-value pair to the cache. If the key already exists, its corresponding `Node` is removed from the cache, and the new key-value pair is added as a new `Node` to the front of the doubly linked list. If the cache capacity is exceeded after inserting the new key-value pair, the least recently used key-value pair (the `tail.prev`) is evicted from the cache.

### **Space Complexity:**

- The space complexity of the LRUCache is O(cap), where `cap` is the capacity of the cache. This is because the `Map` (`mp`) stores at most `cap` key-value pairs, and the doubly linked list stores at most `cap` `Node` objects.

### **Time Complexity:**

- The time complexity of the `get` method is O(1) as it involves simple map lookups and linked list operations.
- The time complexity of the `put` method is O(1) on average. The worst-case time complexity occurs when the cache reaches its capacity, and the least recently used key-value pair needs to be evicted. In this case, the `mp.remove` and `deleteNode` operations take constant time, and thus, the overall amortized time complexity remains constant for the `put` method.

```dart

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
```
