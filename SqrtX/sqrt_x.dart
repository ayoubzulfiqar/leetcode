/*

 -* Sqrt(x) *-

 Given a non-negative integer x, compute and return the square root of x.

Since the return type is an integer, the decimal digits are truncated, and only the integer part of the result is returned.

Note: You are not allowed to use any built-in exponent function or operator, such as pow(x, 0.5) or x ** 0.5.



Example 1:

Input: x = 4
Output: 2


Example 2:

Input: x = 8
Output: 2
Explanation: The square root of 8 is 2.82842..., and since the decimal part is truncated, 2 is returned.


Constraints:

0 <= x <= 231 - 1

*/

class A {
/*


Here, we can apply binary search on a range of numbers starting from 1 going up to x / 2where x = given number.
Here, we implement the binary search on a chosen sorted sequence instead of an array.

Right limit is set as x / 2 because for every number x, greater than 2, the floor of their square root will be less than x /
2. Depending on the result of the binary search, we can jump to the left or right halves of the original sample space.


Algorithm
Create a binarySearch() function returning floor of sqrt(x)
Initialize variable ans to store the result
If the number is less than 2, return itself
Initialize left and right values as 1 and x / 2 respectively
Until left <= right:
Find middle of this range, mid = left + right / 2
In case square of mid is equal to x,  return it as it is the square root
If square of mid is less than x, jump to the right half by setting left = mid + 1
Otherwise, jump to the left half by setting right = mid – 1 and save this value in ans
Print the result


*/

// Runtime: 679 ms, faster than 43.75% of Dart online submissions for Sqrt(x).
// Memory Usage: 158.8 MB, less than 6.25% of Dart online submissions for Sqrt(x).

  int mySqrt(int x) {
    int binarySearch(int x) {
      int left = 1, right = x ~/ 2, mid, ans = 0;
      var temp;
      while (left <= right) {
        mid = (left + (right - left) ~/ 2);
        temp = mid * mid;
        //mid * mid can be large, so use long
        if (temp == x) return mid;
        if (temp < x) {
          ans = mid;
          left = mid + 1;
        } else
          right = mid - 1;
      }
      return ans;
    }

    if (x <= 1) return x;
    return binarySearch(x);
  }
}

class B {
// Runtime: 812 ms, faster than 9.38% of Dart online submissions for Sqrt(x).
// Memory Usage: 149 MB, less than 37.50% of Dart online submissions for Sqrt(x).

  int mySqrt(int x) {
    int result = 0, i = 1;
    while (x >= 0) {
      x = x - i;
      result++;
      i += 2;
    }
    return result - 1;
  }
}

class C {
  // Binary Search Solution - TC O(log n) | 100% Faster
// Runtime: 661 ms, faster than 50.00% of Dart online submissions for Sqrt(x).
// Memory Usage: 141.8 MB, less than 96.88% of Dart online submissions for Sqrt(x).

  int mySqrt(int x) {
    if (x == 1 || x == 0) return x;

    int low = 1, high = x ~/ 2;

    while (low <= high) {
      var mid = low + (high - low) ~/ 2;

      if (mid * mid == x) {
        return mid;
      } else if (mid * mid > x) {
        high = mid - 1;
      } else {
        low = mid + 1;
      }
    }

    return high;
  }
}

class D {
// Runtime: 722 ms, faster than 21.88% of Dart online submissions for Sqrt(x).
// Memory Usage: 150 MB, less than 15.63% of Dart online submissions for Sqrt(x).

  int mySqrt(int x) {
    int i = 1;
    while (i * i <= x) {
      i++;
    }
    return i - 1;
  }
}
