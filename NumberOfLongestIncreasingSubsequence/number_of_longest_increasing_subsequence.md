# 🔥 Dart 🔥 || Simple Fast and Easy || with Explanation 😈

### Code Explanation:

The given code is a C++ solution to find the number of Longest Increasing Subsequences (LIS) in a given array of integers `nums`.

1. The function `findNumberOfLIS` takes a reference to a vector of integers `nums` as input and returns an integer as the output.

2. It initializes an empty vector of pairs named `lisFQ` to keep track of the length of LIS and the number of LIS that can be formed ending at each index of `nums`.

3. It sets the first element of `lisFQ` as {1, 1}, indicating that at the first index of `nums`, there is one LIS with a length of 1.

4. The function then iterates through the array `nums`, starting from the second element.

5. For each element `nums[i]`, it searches for all elements before it to find the longest increasing subsequence that ends at `nums[i]`. It also counts the number of such subsequences.

6. It updates the `lisFQ[i]` with the length of the LIS ending at `nums[i]` and the count of such subsequences.

7. It also keeps track of the maximum length of the LIS seen so far, stored in the variable `lo`.

8. Finally, it iterates through `lisFQ` to find all the subsequences that have the length equal to `lo` and returns their count as the final result.

### Intuition and Approach:

The code aims to find the number of Longest Increasing Subsequences (LIS) in the given array of integers `nums`.

The approach uses dynamic programming to keep track of the length of LIS and the count of LIS ending at each index of `nums`. For each element in the array, it searches for the longest increasing subsequence ending at that element and updates the corresponding values in the `lisFQ` vector. The final step is to find all subsequences that have the length equal to the maximum length seen so far (`lo`) and return their count as the result.

### Time and Space Complexity Analysis:

- Time Complexity: The code uses a nested loop to find the LIS and update the `lisFQ` vector. Therefore, the time complexity is O(n^2), where n is the size of the input array `nums`.

- Space Complexity: The code uses an additional vector `lisFQ` to store the length of LIS and their counts, which requires O(n) space. Thus, the space complexity is O(n).

In summary, the code finds the number of Longest Increasing Subsequences (LIS) in the given array `nums` using dynamic programming with a time complexity of O(n^2) and a space complexity of O(n).

```dart

class Pair {
  final int first;
  final int second;

  const Pair(this.first, this.second);
}

class Solution {
  int findNumberOfLIS(List<int> nums) {
    final int n = nums.length;
    final List<Pair> lisFQ = List.filled(n, Pair(0, 0));
    lisFQ[0] = Pair(1, 1);
    int lo = 1;

    for (int i = 1; i < nums.length; i++) {
      int mx = 0;
      int c = 1;

      for (int j = 0; j < i; j++) {
        if (nums[j] < nums[i]) {
          if (lisFQ[j].first > mx) {
            mx = lisFQ[j].first;
            c = lisFQ[j].second;
          } else if (lisFQ[j].first == mx) {
            c += lisFQ[j].second;
          }
        }
      }

      lisFQ[i] = Pair(mx + 1, c);

      if (lo < lisFQ[i].first) {
        lo = lisFQ[i].first;
      }
    }

    int count = 0;

    for (int i = 0; i < nums.length; i++) {
      if (lisFQ[i].first == lo) {
        count += lisFQ[i].second;
      }
    }

    return count;
  }
}
```


## Recursion with Memo

```dart

class Solution {
  int findNumberOfLIS(List<int> nums) {
   final List<List<int>> cache =
        List.generate(nums.length, (index) => List<int>.filled(2, 0));
    int max = 0;
    int number = 0;
    for (int i = 0; i < nums.length; i++) {
     final List<int> pair = findSequence(nums, cache, i);
      if (pair[0] + 1 > max) {
        max = pair[0] + 1;
        number = pair[1];
      } else if (pair[0] + 1 == max) {
        number += pair[1];
      }
    }
    return number;
  }

  List<int> findSequence(List<int> nums, List<List<int>> cache, int index) {
    if (index == nums.length) return [0, 0];
    if (cache[index][0] != 0) return List.from(cache[index]);

    int max = 1;
    int numLIS = 1;
    List<int> pair = [0, 0]; // [LIS, num_LIS]
    for (int i = index + 1; i < nums.length; i++) {
      if (nums[i] > nums[index]) {
        pair = findSequence(nums, cache, i);
        // pair now has the result of LIS and number of times LIS occurred
        // we need to combine the subproblem values.
        if (pair[0] + 1 > max) {
          max = pair[0] + 1;
          numLIS = pair[1];
        } else if (pair[0] + 1 == max) {
          numLIS += pair[1];
        }
      }
    }

    cache[index] = [max, numLIS];
    return List.from(cache[index]);
  }
}
```
