#

## **Intuition:**

The code is designed to find the peak index in a mountain array. A mountain array is an array that increases up to a certain index (peak) and then decreases afterward. The code uses a binary search-based approach to efficiently locate the peak element.

## **Approach:**

The `peakIndexInMountainArray` function initiates the binary search by calling the `getPeak` function. The `getPeak` function performs a binary search to find the peak index in the array.

1. The `peakIndexInMountainArray` function starts the binary search by calling `getPeak` with the initial values of `cur` (the middle index of the array), `start` (the start index of the array), and `end` (the end index of the array).
2. The `getPeak` function checks if the value at `cur` is less than the value at the next index (`cur + 1`). If it is, it means the peak is on the right side, so it updates `start` to `cur` and calculates a new value of `cur` as the middle index between `start` and `end`.
3. If the value at `cur` is not less than the value at the next index, it means the peak is on the left side. The function updates `end` to `cur` and calculates a new value of `cur` as the middle index between `start` and `end`.
4. The binary search continues until it finds the peak index when the condition `arr[cur] < arr[cur + 1]` or `arr[cur] < arr[cur - 1]` is false, and the function returns the current index as the peak index.

## **Time Complexity:**

The time complexity of this algorithm is O(log n), where n is the number of elements in the input array. This is because the binary search approach divides the search space in half with each recursive call.

## **Space Complexity:**

The space complexity of this algorithm is O(log n) as well. This is because the binary search approach uses recursive calls, and the maximum depth of the recursion is log n (where n is the number of elements in the input array) because the search space is halved with each recursive call.

```dart
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
```
