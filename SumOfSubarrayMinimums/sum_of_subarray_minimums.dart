/*

- * 907. Sum of Sub-array Minimums *-


Given an array of integers arr, find the sum of min(b), where b ranges over every (contiguous) subarray of arr. Since the answer may be large, return the answer modulo 109 + 7.

 

Example 1:

Input: arr = [3,1,2,4]
Output: 17
Explanation: 
Sub-arrays are [3], [1], [2], [4], [3,1], [1,2], [2,4], [3,1,2], [1,2,4], [3,1,2,4]. 
Minimums are 3, 1, 2, 4, 1, 1, 2, 1, 1, 1.
Sum is 17.
Example 2:

Input: arr = [11,81,94,43,3]
Output: 444
 

Constraints:

1 <= arr.length <= 3 * 104
1 <= arr[i] <= 3 * 104


 */

import 'dart:collection';
import 'dart:math';

class A {
  // MonoStack
  int sumSubarrayMins(List<int> arr) {
    int res = 0;
    int sz = arr.length;
    int mod = 1000000007;
    List<int> ms = [-1];
    for (int i = 0; i <= sz; ++i) {
      while (ms.last != -1 && (i == sz || arr[i] <= arr[ms.last])) {
        int j = ms.last;
        ms.removeLast();
        res = (res + arr[j] * (j - ms.last) * (i - j)) % mod;
      }
      ms.add(i);
    }
    return res;
  }
}

class B {
  int sumSubarrayMins(List<int> arr) {
    int res = 0;
    int n = arr.length;
    int mod = (1e9 + 7).toInt();
    for (int end = 0; end < n; end++) {
      for (int start = 0; start <= end; start++) {
        int mini = double.maxFinite.toInt();
        for (int i = start; i <= end; i++) mini = min(mini, arr[i]);
        res = (res + mini) % mod;
      }
    }
    return res;
  }
}

class C {
  int sumSubarrayMins(List<int> arr) {
    int n = arr.length;
    List<int> leftMin = List.filled(n,
        0); //store no.  elements between current element and left smaller element.
    List<int> rightMin = List.filled(n,
        0); //store no.  elements between current element and right smaller element.
    int mod = (1e9 + 7).toInt();
    Queue<int> ind = Queue();
    for (int i = 0; i < n; i++) {
      while (ind.isNotEmpty && arr[ind.last] > arr[i]) ind.removeLast();
      leftMin[i] = ind.isEmpty ? i + 1 : i - ind.last;
      ind.add(i);
    }
    ind = Queue();
    for (int i = n - 1; i >= 0; i--) {
      while (ind.isNotEmpty && arr[ind.last] >= arr[i]) ind.removeLast();
      rightMin[i] = ind.isEmpty ? n - i : ind.last - i;
      ind.add(i);
    }
    int res = 0;
    for (int i = 0; i < n; i++)
      res = (res + arr[i] * leftMin[i] * rightMin[i]) %
          mod; //finding sum of minimum of all possible subarrays with current element as minimum.
    return res;
  }
}
