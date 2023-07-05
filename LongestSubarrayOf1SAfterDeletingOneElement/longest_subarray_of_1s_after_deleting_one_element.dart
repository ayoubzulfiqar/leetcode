/*



-* 1493. Longest Subarray of 1's After Deleting One Element *-


Given a binary array nums, you should delete one element from it.

Return the size of the longest non-empty subarray containing only 1's in the resulting array.
Return 0 if there is no such subarray.

 

Example 1:

Input: nums = [1,1,0,1]
Output: 3
Explanation: After deleting the number in position 2, [1,1,1] contains 3 numbers with value of 1's.
Example 2:

Input: nums = [0,1,1,1,0,1,1,0,1]
Output: 5
Explanation: After deleting the number in position 4, [0,1,1,1,1,1,0,1] longest subarray with value of 1's is [1,1,1,1,1].
Example 3:

Input: nums = [1,1,1]
Output: 2
Explanation: You must delete one element.
 

Constraints:

1 <= nums.length <= 105
nums[i] is either 0 or 1.



*/

import 'dart:math';

class A {
  int longestSubarray(List<int> nums) {
    final int n = nums.length;

    int left = 0;
    int zeros = 0;
    int ans = 0;

    for (int right = 0; right < n; right++) {
      if (nums[right] == 0) {
        zeros++;
      }
      while (zeros > 1) {
        if (nums[left] == 0) {
          zeros--;
        }
        left++;
      }
      ans = max(ans, right - left + 1 - zeros);
    }
    return (ans == n) ? ans - 1 : ans;
  }
}

//=========================Union Find============

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
