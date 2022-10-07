# 🔥 Summary Ranges 🔥 || 3 Solutions || Simple Fast and Easy || with Explanation

## Solution - 1

```dart
class Solution {
// Runtime: 474 ms, faster than 100.0% of Dart online submissions for Summary Ranges.
// Memory Usage: 140 MB, less than 90.00% of Dart online submissions for Summary Ranges
  List<String> summaryRanges(List<int> nums) {
    List<String> res = [];

    //loop over the whole array elements
    for (int i = 0; i < nums.length; i++) {
      //initialize another pointer (j) besides the main pointer (i)
      int j = i;
      String temp = "";

      //move with the pointer j while the numbers sorted ascending correct, until finding a missing element & the coming move must be in the range of the current vector
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
```

## Solution - 2

```dart
class Solution {
// Runtime: 589 ms, faster than 100.00% of Dart online submissions for Summary Ranges.
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
```

## Solution - 3 O(NlogN) || BinarySearch

```dart
class Solution {
// Runtime: 516 ms, faster than 100.0% of Dart online submissions for Summary Ranges.
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
```
