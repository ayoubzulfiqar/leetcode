/*

-* 852. Peak Index in a Mountain Array *-

An array arr a mountain if the following properties hold:

arr.length >= 3
There exists some i with 0 < i < arr.length - 1 such that:
arr[0] < arr[1] < ... < arr[i - 1] < arr[i] 
arr[i] > arr[i + 1] > ... > arr[arr.length - 1]
Given a mountain array arr, return the index i such that arr[0] < arr[1] < ... < arr[i - 1] < arr[i] > arr[i + 1] > ... > arr[arr.length - 1].

You must solve it in O(log(arr.length)) time complexity.

 

Example 1:

Input: arr = [0,1,0]
Output: 1
Example 2:

Input: arr = [0,2,1,0]
Output: 1
Example 3:

Input: arr = [0,10,5,2]
Output: 1
 

Constraints:

3 <= arr.length <= 105
0 <= arr[i] <= 106
arr is guaranteed to be a mountain array.

*/

class A {
  int peakIndexInMountainArray(List<int> arr) {
    int i = arr.length ~/ 2;
    int arrLen = i;
    while (true) {
      if (arr[i] > arr[i + 1] && arr[i] > arr[i - 1]) break;
      if (arr[i] < arr[i + 1]) {
        arrLen ~/= 2;
        i += arrLen;
      } else {
        i -= arrLen ~/ 2;
      }
    }
    return i;
  }
}

class B {
  int peakIndexInMountainArray(List<int> arr) {
    int left = 0;
    int right = arr.length - 1;
    int mid;
    while (left < right) {
      mid = left + (right - left) ~/ 2;
      if (arr[mid] > arr[mid + 1]) {
        right = mid;
      } else {
        left = mid + 1;
      }
    }
    return left;
  }
}

class Solution {
  int peakIndexInMountainArray(List<int> arr) {
    return getPeak(arr.length ~/ 2, arr, 0, arr.length - 1);
  }

  int getPeak(int cur, List<int> arr, int start, int end) {
    if (arr[cur] < arr[cur + 1]) {
      start = cur;
      cur = (start + end) ~/ 2;
      return getPeak(cur, arr, start, end);
    }
    if (arr[cur] < arr[cur - 1]) {
      end = cur;
      cur = (end - start) ~/ 2;
      return getPeak(cur ~/ 2, arr, start, end);
    }
    return cur;
  }
}

/*

This Solution need to Work On


class PeakIndexFinder {
  int peakIndexInMountainArray(List<int> arr) {
    List<MapEntry<int, int>> pq = arr.asMap().entries.map((entry) => MapEntry(-entry.value, entry.key)).toList();
    heapify(pq);
    heapPop(pq);
    return pq[pq.length - 1].value; // Return the peak index from the last element of the heap
  }
}

void heapify(List<MapEntry<int, int>> arr) {
  int n = arr.length;
  for (int i = (n ~/ 2) - 1; i >= 0; i--) {
    _sink(arr, i, n);
  }
}

void heapPop(List<MapEntry<int, int>> arr) {
  int n = arr.length;
  if (n == 0) return;

  // Swap root with the last element
  MapEntry<int, int> temp = arr[0];
  arr[0] = arr[n - 1];
  arr[n - 1] = temp;

  // Remove the last element (previously the root)
  arr.removeLast();

  // Heapify the array again
  _sink(arr, 0, n - 1);
}

void _sink(List<MapEntry<int, int>> arr, int k, int n) {
  while (2 * k + 1 < n) {
    int j = 2 * k + 1; // Left child
    if (j + 1 < n && arr[j].key > arr[j + 1].key) {
      j++; // Right child
    }
    if (arr[k].key <= arr[j].key) {
      break;
    }
    // Swap parent with the smallest child
    MapEntry<int, int> temp = arr[k];
    arr[k] = arr[j];
    arr[j] = temp;
    k = j;
  }
}

*/