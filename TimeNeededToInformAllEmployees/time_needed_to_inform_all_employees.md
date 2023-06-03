# 🔥 Time Needed to Inform All Employees 🔥 || 3 Solutions || Simple Fast and Easy || with Explanation

## Solution - 1 - Depth First Search (DFS)

This code implements a depth-first search (DFS) algorithm to calculate the maximum time it takes for information to propagate from a given head employee to all other employees in a hierarchical organization structure.

The `numOfMinutes` function takes four parameters: `n` (the total number of employees), `headID` (the ID of the head employee), `manager` (a list that specifies the manager of each employee), and `informTime` (a list that specifies the time it takes for each employee to inform their subordinates).

### Explanation

1. It initializes a variable `result` to store the maximum time taken for information to propagate. Initially, it's set to 0.

2. The code then iterates over each employee from `0` to `n-1` using a `for` loop.

3. For each employee, it calls the `depthFirstSearch` function to calculate the time taken for information to propagate starting from that employee.

4. The `depthFirstSearch` function performs a recursive DFS. If the current employee has a manager (not equal to `-1`), it recursively calls `depthFirstSearch` with the manager's index as the parameter. It then adds the return value of the recursive call to the `informTime` of the current employee and updates the manager to `-1` to mark it as visited.

5. The `depthFirstSearch` function returns the updated `informTime` value for the current employee.

6. In the `numOfMinutes` function, the result of each call to `depthFirstSearch` is compared with the current `result`, and the larger value is assigned to `result`.

7. Finally, the `numOfMinutes` function returns the maximum time stored in `result`.

### - Time Complexity

The time complexity of this code is O(n^2), where n is the number of employees. This is because for each employee, there is potentially a recursive DFS call to its manager, resulting in a worst-case scenario of visiting all other employees. However, if the organization structure is balanced and tree-like, the time complexity can be reduced to O(n).

### - Space Complexity

The space complexity of this code is O(n) because it uses additional space to store the `manager` and `informTime` lists, and the recursion stack depth can be at most n for a linear organization structure.

```dart
class Solution {
  int numOfMinutes(int n, int headID, List<int> manager, List<int> informTime) {
    int result = 0;
    for (int i = 0; i < n; i++) {
      result = result > depthFirstSearch(i, informTime, manager)
          ? result
          : depthFirstSearch(i, informTime, manager);
    }
    return result;
  }

  int depthFirstSearch(int i, List<int> informTime, List<int> manager) {
    if (manager[i] != -1) {
      informTime[i] += depthFirstSearch(manager[i], informTime, manager);
      manager[i] = -1;
    }
    return informTime[i];
  }
}
```

## Solution - 2

This code defines a class `Pair` that represents a key-value pair, and a class `B` that contains the `numOfMinutes` method to calculate the maximum time it takes for information to propagate in a hierarchical organization structure.

### Explanation

1. The `Pair` class has two properties: `key` and `value`. It has a constructor that initializes the properties.

2. The `B` class contains the `numOfMinutes` method. It takes four parameters: `n` (total number of employees), `headID` (ID of the head employee), `manager` (a list representing the managers of each employee), and `informTime` (a list representing the time it takes for each employee to inform their subordinates).

3. It initializes an empty list `arr` with size `n`. This list will store the subordinates for each employee.

4. It iterates over each employee using a `for` loop. If an employee has a manager (manager[i] != -1), it adds the employee's index to the subordinates list of the respective manager in the `arr` list.

5. It creates a `Queue` of `Pair<int, int>` to perform a breadth-first search. The queue is initially populated with a `Pair` representing the head employee and the inform time for the head employee.

6. It initializes a variable `ans` to store the maximum time taken for information to propagate. Initially, it's set to 0.

7. It enters a `while` loop that continues until the queue is empty.

8. Inside the `while` loop, it retrieves the current size of the queue using `q.length` and stores it in the variable `si`.

9. It performs a nested `for` loop to process each element in the queue. The number of iterations is equal to the current size of the queue (`si`).

10. In each iteration, it removes the first element from the queue using `q.removeFirst()` and assigns it to the variable `t` of type `Pair<int, int>`. This represents the employee and the accumulated time taken for information propagation up to that point.

11. It iterates over the subordinates of the current employee stored in the `arr` list. For each subordinate, it checks if their inform time is 0. If so, it updates `ans` with the maximum value between `ans` and the accumulated time (`t.value`). Otherwise, it adds a new `Pair` to the queue representing the subordinate and the updated accumulated time (`t.value + informTime[x]`).

12. After processing all the elements in the queue, the loop continues until the queue becomes empty.

13. Finally, it returns the maximum time stored in `ans`.

### - Time Complexity

The time complexity of this code is O(n), where n is the number of employees. It performs a breadth-first search (BFS) to process each employee once. The number of iterations depends on the size of the queue, which is proportional to the number of employees in the worst case.

### - Space Complexity

The space complexity of this code is O(n). It uses additional space to store the `arr` list, which represents the hierarchical structure of the organization. The size of the `arr` list is proportional to the number of employees. The queue also contributes to the space complexity, but its size is limited to the number of employees in the worst case.

```dart
class Pair<K, V> {
  K key;
  V value;

  Pair(this.key, this.value);
}

class Solution {
  int numOfMinutes(int n, int headID, List<int> manager, List<int> informTime) {
    final List<List<int>> arr = List.generate(n, (index) => <int>[]);

    for (int i = 0; i < n; i++) {
      if (manager[i] != -1) {
        arr[manager[i]].add(i);
      }
    }

    Queue<Pair<int, int>> q = Queue();
    q.add(Pair(headID, informTime[headID]));
    int ans = 0;

    while (q.isNotEmpty) {
      int si = q.length;

      for (int i = 0; i < si; i++) {
        Pair<int, int> t = q.removeFirst();

        for (int x in arr[t.key]) {
          if (informTime[x] == 0) {
            ans = ans > t.value ? ans : t.value;
          } else {
            q.add(Pair(x, t.value + informTime[x]));
          }
        }
      }
    }

    return ans;
  }
}
```

## Solution - 3

```dart
class Stack<T> {
  List<T> _list = [];

  void push(T item) {
    _list.add(item);
  }

  T pop() {
    return _list.removeLast();
  }

  bool get isEmpty => _list.isEmpty;
  bool get isNotEmpty => _list.isNotEmpty;
}


class Solution {
  int numOfMinutes(int n, int headID, List<int> manager, List<int> informTime) {
    int maxTime = 0;

    // Create directed graph
    final List<List<int>> graph =
        List<List<int>>.generate(n, (index) => <int>[]);

    for (int i = 0; i < n; i++) {
      int parent = manager[i];
      final int child = i;
      if (parent != -1) {
        graph[parent].add(child);
      }
    }

    // DFS using explicit Stack (non-recursive solution)
    final List<int> arrTime = List<int>.filled(n, 0);

    final Stack<int> stack = Stack<int>();

    stack.push(headID);
    arrTime[headID] = 0;

    while (stack.isNotEmpty) {
      final int current = stack.pop();

      int currentTime = arrTime[current] + informTime[current];

      if (currentTime > maxTime) {
        maxTime = currentTime;
      }

      for (int i = 0; i < graph[current].length; i++) {
        int adj = graph[current][i];
        arrTime[adj] = currentTime;
        stack.push(adj);
      }
    }

    return maxTime;
  }
}
```
