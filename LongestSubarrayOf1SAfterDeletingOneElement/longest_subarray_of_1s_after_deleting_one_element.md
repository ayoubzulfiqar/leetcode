# 🔥 Union-Find 🔥 || Simple Fast and Easy || with Explanation 😈

The code provided aims to solve a problem of finding the length of the longest subarray with the maximum number of 1s, with the allowance of flipping at most one 0 to a 1.

Let's go through the code step by step and explain its functionality:

## DisjointSet Class

- The `DisjointSet` class represents the disjoint-set data structure.
- It has two instance variables: `parent` and `size`.
- The `parent` list maintains the parent of each element, and the `size` list stores the size of each set.
- The constructor `DisjointSet(int n)` initializes the `size` and `parent` lists with size `n+1` and sets each element's parent as itself.
- The `findParent(int node)` method implements the find operation of the disjoint-set data structure. It uses path compression optimization to flatten the tree structure and returns the parent of the given `node`.
- The `unionBySize(int u, int v)` method performs the union operation of the disjoint-set data structure. It finds the parents of `u` and `v`, and if they are different, it merges the smaller set into the larger set and updates the size accordingly.

## Solution Class

- The `Solution` class contains the `longestSubarray` method that takes a list of integers `nums` as input and returns the length of the longest subarray.
- It initializes the variable `s` as the sum of all elements in `nums`.
- If `s` is equal to the length of `nums`, it means all elements are 1, so it returns `s - 1` (since we can flip at most one 0 to a 1).
- If `s` is equal to 1 or 0, it means all elements are 0 or all elements are already 1, respectively, so it returns `s`.
- It creates an instance of the `DisjointSet` class called `ds` with the length of `nums`.
- It iterates through the `nums` list from index 0 to `n-1` and performs union operations for adjacent 1s in the `ds` disjoint set.
- It then iterates through the `nums` list from index 1 to `n-1` and checks for 0s to calculate the length of the longest subarray.
- Inside this loop, if the current element is 0, it calculates the sum of sizes of adjacent sets that contain 1s.
- It updates the `ans` variable with the maximum length of the subarray obtained so far.
- Finally, it compares `ans` with the size of the root set (representing the count of 1s without any 0 flips) and returns the maximum value between them.

### Time Complexity Analysis

The time complexity of the code is O(n), where n is the length of the input list `nums`. This complexity arises due to the two iterations over the `nums` list. Both iterations have linear time complexity.

### Space Complexity Analysis

The space complexity of the code is O(n). This is because the `DisjointSet` class uses two lists, `parent` and `size`, each with a length of `n+1`. Additionally, a few auxiliary variables are used, but their space requirements are negligible compared to the `DisjointSet` arrays.

In conclusion, the code utilizes the Union-Find (Disjoint-Set) algorithm to solve the problem efficiently. It has a time complexity of O(n) and a space complexity of O(n).

```dart
class DisjointSet {
  late List<int> parent;
  late List<int> size;

  DisjointSet(int n) {
    size = List<int>.filled(n + 1, 1);
    parent = List<int>.filled(n + 1, 0);

    for (int i = 0; i <= n; ++i) parent[i] = i;
  }

  int findParent(int node) {
    if (parent[node] == node) return node;
    return parent[node] = findParent(parent[node]);
  }

  void unionBySize(int u, int v) {
    int pU = findParent(u);
    int pV = findParent(v);

    if (pU == pV) return;

    if (size[pU] < size[pV]) {
      parent[pU] = pV;
      size[pV] += size[pU];
    } else {
      parent[pV] = pU;
      size[pU] += size[pV];
    }
  }
}

class Solution {
  int longestSubarray(List<int> nums) {
    final int n = nums.length;
    int s = 0;

    for (final int x in nums) s += x;
    if (s == n) return s - 1;
    if (s == 1 || s == 0) return s;

    final DisjointSet ds = DisjointSet(n);

    for (int i = 0; i < n - 1; ++i) {
      if (nums[i] == 1) {
        if (nums[i + 1] == 1) {
          if (ds.findParent(i) != ds.findParent(i + 1)) {
            ds.unionBySize(i, i + 1);
          }
        }
      }
    }

    int ans = 0;
    for (int i = 1; i < n - 1; ++i) {
      if (nums[i] == 0) {
        int tSum = 0;
        if (nums[i - 1] == 1) {
          tSum += ds.size[ds.parent[i - 1]];
        }
        if (nums[i + 1] == 1) {
          tSum += ds.size[ds.parent[i + 1]];
        }
        ans = tSum > ans ? tSum : ans;
      }
    }

    ans = ans > ds.size[0] ? ans : ds.size[0];
    return ans;
  }
}
```
