# 🔥 Image Overlap 🔥 || 3 Solutions || Simple Fast and Easy || with Explanation

## Explanation for Solution -1

We will Traverse each element of B(say b) for each element of A(say a) and if Both of them are 1 then we assume we are shifting a to b by moving b's x coordinate by b's x-coordinate - a's x-coordinate = say X*and b's y coordinate by b's y-coordinate - b's y-coordinate = say Y*. So we map {X*,Y*} and increment it by 1 , so if already we obtain intersection of some pair of cell by moving same {X*,Y*} then we know matches obtained by shifting {X*,Y*} for every value of X*and Y*. To store {X*,Y*} we can use a map of string vs number of matches
OR Here we have used `int[2N][2N]` (to accommodate negative values too)
i - m is our X*
j - n is out Y*
And we add N bcs X*or Y* can reach minimum value of -N(So, to accommodate negative values) and max N.

## Solution - 1 Clean and Beat 100%

```dart
class Solution {
// Runtime: 336 ms, faster than 100.00% of Dart online submissions for Image Overlap.
// Memory Usage: 159.6 MB, less than 100.00% of Dart online submissions for Image Overlap.
  int largestOverlap(List<List<int>> img1, List<List<int>> img2) {
    int res = 0;
    int N = img1.length;
    // var count = new int[N * 2, N * 2];
    List<List<int>> count = List.filled(N * 2, 0, growable: true)
        .map((e) => List.filled(N * 2, 0, growable: true))
        .toList();
    for (int i = 0; i < N; i++)
      for (int j = 0; j < N; j++) {
        if (img1[i][j] == 0) continue;
        for (int m = 0; m < N; m++)
          for (int n = 0; n < N; n++) {
            if (img2[m][n] == 0) continue;
            res = max(res, ++count[N + i - m][N + j - n]);
          }
      }

    return res;
  }
}
```

## Solution - 2 Brute Force

### Approach

Apply brute force algorithm and check for each possible overlap position and keep track of maximum 1 overlapping.
So we need to do shifts in x and y direction. i.e. go up, left , down and right.
So first two loop will denote shift in x and y direction. We will go from –a.length+1 to a.length in x and y direction. This is because first overlap will be just 0,0 index overlapping of A with bottom right corner element of b. now for each co-ordinate position of x,y count overlaps. And keep track of max.
Now overlap function will return the count of overlapping 1. So, if `a[i][j]` is 1 and `a[i][j]==b[i-x][j-y]` increment count. After loop finishes return count.

```dart
class Solution {
// Runtime: 581 ms, faster than 100.00% of Dart online submissions for Image Overlap.
// Memory Usage: 144.6 MB, less than 100.00% of Dart online submissions for Image Overlap.

  int overlap(List<List<int>> img1, List<List<int>> img2, int i1, int j1,
      int i2, int j2) {
    int count = 0;
    for (int i = i1, x = i2; i >= 0 && x >= 0; i--, x--) {
      for (int j = j1, y = j2; j >= 0 && y >= 0; j--, y--) {
        if (img1[i][j] == img2[x][y]) {
          if (img1[i][j] == 1) count++;
        }
      }
    }
    return count;
  }

  int largestOverlap(List<List<int>> img1, List<List<int>> img2) {
    int R1 = img1.length;
    int R2 = img2.length;
    int C1 = img1[0].length;
    int C2 = img2[0].length;
    int maxi = 0;

    //Slide one image on other image.
    for (int r = 0; r < R1 + R2 - 1; r++) {
      int i = R1 - 1 + min(0, R2 - 1 - r);
      int x = r + min(0, R2 - 1 - r);
      for (int c = 0; c < C1 + C2 - 1; c++) {
        int j = C1 - 1 + min(0, C2 - 1 - c);
        int y = c + min(0, C2 - 1 - c);
        maxi = max(maxi, overlap(img1, img2, i, j, x, y));
      }
    }
    return maxi;
  }
}
```

## Solution - 3 HashMap

### Approach:-

#### Linear Transformation

find cells with ones. to move a 1 from A to a 1 from B, it'll take some transformation  `(dx, dy)`.
for another 1 cell in A to also overlap with a 1 cell in B will take the SAME (dx,dy).
make a map of possible `(dx,dy)` and count the ones that have the same `(dx,dy)`

find `[[i,j]...]` of 1s for A, B
find all combos of each filtered array
calc the dx,dy and set to a map.  find the mapping that has the highest count and return

T: filtering takes `O(N^2)`. combos takes a double for loop of N^2 *N^2 in the worst case.
so `N^2 + N^2* N^2 ---> O(N^4)`
S: `O(N^2)` for arrays space in the worst case of A and B filled with 1s

```dart
import 'dart:collection';

class Solution {
// Runtime: 2098 ms, faster than 100.00% of Dart online submissions for Image Overlap.
// Memory Usage: 186.3 MB, less than 100.00% of Dart online submissions for Image Overlap.

  int largestOverlap(List<List<int>> img1, List<List<int>> img2) {
    HashMap<String, int> map = HashMap(); // delta -> count
    int len = img1.length;
    int maxi = 0;
    for (int i = 0; i < len; i++)
      for (int j = 0; j < len; j++)
        if (img1[i][j] == 1) {
          // enumerate a 1 in A
          for (int x = 0; x < len; x++)
            for (int y = 0; y < len; y++)
              if (img2[x][y] == 1) {
                // enumerate a 1 in B
                String delta = (i - x).toString() +
                    " " +
                    (j - y).toString(); // calculate the delta of shift
                if (!map.containsKey(delta)) {

                  map[delta] = 0;
                }

                map[delta] = map[delta]! + 1;  // count++
                maxi = max(maxi, map[delta]!); // update answer
              }
        }
    return maxi;
  }
}
```
