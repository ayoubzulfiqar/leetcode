/*


-* Set Mismatch *-


You have a set of integers s, which originally contains all the numbers from 1 to n. Unfortunately, due to some error, one of the numbers in s got duplicated to another number in the set, which results in repetition of one number and loss of another number.

You are given an integer array nums representing the data status of this set after the error.

Find the number that occurs twice and the number that is missing and return them in the form of an array.



Example 1:

Input: nums = [1,2,2,4]
Output: [2,3]
Example 2:

Input: nums = [1,1]
Output: [1,2]


Constraints:

2 <= nums.length <= 104
1 <= nums[i] <= 104

*/

import 'dart:collection';

class A {
// Runtime: 723 ms, faster than 50.00% of Dart online submissions for Set Mismatch.
// Memory Usage: 164.9 MB, less than 50.00% of Dart online submissions for Set Mismatch.

  List<int> findErrorNums(List<int> nums) {
    int dup = 0, miss = 0;
    HashSet<int> hashset = HashSet();

    // find duplicate using set
    for (int i = 0; i < nums.length; ++i) {
      if (hashset.contains(nums[i])) dup = nums[i];
      hashset.add(nums[i]);
    }

    // find missing
    for (int i = 1; i <= nums.length; ++i) {
      if (hashset.contains(i) == false) {
        miss = i;
        break;
      }
    }

    return [dup, miss];
  }
}

class B {
// Runtime: 632 ms, faster than 50.00% of Dart online submissions for Set Mismatch.
// Memory Usage: 150.3 MB, less than 100.00% of Dart online submissions for Set Mismatch.
  List<int> findErrorNums(List<int> nums) {
    int n = nums.length;
    int i = 0;

    while (i < n) {
      int idx = nums[i] - 1;

      if (nums[i] != nums[idx]) {
        int temp = nums[i];
        nums[i] = nums[idx];
        nums[idx] = temp;
      } else {
        ++i;
      }
    }

    for (i = 0; i < n; ++i) {
      if (nums[i] != i + 1) {
        return [nums[i], i + 1];
      }
    }

    return [];
  }
}

class C {
  List<int> findErrorNums(List<int> nums) {
    int n = nums.length;
    List<int> arr = List.filled(n + 1, 0);
    List<int> vec = List.empty(growable: true);

    for (int i in nums) {
      arr[i]++;
    }

    for (int i = 1; i < n + 1; i++) {
      if (arr[i] > 1) vec.add(i);
    }
    for (int i = 1; i < n + 1; i++) {
      if (arr[i] == 0) vec.add(i);
    }
    return vec;
  }
}

class D {
  List<int> findErrorNums(List<int> nums) {
    nums.sort();
    List<int> b = List.filled(nums.length + 1, 0);
    int x = 0;
    int y = 0;
    // int c = 1;
    for (int i = 0; i < nums.length; i++) {
      b[nums[i]] = b[nums[i]] + 1;
    }
    for (int i = 1; i < b.length; i++) {
      if (b[i] == 0) {
        y = i;
      }
      if (b[i] == 2) {
        x = i;
      }
    }
    return [x, y];
  }
}

/*


*/
class E {
// Runtime: 369 ms, faster than 100.00% of Dart online submissions for Set Mismatch.
// Memory Usage: 159.3 MB, less than 50.00% of Dart online submissions for Set Mismatch.
  List<int> findErrorNums(List<int> nums) {
    List<int> ans = List.filled(2, 0);
    for (int i = 0; i < nums.length; i++) {
      int val = (nums[i]).abs();
      ans[1] ^= (i + 1) ^ val;
      if (nums[val - 1] < 0)
        ans[0] = val;
      else
        nums[val - 1] = -nums[val - 1];
    }
    ans[1] ^= ans[0];
    return ans;
  }
}
