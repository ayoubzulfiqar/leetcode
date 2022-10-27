/*


-* Image Overlap *-



You are given two images, img1 and img2, represented as binary, square matrices of size n x n. A binary matrix has only 0s and 1s as values.

We translate one image however we choose by sliding all the 1 bits left, right, up, and/or down any number of units. We then place it on top of the other image. We can then calculate the overlap by counting the number of positions that have a 1 in both images.

Note also that a translation does not include any kind of rotation. Any 1 bits that are translated outside of the matrix borders are erased.

Return the largest possible overlap.



Example 1:


Input: img1 = [[1,1,0],[0,1,0],[0,1,0]], img2 = [[0,0,0],[0,1,1],[0,0,1]]
Output: 3
Explanation: We translate img1 to right by 1 unit and down by 1 unit.

The number of positions that have a 1 in both images is 3 (shown in red).

Example 2:

Input: img1 = [[1]], img2 = [[1]]
Output: 1
Example 3:

Input: img1 = [[0]], img2 = [[0]]
Output: 0


Constraints:

n == img1.length == img1[i].length
n == img2.length == img2[i].length
1 <= n <= 30
img1[i][j] is either 0 or 1.
img2[i][j] is either 0 or 1.


*/

import 'dart:collection';
import 'dart:math';

class A {
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

class B {
  int largestOverlap(List<List<int>> img1, List<List<int>> img2) {
    HashMap<String, int> map = new HashMap(); // delta -> count
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
                  // map.put(delta, 0);
                  map[delta] = 0;
                }
                // map.put(delta, map[delta]!+ 1); // count++
                map[delta] = map[delta]! + 1;
                maxi = max(maxi, map[delta]!); // update answer
              }
        }
    return maxi;
  }
}

class C {
  int getOverlap(
      int rowOffset, int colOffset, List<List<int>> A, List<List<int>> B) {
    final int N = A.length;
    int overlap = 0;

    for (int row = 0; row < N; ++row) {
      for (int col = 0; col < N; ++col) {
        int r = row + rowOffset;
        int c = col + colOffset;
        if (r < 0 || r >= N || c < 0 || c >= N) continue;

        if (A[row][col] == 1 && B[r][c] == 1) ++overlap;
      }
    }

    return overlap;
  }

  int largestOverlap(List<List<int>> img1, List<List<int>> img2) {
    final int N = img1.length;
    int largest = 0;
    for (int rowOffset = -N; rowOffset < N; ++rowOffset) {
      for (int colOffset = -N; colOffset < N; ++colOffset) {
        largest = max(largest, getOverlap(rowOffset, colOffset, img1, img2));
      }
    }

    return largest;
  }
}

class D {
// Runtime: 336 ms, faster than 100.00% of Dart online submissions for Image Overlap.
// Memory Usage: 159.6 MB, less than 100.00% of Dart online submissions for Image Overlap.
  int largestOverlap(List<List<int>> img1, List<List<int>> img2) {
    int res = 0;
    int N = img1.length;
    // var count = new int[N * 2, N * 2];
    List<List<int>> count = List.filled(N * 2, 0, growable: true)
        .map((e) => List.filled(N * 2, 0, growable: true))
        .toList();
    // List<List<int>> count = List.filled(N * 2, N * 2);
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

class E {
  int largestOverlap(List<List<int>> img1, List<List<int>> img2) {
    List<List<int>> va = [].map((e) => <int>[]).toList();
    List<List<int>> vb = [].map((e) => <int>[]).toList();
    int rows = img1.length, cols = img1[0].length;
    for (int i = 0; i < rows; i++) {
      for (int j = 0; j < cols; j++) {
        if (img1[i][j] != 0) va.add([i, j]);
        if (img2[i][j] != 0) vb.add([i, j]);
      }
    }
    HashMap<String, int> mp = HashMap();
    for (var pa in va) {
      for (var pb in vb) {
        String s =
            (pa[0] - pb[0]).toString() + " " + (pa[1] - pb[1]).toString();
        if (mp[s] != null) {
          mp[s]! + 1;
        }
      }
    }
    int res = 0;
    for (var it in mp.entries) res = max(res, it.value);
    return res;
  }
}
