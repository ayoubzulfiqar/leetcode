/* 

-* 1203. Sort Items by Groups Respecting Dependencies *-

There are n items each belonging to zero or one of m groups where group[i] is the group that the i-th item belongs to and it's equal to -1 if the i-th item belongs to no group. The items and the groups are zero indexed. A group can have no item belonging to it.

Return a sorted list of the items such that:

The items that belong to the same group are next to each other in the sorted list.
There are some relations between these items where beforeItems[i] is a list containing all the items that should come before the i-th item in the sorted array (to the left of the i-th item).
Return any solution if there is more than one solution and return an empty list if there is no solution.

 

Example 1:



Input: n = 8, m = 2, group = [-1,-1,1,0,0,1,0,-1], beforeItems = [[],[6],[5],[6],[3,6],[],[],[]]
Output: [6,3,4,1,5,2,0,7]
Example 2:

Input: n = 8, m = 2, group = [-1,-1,1,0,0,1,0,-1], beforeItems = [[],[6],[5],[6],[3],[],[4],[]]
Output: []
Explanation: This is the same as example 1 except that 4 needs to be before 6 in the sorted list.
 

Constraints:

1 <= m <= n <= 3 * 104
group.length == beforeItems.length == n
-1 <= group[i] <= m - 1
0 <= beforeItems[i].length <= n - 1
0 <= beforeItems[i][j] <= n - 1
i != beforeItems[i][j]
beforeItems[i] does not contain duplicates elements.

*/

// Wrong - I will make it correct soon
import 'dart:collection';

class A {
  List<int> sortItems(
      int n, int m, List<int> group, List<List<int>> beforeItems) {
    final List<int> emptyList = <int>[];
    List<int> result = List<int>.filled(n, 0);
    int resultIdx = 0;

    if (n == 1) return [0];

    for (int groupIdx = 0; groupIdx < group.length; groupIdx++) {
      if (group[groupIdx] < 0) {
        group[groupIdx] = m++;
      }
    }

    final List<List<int>> groupTos = List.generate(m, (_) => <int>[]);
    final List<List<int>> groupItems = List.generate(m, (_) => <int>[]);
    final List<int> groupInternalItemLinkCount = List<int>.filled(m, 0);
    final List<int> groupFromCounts = List<int>.filled(m, 0);

    final List<List<int>> itemTos = List.generate(n, (_) => <int>[]);
    final List<int> itemFromCounts = List<int>.filled(n, 0);

    int itemIdx = 0;
    int beforeCount = 0;
    for (List<int> before in beforeItems) {
      final int itemGroupNum = group[itemIdx];
      groupItems[itemGroupNum].add(itemIdx);
      beforeCount += before.length;
      for (int before in before) {
        int beforeGroupNum = group[before];
        if (itemGroupNum == beforeGroupNum) {
          groupInternalItemLinkCount[itemGroupNum]++;
          itemTos[before].add(itemIdx);
          itemFromCounts[itemIdx]++;
        } else {
          groupTos[beforeGroupNum].add(itemGroupNum);
          groupFromCounts[itemGroupNum]++;
        }
      }
      itemIdx++;
    }

    if (beforeCount == 0) {
      for (int i = 0; i < n; i++) result[i] = i;
      return result;
    }

    List<int> groupResult = List<int>.filled(m, 0);
    int groupResultIdx = 0;
    final List<int> indyGroups = <int>[];
    int indyGroupsInnIdx = 0;
    int indyGroupsOutIdx = 0;
    for (int i = 0; i < m; i++) {
      if (groupFromCounts[i] == 0) {
        indyGroups.add(i);
        indyGroupsOutIdx++;
      }
    }

    while (indyGroupsInnIdx < indyGroupsOutIdx) {
      final int grp = indyGroups[indyGroupsInnIdx++];
      groupResult[groupResultIdx++] = grp;
      for (int grpTo in groupTos[grp]) {
        if (--groupFromCounts[grpTo] == 0) {
          indyGroups.add(grpTo);
          indyGroupsOutIdx++;
        }
      }
    }

    if (groupResultIdx != m) return emptyList;

    final List<int> indyItems = <int>[];
    for (groupResultIdx = 0; groupResultIdx < m; groupResultIdx++) {
      int grp = groupResult[groupResultIdx];
      if (groupInternalItemLinkCount[grp] == 0) {
        for (int itm in groupItems[grp]) result[resultIdx++] = itm;
      } else {
        int indyItemsInnIdx = 0;
        int indyItemsOutIdx = 0;
        int startResultIdx = resultIdx;
        for (int itm in groupItems[grp]) {
          if (itemFromCounts[itm] == 0) {
            indyItems.add(itm);
            indyItemsOutIdx++;
          }
        }
        while (indyItemsInnIdx < indyItemsOutIdx) {
          int itm = indyItems[indyItemsInnIdx++];
          result[resultIdx++] = itm;
          for (int itmTo in itemTos[itm]) {
            if (--itemFromCounts[itmTo] == 0) {
              indyItems.add(itmTo);
              indyItemsOutIdx++;
            }
          }
        }
        if (resultIdx - startResultIdx != groupItems[grp].length)
          return emptyList;
      }
    }

    return result;
  }
}

// TopoSort with DFS

class B {
  List<int> ret = <int>[];
  List<int> group = <int>[];
  List<List<int>> beforeItems = <int>[].map((e) => <int>[]).toList();
  int cnt = 0;
  List<List<int>> groups = <int>[].map((e) => <int>[]).toList();
  List<bool> checked = <bool>[];
  List<bool> preparing = <bool>[];
  bool cycle = false;

  List<int> sortItems(
      int n, int m, List<int> group, List<List<int>> beforeItems) {
    // Assign and initialize variables
    groups = List.generate(m, (_) => <int>[]);
    ret = List.filled(n, 0);
    checked = List.filled(n, false);
    preparing = List.filled(n, false);
    this.group = group;
    this.beforeItems = beforeItems;

    for (int i = 0; i < m; i++) {
      groups[i] = <int>[];
    }

    // Group items by their group[i]
    for (int i = 0; i < n; i++) {
      if (group[i] != -1) groups[group[i]].add(i);
    }

    // Iterate and prepare all items
    for (int i = 0; i < n; i++) {
      if (!checked[i]) prepare(i, true);
    }

    return cycle ? <int>[] : ret;
  }

  void prepare(int i, bool passOn) {
    if (preparing[i] || cycle) {
      // Detecting cycle
      cycle = true;
      return;
    }
    preparing[i] = true;

    if (group[i] == -1) {
      // i belongs to no group
      for (int item in beforeItems[i]) {
        if (!checked[item]) prepare(item, true);
      }
      checked[i] = true;
      ret[cnt++] = i;
    } else {
      // Prepare for other items in the same group
      for (int item in groups[group[i]]) {
        if (item == i) continue;
        for (int beforeItem in beforeItems[item]) {
          if (group[beforeItem] != group[item] && !checked[beforeItem]) {
            prepare(beforeItem, true);
          }
        }
      }

      // Prepare and add i
      for (int item in beforeItems[i]) {
        if (!checked[item]) prepare(item, group[item] != group[i]);
      }
      checked[i] = true;
      ret[cnt++] = i;

      // Iterate over the whole group only the first time
      if (passOn) {
        for (int item in groups[group[i]]) {
          if (!preparing[item]) prepare(item, false);
        }
      }
    }
  }
}

// Kahn's Topo Algo
class Solution {
  List<int> topoSort(List<List<int>> adj, List<int> deg, int sz) {
    // Kahn's algorithm
    final Queue<int> q = Queue<int>();
    for (int i = 0; i < sz; i++) {
      if (deg[i] == 0) q.add(i);
    }
    final List<int> res = <int>[];
    while (q.isNotEmpty) {
      final int x = q.removeFirst();
      res.add(x);
      for (int y in adj[x]) {
        deg[y]--;
        if (deg[y] == 0) q.add(y);
      }
    }
    for (int i = 0; i < sz; i++) {
      if (deg[i] > 0) return <int>[];
    }
    return res;
  }

  List<int> sortItems(
      int n, int m, List<int> group, List<List<int>> beforeItems) {
    // isolated item is a group by itself
    for (int i = 0; i < n; i++) {
      if (group[i] == -1) group[i] = m++;
    }
    final List<List<int>> adjGroup = List.generate(m, (_) => <int>[]);
    final List<List<int>> adjItem = List.generate(n, (_) => <int>[]);
    final List<int> degGroup = List<int>.filled(m, 0);
    final List<int> degItem = List<int>.filled(n, 0);

    for (int i = 0; i < n; i++) {
      final int toI = group[i];
      for (int from in beforeItems[i]) {
        final int fromJ = group[from];
        if (toI != fromJ) {
          adjGroup[fromJ].add(toI);
          degGroup[toI]++;
        }
        adjItem[from].add(i);
        degItem[i]++;
      }
    }

    final List<int> sortGroup = topoSort(adjGroup, degGroup, m);
    final List<int> sortItem = topoSort(adjItem, degItem, n);
    if (sortGroup.isEmpty || sortItem.isEmpty) return [];

    List<List<int>> itemGroup = List.generate(m, (_) => <int>[]);
    for (int i in sortItem) {
      itemGroup[group[i]].add(i);
    }

    List<int> ans = <int>[];
    for (int i in sortGroup) {
      ans.addAll(itemGroup[i]);
    }

    return ans;
  }
}
