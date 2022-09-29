/*



-* Find K Closest Elements *-

Given a sorted integer array arr, two integers k and x, return the k closest integers to x in the array.
The result should also be sorted in ascending order.

An integer a is closer to x than an integer b if:

|a - x| < |b - x|, or
|a - x| == |b - x| and a < b


Example 1:

Input: arr = [1,2,3,4,5], k = 4, x = 3
Output: [1,2,3,4]
Example 2:

Input: arr = [1,2,3,4,5], k = 4, x = -1
Output: [1,2,3,4]


Constraints:

1 <= k <= arr.length
1 <= arr.length <= 104
arr is sorted in ascending order.
-104 <= arr[i], x <= 104
Accepted
348,260
Submissions
759,654


*/

class A {
  // sorting
// Runtime: 4431 ms, faster than 100.00% of Dart online submissions for Find K Closest Elements.
// Memory Usage: 152.9 MB, less than 100.00% of Dart online submissions for Find K Closest Elements.

  List<int> findClosestElements(List<int> arr, int k, int x) {
    List<int> result = [];

    //sort the given array as per given conditions (shortest to longest)
    arr.sort((a, b) {
      // if the absolute value of the first element is less than than absolute value of the second element
      if ((a - x).abs() < (b - x).abs()) {
        return -1;
        // if both absolute values are same OR first is less than second
      } else if ((a - x).abs() == (b - x).abs() && a < b) {
        return -1;
      } else {
        return 1;
      }
    });

    //extract k elements and put it in result array
    while (k > 0) {
      // we shifting the first value inside the final array after adding
      result.add(arr.removeAt(0));

      k--;
    }

    //sort the result in ascending order
    result.sort((a, b) => a - b);

    return result;
  }
}

class B {
  // O(log n + k(log k)) Binary Search
// Runtime: 710 ms, faster than 100.00% of Dart online submissions for Find K Closest Elements.
// Memory Usage: 163.6 MB, less than 100.00% of Dart online submissions for Find K Closest Elements.
  List<int> findClosestElements(List<int> arr, int k, int x) {
    int n = arr.length;
    int low = -1;
    int high = n;
    while (low + 1 < high) {
      int mid = (low + high) ~/ 2;
      if (arr[mid] >= x)
        high = mid;
      else
        low = mid;
    }
    int sp = high;
    low = -1;
    high = n;
    while (low + 1 < high) {
      int mid = (low + high) ~/ 2;
      if (arr[mid] <= x) {
        low = mid;
      } else {
        high = mid;
      }
    }
    int ep = low;
    List<int> pc = []; // potentially closest
    bool found = sp < n && ep >= 0;
    if (found) {
      // count << sp << " " << ep <<  " Found !\n";
      for (int i = sp, cnt = 0; i <= ep && cnt < k; ++i, ++cnt) {
        pc.add(arr[i]);
        // count << arr[i] << " ";
      }
    }
    for (int l = sp - 1, cnt = 0; cnt < k && l >= 0; --l, ++cnt) {
      pc.add(arr[l]);
    }
    for (int r = ep + 1, cnt = 0; cnt < k && r < n; ++r, ++cnt) {
      pc.add(arr[r]);
    }
    // at max, 3k elements in the pc vector
    pc.sort((int a, int b) {
      if ((a - x).abs() < (b - x).abs()) return -1;
      if ((a - x).abs() == (b - x).abs() && a < b) return -1;
      return 1;
    });

    List<int> result = [];

    for (int x in pc) {
      if (result.length < k) {
        result.add(x);
      } else {
        break;
      }
    }
    result.sort();
    // count << "\n";
    return result;
  }
}

class C {
  // Two Pointers

// Runtime: 483 ms, faster than 100.00% of Dart online submissions for Find K Closest Elements.
// Memory Usage: 159.6 MB, less than 100.00% of Dart online submissions for Find K Closest Elements.

  List<int> findClosestElements(List<int> arr, int k, int x) {
    List<int> list = [];
    // starting point of our list
    int startingValue = 0;
    // ending point of our list
    int endingValue = arr.length - 1;

    while ((endingValue - startingValue + 1) != k) {
      // if the absolute value of first is less than second
      if ((arr[startingValue] - x).abs() > (arr[endingValue] - x).abs())
        // than we start adding the value from first point
        startingValue++;
      else
        // else decrement the ending point
        endingValue--;
    }
    // looping through the starting point and index if they are same and index is less than
    // the ending point in our whole list
    for (int index = startingValue; index <= endingValue; index++) {
      // than we will start adding the value ind our list based on given array
      list.add(arr[index]);
    }
    // after we will return the final list
    return list;
  }
}

class D {
  List<int> findClosestElements(List<int> arr, int k, int x) {
    int lo = 0, hi = arr.length - k;
    while (lo < hi) {
      int mid = lo + (hi - lo) ~/ 2;
      if (x - arr[mid] > arr[mid + k] - x) {
        lo = mid + 1;
      } else {
        hi = mid;
      }
    }

    List<int> ans = [];
    for (int i = 0; i < k; i++) {
      ans.add(arr[lo + i]);
    }

    return ans;
  }
}

// class E {
//   List<int> findClosestElements(List<int> arr, int k, int x) {
//     int left = 0, right = arr.length - 1;

//     while (right - left + 1 > k) {
//       if (arr[right] - x < x - arr[left])
//         left++;
//       else
//         right--;
//     }
// List.filled(arr.sort(), fill)
//     // return List<int>(arr.begin() + left, arr.begin() + right + 1);
//     return arr.sort(((a, b) => a +left, b + right + 1 ));
//   }
// }
