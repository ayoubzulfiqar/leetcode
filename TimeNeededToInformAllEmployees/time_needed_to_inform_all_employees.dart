/*

-* 1376. Time Needed to Inform All Employees *-

A company has n employees with a unique ID for each employee from 0 to n - 1. The head of the company is the one with headID.

Each employee has one direct manager given in the manager array where manager[i] is the direct manager of the i-th employee, manager[headID] = -1. Also, it is guaranteed that the subordination relationships have a tree structure.

The head of the company wants to inform all the company employees of an urgent piece of news. He will inform his direct subordinates, and they will inform their subordinates, and so on until all employees know about the urgent news.

The i-th employee needs informTime[i] minutes to inform all of his direct subordinates (i.e., After informTime[i] minutes, all his direct subordinates can start spreading the news).

Return the number of minutes needed to inform all the employees about the urgent news.

 

Example 1:

Input: n = 1, headID = 0, manager = [-1], informTime = [0]
Output: 0
Explanation: The head of the company is the only employee in the company.
Example 2:


Input: n = 6, headID = 2, manager = [2,2,-1,2,2,2], informTime = [0,0,1,0,0,0]
Output: 1
Explanation: The head of the company with id = 2 is the direct manager of all the employees in the company and needs 1 minute to inform them all.
The tree structure of the employees in the company is shown.
 

Constraints:

1 <= n <= 105
0 <= headID < n
manager.length == n
0 <= manager[i] < n
manager[headID] == -1
informTime.length == n
0 <= informTime[i] <= 1000
informTime[i] == 0 if employee i has no subordinates.
It is guaranteed that all the employees can be informed.

*/
import 'dart:collection';

class A {
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

class Pair<K, V> {
  K key;
  V value;

  Pair(this.key, this.value);
}

class B {
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

class C {
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
