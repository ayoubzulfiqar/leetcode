/*

 -* Summary Ranges *-


 You are given a sorted unique integer array nums.

A range [a,b] is the set of all integers from a to b (inclusive).

Return the smallest sorted list of ranges that cover all the numbers in the array exactly. That is, each element of nums is covered by exactly one of the ranges, and there is no integer x such that x is in one of the ranges but not in nums.

Each range [a,b] in the list should be output as:

"a->b" if a != b
"a" if a == b


Example 1:

Input: nums = [0,1,2,4,5,7]
Output: ["0->2","4->5","7"]
Explanation: The ranges are:
[0,2] --> "0->2"
[4,5] --> "4->5"
[7,7] --> "7"
Example 2:

Input: nums = [0,2,3,4,6,8,9]
Output: ["0","2->4","6","8->9"]
Explanation: The ranges are:
[0,0] --> "0"
[2,4] --> "2->4"
[6,6] --> "6"
[8,9] --> "8->9"


Constraints:

0 <= nums.length <= 20
-231 <= nums[i] <= 231 - 1
All the values of nums are unique.
nums is sorted in ascending order.

*/

class A {
// Runtime: 474 ms, faster than 10.00% of Dart online submissions for Summary Ranges.
// Memory Usage: 140 MB, less than 90.00% of Dart online submissions for Summary Ranges
  List<String> summaryRanges(List<int> nums) {
    List<String> res = [];

    //loop over the whole arary elements
    for (int i = 0; i < nums.length; i++) {
      //initialize another pointer (j) besides the main pointer (i)
      int j = i;
      String temp = "";

      //move with the pointer j while the numbers sorted ascendily corrent, until finding a missing element & the coming move must be in the range of the current vector
      while (j + 1 < nums.length && nums[j + 1] == nums[j] + 1) j++;

      //if the two pointers points on different positions-> add the two range numbers in the required form
      if (j != i) {
        temp += nums[i].toString();
        temp += "->";
        temp += nums[j].toString();
      }

      //if they points on the same element ->add only one value
      else
        temp += nums[i].toString();

      //add the string with the range values to the vector
      res.add(temp);
      //make the main pointer points on the last taken number
      i = j;
    }

    //return the new array values
    return res;
  }
}

class B {
// Runtime: 589 ms, faster than 10.00% of Dart online submissions for Summary Ranges.
// Memory Usage: 140.3 MB, less than 70.00% of Dart online submissions for Summary Ranges.
  List<String> summaryRanges(List<int> nums) {
    List<String> ans = [];
    if (nums.length == 0) return ans;

    int count = nums[0];
    int ll = nums[0];
    int ul = nums[0];
    for (int i = 0; i < nums.length; i++) {
      if (count == nums[i]) {
        ul = nums[i];
      } else if (count != nums[i]) {
        if (ul == ll) {
          ans.add(ll.toString());
        } else {
          String s1 = ll.toString();
          String s2 = ul.toString();
          ans.add(s1 + "->" + s2);
        }
        count = nums[i];
        ll = nums[i];
        ul = nums[i];
      }
      count++;
    }
    if (ul == ll) {
      ans.add(ll.toString());
    } else {
      String s1 = ll.toString();
      String s2 = ul.toString();
      ans.add(s1 + "->" + s2);
    }
    return ans;
  }
}

class D {
  // O(NlogN) || BinarySearch
// Runtime: 516 ms, faster than 10.00% of Dart online submissions for Summary Ranges.
// Memory Usage: 151.3 MB, less than 40.00% of Dart online submissions for Summary Ranges.
  int findEnd(List<int> nums, int l, int h, int start) {
    if (l > h) return -1;
    int mid = (l + h) ~/ 2;
    if (nums[mid] - nums[start] == mid - start) {
      //number is part if current range
      int ind = findEnd(nums, mid + 1, h,
          start); // check if any further numbers belong to current range
      return ind == -1
          ? mid
          : ind; // if no further numbers belong to range then return mid else return the further end
    }
    return findEnd(nums, l, mid - 1,
        start); //if mid is not part of range then the end must exist in left sub-array
  }

  List<String> summaryRanges(List<int> nums) {
    List<String> ans = [];

    if (nums.length == 0) return ans;

    StringBuffer str = StringBuffer("");
    int start = 0;
    while (start < nums.length) {
      if (str.length > 0) str.clear();
      str.write(nums[start]);
      int end = findEnd(nums, start, nums.length - 1,
          start); //find end index for every range from start
      if (start != end) {
        str.write("->");
        str.write(nums[end]);
      }
      ans.add(str.toString());
      start = end + 1; //new range will begin at index after previous range end
    }
    return ans;
  }
}
