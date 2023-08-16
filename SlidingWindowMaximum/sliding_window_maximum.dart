/*

-* 239. Sliding Window Maximum *-


You are given an array of integers nums, there is a sliding window of size k which is moving from the very left of the array to the very right. You can only see the k numbers in the window. Each time the sliding window moves right by one position.

Return the max sliding window.

 

Example 1:

Input: nums = [1,3,-1,-3,5,3,6,7], k = 3
Output: [3,3,5,5,6,7]
Explanation: 
Window position                Max
---------------               -----
[1  3  -1] -3  5  3  6  7       3
 1 [3  -1  -3] 5  3  6  7       3
 1  3 [-1  -3  5] 3  6  7       5
 1  3  -1 [-3  5  3] 6  7       5
 1  3  -1  -3 [5  3  6] 7       6
 1  3  -1  -3  5 [3  6  7]      7
Example 2:

Input: nums = [1], k = 1
Output: [1]
 

Constraints:

1 <= nums.length <= 105
-104 <= nums[i] <= 104
1 <= k <= nums.length
 


 */

class A {
  List<int> maxSlidingWindow(List<int> nums, int k) {
    return [];
  }
}

class Solution {
  late final List<List<int>> sp;
  late final List<int> log;

  List<int> maxSlidingWindow(List<int> arr, int k) {
    final int n = arr.length;
    sp = List.generate(n, (i) => List.filled(20, 0));
    log = List.filled(100005, 0);

    log[1] = 0;
    for (int i = 2; i <= n; i++) {
      log[i] = log[i ~/ 2] + 1;
    }

    for (int i = 0; i < n; i++) {
      sp[i][0] = arr[i];
    }

    preProcess(n);

    final List<int> ans = [];
    for (int i = 0; i <= n - k; i++) {
      int a = i, b = i + k - 1;
      final int mx = query(a, b);
      ans.add(mx);
    }

    return ans;
  }

  int query(int a, int b) {
    int len = b - a + 1;
    int j = log[len];
    int ans =
        sp[a][j] > sp[b - (1 << j) + 1][j] ? sp[a][j] : sp[b - (1 << j) + 1][j];
    return ans;
  }

  void preProcess(int n) {
    for (int j = 1; j < 18; j++) {
      for (int i = 0; i + (1 << j) - 1 < n; i++) {
        sp[i][j] = sp[i][j - 1] > sp[i + (1 << (j - 1))][j - 1]
            ? sp[i][j - 1]
            : sp[i + (1 << (j - 1))][j - 1];
      }
    }
  }
}
