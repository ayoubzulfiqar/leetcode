/*

  -* Merge Sorted Array *-

You are given two integer arrays nums1 and nums2, sorted in non-decreasing order, and two integers m and n, representing the number of elements in nums1 and nums2 respectively.

Merge nums1 and nums2 into a single array sorted in non-decreasing order.

The final sorted array should not be returned by the function, but instead be stored inside the array nums1.
To accommodate this, nums1 has a length of m + n, where the first m elements denote
the elements that should be merged, and the last n elements are set to 0 and should be ignored.
 nums2 has a length of n.



Example 1:

Input: nums1 = [1,2,3,0,0,0], m = 3, nums2 = [2,5,6], n = 3
Output: [1,2,2,3,5,6]
Explanation: The arrays we are merging are [1,2,3] and [2,5,6].
The result of the merge is [1,2,2,3,5,6] with the underlined elements coming from nums1.


Example 2:

Input: nums1 = [1], m = 1, nums2 = [], n = 0
Output: [1]
Explanation: The arrays we are merging are [1] and [].
The result of the merge is [1].


Example 3:

Input: nums1 = [0], m = 0, nums2 = [1], n = 1
Output: [1]
Explanation: The arrays we are merging are [] and [1].
The result of the merge is [1].
Note that because m = 0, there are no elements in nums1.
The 0 is only there to ensure the merge result can fit in nums1.


Constraints:

nums1.length == m + n
nums2.length == n
0 <= m, n <= 200
1 <= m + n <= 200
-109 <= nums1[i], nums2[j] <= 109

*/

// Algorithm
class A {
  // stuck
  void merge(List<int> nums1, int m, List<int> nums2, int n) {
    for (int i = 0; i < n; i++) nums1[i + m] = nums2[i];
    nums1.sort();
  }
}

class B {
  void merge(List<int> nums1, int m, List<int> nums2, int n) {
    int j = 0;
    int finalLength = nums1.length;
    for (int i = 0; i < finalLength && j < n; i++) {
      if (nums1[i] > nums2[j]) {
        int idx = m;
        while (idx > i) {
          nums1[idx] = nums1[idx - 1];
          idx--;
        }
        nums1[i] = nums2[j];
        m++;
        j++;
      }
    }

    for (int i = m; i < finalLength; i++, j++) {
      nums1[i] = nums2[j];
    }
  }
// 59 / 59 test cases passed, but took too long.
// Status: Time Limit Exceeded
// Submitted: 0 minutes ago
}

class C {
// Runtime: 569 ms, faster than 15.79% of Dart online submissions for Merge Sorted Array.
// Memory Usage: 142.5 MB, less than 71.05% of Dart online submissions for Merge Sorted Array.

  void merge(List<int> nums1, int m, List<int> nums2, int n) {
    int i = m - 1, j = n - 1, k = m + n - 1;
    while (i >= 0 && j >= 0) {
      if (nums1[i] <= nums2[j])
        nums1[k--] = nums2[j--];
      else
        nums1[k--] = nums1[i--];
    }
    while (j >= 0) nums1[k--] = nums2[j--];
  }
}
