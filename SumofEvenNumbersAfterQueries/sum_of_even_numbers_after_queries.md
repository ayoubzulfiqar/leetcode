# 🔥 DART 🔥 || 5 solutions || line by line explanation

## Solution - 1 O(n)

```dart
class Solution {
// Runtime: 608 ms, faster than 100.00% of Dart online submissions for Sum of Even Numbers After Queries.
// Memory Usage: 178.7 MB, less than 100.00% of Dart online submissions for Sum of Even Numbers After Queries.
  List<int> sumEvenAfterQueries(List<int> nums, List<List<int>> queries) {
    List<int> ret = [];
    int sum = 0;

    for (var query in queries) {
      if (ret.length == 0) {
        nums[query[1]] = query[0] + nums[query[1]];
        // calculate the sum of even nums
        for (int a in nums) if (a % 2 == 0) sum += a;
      } else {
        if (nums[query[1]] % 2 == 0) sum -= nums[query[1]];
        nums[query[1]] = query[0] + nums[query[1]];
        if (nums[query[1]] % 2 == 0) sum += nums[query[1]];
      }

      ret.add(sum);
    }

    return ret;
  }
}
```

## Solution - 2 O(m + n), Traverse complexity

```dart
class Solution {
// Runtime: 672 ms, faster than 100.00% of Dart online submissions for Sum of Even Numbers After Queries.
// Memory Usage: 177.3 MB, less than 100.00% of Dart online submissions for Sum of Even Numbers After Queries.
  List<int> sumEvenAfterQueries(List<int> nums, List<List<int>> queries) {
    int sumEven = 0;
    List<int> ret = List.filled(queries.length, 0);
    for (int i = 0; i < nums.length; i++) {
      if (nums[i] % 2 == 0) {
        sumEven += nums[i];
      }
    }

    //queries
    for (int i = 0; i < queries.length; i++) {
      int prev = nums[queries[i][1]];
      nums[queries[i][1]] += queries[i][0];
      // case 1: prev was even, now again it is even
      if (prev % 2 == 0 && nums[queries[i][1]] % 2 == 0) {
        sumEven -= prev;
        sumEven += nums[queries[i][1]];
      }
      // case 2: prev was even, now odd
      else if (prev % 2 == 0 && nums[queries[i][1]] % 2 != 0) {
        sumEven -= prev;
      }
      // case 3: prev odd, now even
      else if (prev % 2 != 0 && nums[queries[i][1]] % 2 == 0) {
        sumEven += nums[queries[i][1]];
      }
      // case 4: prev odd, now odd

      ret[i] = sumEven;
    }
    return ret;
  }
}
```

## Solution - 3

Intuition:

For each query, we need to check if the number at the index is even or odd.
We need to apply nums[index] = nums[index] + val, then print the sum of all even numbers.
So, we can basically pre-compute the sum of all even numbers in the array.
This will allow us to quickly update the sum when we add or remove an even number.
Approach:

Find the sum of all even numbers in the array
For each query, add the value to the index
If the new value is even, add it to the sum
If the old value was even, subtract it from the sum
Add the sum to the answer

Time Complexity: O(n + q), where n is the length of nums and q is the length of queries.
Space Complexity: O(q) , where q is the length of queries

```dart
class Solution {
  List<int> sumEvenAfterQueries(List<int> nums, List<List<int>> queries) {
    int sum = 0;
    for (int i = 0; i < nums.length; i++) {
      if (nums[i] % 2 == 0) {
        sum += nums[i];
      }
    }
    List<int> ans = [];
    for (int i = 0; i < queries.length; i++) {
      int val = queries[i][0];
      int index = queries[i][1];
      if (nums[index] % 2 == 0) {
        sum -= nums[index];
      }
      nums[index] += val;
      if (nums[index] % 2 == 0) {
        sum += nums[index];
      }
      ans.add(sum);
    }
    return ans;
  }
}
```

## Solution - 4

Intuition -

First, pre-compute the sum of all even numbers.
Now for each query, do the required operation and see if it effects the sum in any way.
If it does, then change the sum accordingly and store it in ans.
Algorithm -

Do the sum of all even numbers in nums array
Now for each query, there can be 3 possibilities.
Previously nums[index] was even, but now it is odd - So we need to subtract the previous value from sum.
Previously nums[index] was odd, but now it is even - So we need to add current value to sum.
Previously nums[index] was even and after sum operation, it is still even - In this case, we need to subtract the previous value and add the current value to sum.
Return ans array

Complexity Analysis -
Time - O(N+M) where N is the length of nums array and M is the length of queries matrix.
Space - O(M) for resultant array.

```dart
class Solution {
// Runtime: 437 ms, faster than 100.00% of Dart online submissions for Sum of Even Numbers After Queries.
// Memory Usage: 157.6 MB, less than 100.00% of Dart online submissions for Sum of Even Numbers After Queries.
  List<int> sumEvenAfterQueries(List<int> nums, List<List<int>> queries) {
    int sum = 0;
    for (int n in nums) {
      if (n % 2 == 0) sum += n;
    }

    List<int> ans = List.filled(queries.length, 0);
    int i = 0;
    for (var query in queries) {
      int val = query[0];
      int index = query[1];

      bool previouslyEven = nums[index] % 2 == 0;
      int prev = nums[index];
      nums[index] += val;
      bool currentlyEven = nums[index] % 2 == 0;
      int curr = nums[index];

      if (previouslyEven && currentlyEven) {
        sum -= prev;
        sum += curr;
      } else if (!previouslyEven && currentlyEven) {
        sum += curr;
      } else if (previouslyEven && !currentlyEven) {
        sum -= prev;
      }

      ans[i++] = sum;
    }

    return ans;
  }
}
```

## Bonus Solution - Golang

```go
// the idea is we don't calculate the even sum from scratch for each query
// instead, we calculate it at the beginning
// since each query only updates one value,
// so we can adjust the even sum base on the original value and new value
func sumEvenAfterQueries(nums []int, queries [][]int) []int {
 evenSum := 0
 // calculate the sum of all even numbers
 for _, val := range nums {
  if val%2 == 0 {
   evenSum += val
  }
 }
 ans := make([]int, len(queries))
 for i, q := range queries {
  val, idx := q[0], q[1]
  // if original nums[idx] is even, then we deduct it from evenSum
  if nums[idx]%2 == 0 {
   evenSum -= nums[idx]
  }
  // in-place update nums
  nums[idx] += val
  // check if we need to update evenSum for the new value
  if nums[idx]%2 == 0 {
   evenSum += nums[idx]
  }
  // then we have evenSum after this query, push it to ans
  ans[i] = evenSum
 }
 return ans
}
```
