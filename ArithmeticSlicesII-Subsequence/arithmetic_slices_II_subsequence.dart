/*

446. Arithmetic Slices II - Subsequence



Given an integer array numbers, return the numberber of all the arithmetic subsequences of numbers.

A sequence of numberbers is called arithmetic if it consists of at least three elements and if the difference between any two consecutive elements is the same.

For example, [1, 3, 5, 7, 9], [7, 7, 7, 7], and [3, -1, -5, -9] are arithmetic sequences.
For example, [1, 1, 2, 5, 7] is not an arithmetic sequence.
A subsequence of an array is a sequence that can be formed by removing some elements (possibly none) of the array.

For example, [2,5,10] is a subsequence of [1,2,1,2,4,1,5,10].
The test cases are generated so that the answer fits in 32-bit integer.

 

Example 1:

Input: numbers = [2,4,6,8,10]
Output: 7
Explanation: All arithmetic subsequence slices are:
[2,4,6]
[4,6,8]
[6,8,10]
[2,4,6,8]
[4,6,8,10]
[2,4,6,8,10]
[2,6,10]
Example 2:

Input: numbers = [7,7,7,7,7]
Output: 16
Explanation: Any subsequence of this array is arithmetic.
 

Constraints:

1  <= numbers.length <= 1000
-231 <= numbers[i] <= 231 - 1

*/

import 'dart:collection';
import 'dart:math';

class A {
  // one case fail
  HashMap<String, int> cache = HashMap();
  int numberOfArithmeticSlices(List<int> numbers) {
    HashMap<int, List<int>> map = HashMap();
    for (int i = 0; i < numbers.length; i++) {
      List<int> list = map[numbers[i]] ?? [];
      list.add(i);
      map[numbers[i]] = list;
    }
    int ans = 0;
    for (int i = 0; i < numbers.length; i++) {
      for (int j = i + 1; j < numbers.length; j++) {
        int diff = numbers[j] - numbers[i];
        ans += count(map, diff, j, numbers[j]);
      }
    }
    return ans;
  }

  int count(HashMap<int, List<int>> map, int diff, int j, int start) {
    int next = start + diff;
    if (!map.containsKey(next)) {
      return 0;
    }
    int key = j + "-".codeUnitAt(0) + start + "-".codeUnitAt(0) + diff;
    if (cache.containsKey(key)) {
      return cache[key]!;
    }
    List<int> pos = map[next] ?? [];
    int l = 0;
    int r = pos.length;
    while (l < r) {
      int mid = l + (r - l) ~/ 2;
      if (pos[mid] <= j) {
        l = mid + 1;
      } else {
        r = mid;
      }
    }
    int k = 0;
    for (int i = l; i < pos.length; i++) {
      k += count(map, diff, pos[i], next) + 1;
    }
    cache[key.toString()] = k;
    return k;
  }
}

class B {
  int numberOfArithmeticSlices(List<int> numbers) {
    final int n = numbers.length;
    int ans = 0;
    List<List<int>> dp =
        List.filled(n, 0).map((e) => List.filled(n, 0)).toList();
    HashMap<int, List<int>> numberToIndices = HashMap();

    for (int i = 0; i < n; ++i) {
      numberToIndices.putIfAbsent(numbers[i], () => []);
      numberToIndices[numbers[i]]!.add(i);
    }

    for (int i = 0; i < n; ++i)
      for (int j = 0; j < i; ++j) {
        final int target = numbers[j] * 2 - numbers[i];
        if (numberToIndices.containsKey(target))
          for (final int k in numberToIndices[target] as Iterable)
            if (k < j) dp[i][j] += (dp[j][k] + 1);
        ans += dp[i][j];
      }

    return ans;
  }
}

class C {
  int f(List<int> nums, int index, int curr, int prev, double dif) {
    int nr = 0;
    if (curr >= 3) {
      nr = 1; //if the current sequence has at least 3 elements, we count it
    }
    for (int i = index; i < nums.length; i++) {
      //check all posible numbers that could be included in the sequence
      double x = nums[i] - prev.toDouble();
      if (x == dif) {
        //"add" the number in the sequence
        nr = nr + f(nums, i + 1, curr + 1, nums[i], dif);
      }
    }
    return nr;
  }

  int numberOfArithmeticSlices(List<int> nums) {
    if (nums.length < 3) {
      return 0;
    }
    bool ok = true;
    int x = nums[0];
    for (int i = 1; i < nums.length; i++) {
      if (nums[i] != x) {
        ok = false;
        break;
      }
    }
    if (ok) {
      //if all numbers are equal
      //substract the combinations of n taken 1 and 2 from the total number of subsets
      //so we take all subsets with at least 3 elements
      int n = nums.length;
      int rez = (pow(2, n) - 1).toInt();
      rez = rez - n - n * (n - 1) ~/ 2;
      return rez;
    }
    int nr = 0;
    for (int i = 0; i < nums.length - 1; i++) {
      for (int j = i + 1; j < nums.length; j++) {
        //we take the first two elements of a subset
        //then the function searches for all subsets where the difference
        //between any 2 consecutive numbers is equal
        nr = nr + f(nums, j + 1, 2, nums[j], nums[j] - nums[i].toDouble());
      }
    }
    return nr;
  }
}
