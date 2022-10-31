/*



 -* Missing Number *-

 Given an array nums containing n distinct numbers in the range [0, n], return the only number in the range that is missing from the array.



Example 1:

Input: nums = [3,0,1]
Output: 2
Explanation: n = 3 since there are 3 numbers, so all numbers are in the range [0,3]. 2 is the missing number in the range since it does not appear in nums.
Example 2:

Input: nums = [0,1]
Output: 2
Explanation: n = 2 since there are 2 numbers, so all numbers are in the range [0,2]. 2 is the missing number in the range since it does not appear in nums.
Example 3:

Input: nums = [9,6,4,2,3,5,7,0,1]
Output: 8
Explanation: n = 9 since there are 9 numbers, so all numbers are in the range [0,9]. 8 is the missing number in the range since it does not appear in nums.


Constraints:

n == nums.length
1 <= n <= 104
0 <= nums[i] <= n
All the numbers of nums are unique.


Follow up: Could you implement a solution using only O(1) extra space complexity and O(n) runtime complexity?

*/

import 'dart:collection';

class Solution {
  int missingNumber(List<int> nums) {
    int sum = 0; // sum of all numbers initially 0
    // total is the sum of all numbers in the array
    int total = nums.length * (nums.length + 1) ~/ 2;
    for (int number in nums) {
      // iterate through the array
      sum += number; // add the number to the sum
    }
    // return the difference between the sum and the total that is the missing number
    return total - sum;
  }
}

class B {
  int missingNumber(List<int> nums) {
    int size = nums.length;
    List<int> array = List.filled(size + 1, 0);
    for (int i = 0; i < size + 1; i++) {
      array[nums[i]]++;
    }
    int ans = 0;
    for (int i = 0; i < size; i++) {
      if (nums[i] == 0) {
        ans = i;
      }
    }
    return ans;
  }
}

class C {
  int missingNumber(List<int> nums) {
    int result = nums.length; // initialize result to size of vector
    int i = 0; // initialize i to 0
    for (int num in nums) {
      // for each number in vector
      result ^= num; // XOR result with number
      result ^= i; // XOR result with i
      i++; // increment i
    }
    return result; //
  }
}

class D {
  int missingNumber(List<int> nums) {
    HashMap map = HashMap();

    // every number in our list
    for (int i = 0; i < nums.length; i++) {
      // single value
      int number = nums[i];
      // adding it to the map
      map[number] = number;
    }
    // answer
    int ans = -1;
    // for 10000 words
    for (int i = 0; i < 10000; i++) {
      // if our map contain any digit
      if (map.containsKey(i)) {
        // we will continue
        continue;
      } else {
        // else if there is not match in any digit
        // we will assign it and return it
        ans = i;
        break;
      }
    }
    return ans;
  }
}

class E {
  int missingNumber(List<int> nums) {
    HashSet hashSet = HashSet();
    int answer = -1;
    for (int i = 0; i < nums.length; i++) {
      hashSet.add(nums[i]);
    }
    for (int i = 0; i < 10000; i++) {
      if (hashSet.contains(i)) {
        continue;
      } else {
        answer = i;
        break;
      }
    }
    return answer;
  }
}
