/*

 -* Sum of Even Numbers After Queries *-

You are given an integer array nums and an array queries where queries[i] = [vali, indexi].

For each query i, first, apply nums[indexi] = nums[indexi] + vali, then print the sum of the even values of nums.

Return an integer array answer where answer[i] is the answer to the ith query.



Example 1:

Input: nums = [1,2,3,4], queries = [[1,0],[-3,1],[-4,0],[2,3]]
Output: [8,6,2,4]
Explanation: At the beginning, the array is [1,2,3,4].
After adding 1 to nums[0], the array is [2,2,3,4], and the sum of even values is 2 + 2 + 4 = 8.
After adding -3 to nums[1], the array is [2,-1,3,4], and the sum of even values is 2 + 4 = 6.
After adding -4 to nums[0], the array is [-2,-1,3,4], and the sum of even values is -2 + 4 = 2.
After adding 2 to nums[3], the array is [-2,-1,3,6], and the sum of even values is -2 + 6 = 4.
Example 2:

Input: nums = [1], queries = [[4,0]]
Output: [0]


Constraints:

1 <= nums.length <= 104
-104 <= nums[i] <= 104
1 <= queries.length <= 104
-104 <= vali <= 104
0 <= indexi < nums.length




*/

// O(n)
class A {
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

// O(m + n), Traverse complexity
class B {
// Runtime: 672 ms, faster than 100.00% of Dart online submissions for Sum of Even Numbers After Queries.
// Memory Usage: 177.3 MB, less than 100.00% of Dart online submissions for Sum of Even Numbers After Queries.
  List<int> sumEvenAfterQueries(List<int> nums, List<List<int>> queries) {
    int sumEven = 0;
    // List<int> ret = [queries.length];
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

class C {
  /*

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


*/
// Time Complexity: O(n + q), where n is the length of nums and q is the length of queries.
// Space Complexity: O(q) , where q is the length of queries
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

// class D {
//   List<int> sumEvenAfterQueries(List<int> nums, List<List<int>> queries) {
//     return queries.map((query) {
//       nums[query[1]] += query[0];
//       return nums.reduce((acc, cur) => cur % 2 == 0 ? acc : acc + cur, 0);
//     }).toList();
//   }
// }

class E {
/*

Intuition -

First, pre-compute the sum of all even numbers.
Now for each query, do the required operation and see if it effects the sum in any way.
If it does, then change the sum accordingly and store it in ans.
Algorithm -

Do the sum of all even numbers in nums array
Now for each query, there can be 3 possibilities.
Previously nums[index] was even, but now it is odd - So we need to subtract the previous value from sum.
Previously nums[index] was odd, but now it is even - So we need to add current value to sum.
Previously nums[index] was even and after sum operation, it is still even - In this case, we need to substract the previous value and add the current value to sum.
Return ans array



Complexity Analysis -
Time - O(N+M) where N is the length of nums array and M is the length of queries matrix.
Space - O(M) for resultant array.

  */
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
