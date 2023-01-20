# 🔥 100% Fast 🔥 || Simple Fast and Easy || with Explanation

## Solution - 1 Depth first Search

### Approach

Backtracking using HashSet

### Complexity

#### - Time complexity : O(n.2^n)

#### - Space complexity : O(n^2)

```dart
class Solution {
  List<List<int>> findSubsequences(List<int> nums) {
    List<List<int>> ans = [];
    // use a List to store the unique sub sequences
    dfs(nums, 0, <int>[], ans);
    return ans;
  }

  void dfs(List<int> nums, int s, List<int> path, List<List<int>> ans) {
    if (path.length > 1) ans.add(path.toList());

    HashSet<int> used = HashSet();

    for (int i = s; i < nums.length; ++i) {
      if (used.contains(nums[i])) continue;
      // if the path is empty or the current element is greater than or equal to the last element in the path
      if (path.isEmpty || nums[i] >= path.last) {
        // add the current element to the used and recursively call dfs
        used.add(nums[i]);
        path.add(nums[i]);
        // recursively call dfs without adding the current element to the path
        dfs(nums, i + 1, path, ans);
        path.removeLast(); // remove the last element from the path before returning
      }
    }
  }
}
```
