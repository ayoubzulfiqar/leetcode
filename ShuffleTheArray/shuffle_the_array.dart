/*


-* 1470. Shuffle the Array *-




Given the array nums consisting of 2n elements in the form [x1,x2,...,xn,y1,y2,...,yn].

Return the array in the form [x1,y1,x2,y2,...,xn,yn].

 

Example 1:

Input: nums = [2,5,1,3,4,7], n = 3
Output: [2,3,5,4,1,7] 
Explanation: Since x1=2, x2=5, x3=1, y1=3, y2=4, y3=7 then the answer is [2,3,5,4,1,7].
Example 2:

Input: nums = [1,2,3,4,4,3,2,1], n = 4
Output: [1,4,2,3,3,2,4,1]
Example 3:

Input: nums = [1,1,2,2], n = 2
Output: [1,2,1,2]
 

Constraints:

1 <= n <= 500
nums.length == 2n
1 <= nums[i] <= 10^3



*/

List<int> shuffle(List<int> nums, int n) {
  return [];
}

class A {
  List<int> shuffle(List<int> nums, int n) {
    nums[0] *= -1;

    for (int i = 1; i < nums.length; i++) {
      int j = i;
      int currentNumber = nums[i];
      while (nums[j] > 0) {
        int target;
        if (j < n) {
          target = j * 2;
        } else {
          target = (j - n) * 2 + 1;
        }
        int temp = nums[target];
        nums[target] = currentNumber;
        currentNumber = temp;
        nums[j] *= -1;
        j = target;
      }
    }
    for (int i = 0; i < nums.length; i++) {
      nums[i] = (nums[i]).abs();
    }

    return nums;
  }
}

class B {
  List<int> shuffle(List<int> nums, int n) {
    List<int> ans = List.filled(2 * n, 0);
    for (int i = 0; i < n; i++) {
      ans[2 * i] = nums[i];
      ans[2 * i + 1] = nums[i + n];
    }
    return ans;
  }
}

class c {
  List<int> shuffle(List<int> nums, int n) {
    int first = 0, second = n, max = 1001;
    for (int i = 0; i < 2 * n; i++) {
      if (i % 2 == 0)
        nums[i] = (nums[first++] % max) * max + nums[i];
      else
        nums[i] = (nums[second++] % max) * max + nums[i];
    }
    for (int i = 0; i < 2 * n; i++) nums[i] ~/= max;
    return nums;
  }
}
