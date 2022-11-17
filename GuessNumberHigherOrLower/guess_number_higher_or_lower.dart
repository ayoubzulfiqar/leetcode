/*


-* 374. Guess Number Higher or Lower *-

We are playing the Guess Game. The game is as follows:

I pick a number from 1 to n. You have to guess which number I picked.

Every time you guess wrong, I will tell you whether the number I picked is higher or lower than your guess.

You call a pre-defined API int guess(int num), which returns three possible results:

-1: Your guess is higher than the number I picked (i.e. num > pick).
1: Your guess is lower than the number I picked (i.e. num < pick).
0: your guess is equal to the number I picked (i.e. num == pick).
Return the number that I picked.



Example 1:

Input: n = 10, pick = 6
Output: 6
Example 2:

Input: n = 1, pick = 1
Output: 1
Example 3:

Input: n = 2, pick = 1
Output: 1


Constraints:

1 <= n <= 231 - 1
1 <= pick <= n
Accepted
416,581
Submissions
815,531

*/

int guess(int number) => number;

class A {
  int guessNumber(int n) {
    int low = 1;
    int high = n;
    while (low <= high) {
      int mid = low + (high - low) ~/ 2;
      int g = guess(mid);
      if (g == 0) {
        return mid;
      } else if (g == -1) {
        high = mid - 1;
      } else {
        low = mid + 1;
      }
    }
    return -1;
  }
}

class B {
  int guessNumber(int n) {
    int i = 1, mid = n ~/ 2, k, l = 0;
    if (guess(mid) == 0)
      return mid;
    else if (guess(mid) == -1) {
      k = mid;
      l = 0;
    } else
      k = n;
    l = mid;
    for (i = l; i < k; i++) {
      if (guess(i) == 0) break;
    }
    return i;
  }
}

class C {
  int guessNumber(int n) {
    return binarySearch(0, n);
  }

  int binarySearch(int start, int end) {
    if (start > end) return -1;
    int mid = start + (end - start) ~/ 2;
    switch (guess(mid)) {
      case -1:
        return binarySearch(start, mid - 1);
      case 1:
        return binarySearch(mid + 1, end);
      default:
        return mid;
    }
  }
}
