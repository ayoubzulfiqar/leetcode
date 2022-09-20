# 🔥 Dart 🔥 || Simple and fast Solution

## Solution - 1

```dart
class Solution {
// Runtime: 375 ms, faster than 68.57% of Dart online submissions for Pascal's Triangle.
// Memory Usage: 140.6 MB, less than 45.71% of Dart online submissions for Pascal's Triangle.
  List<List<int>> generate(int numRows) {
    List<List<int>> pascal =
        List.filled(numRows, 0).map((e) => List.filled(numRows, 0)).toList();
    for (var i = 0; i < numRows; i++) {
      pascal[i] = List.filled(i + 1, 1);
      for (var j = 1; j < i; j++) {
        pascal[i][j] = pascal[i - 1][j - 1] + pascal[i - 1][j];
      }
      pascal[i][i] = 1;
    }
    return pascal;
  }
}
```

## Solution - 2

```dart
class Solution {
//   Runtime: 347 ms, faster than 80.00% of Dart online submissions for Pascal's Triangle.
// Memory Usage: 157.9 MB, less than 8.57% of Dart online submissions for Pascal's Triangle.
  List<List<int>> generate(int numRows) {
    List<List<int>> ans =
        List.filled(numRows, 0).map((e) => List.filled(numRows, 0)).toList();
    for (int i = 0; i < numRows; i++) {
      List<int> row = List.filled(i + 1, 1);
      int mid = i >> 1;
      for (int j = 1; j <= mid; j++) {
        int val = ans[i - 1][j - 1] + ans[i - 1][j];
        row[j] = val;
        row[row.length - j - 1] = val;
      }
      ans[i] = row;
    }
    return ans;
  }
}
```

## Bonus Solution

```go
func generate(numRows int) [][]int {
 // Runtime: 0 ms, faster than 100.00% of Go online submissions for Pascal's Triangle.
 // Memory Usage: 2.1 MB, less than 55.27% of Go online submissions for Pascal's Triangle.
 ans := [][]int{{1}}

 for i := 0; i < numRows; i++ {
  v := make([]int, i+1)
  v[0] = 1
  v[i] = 1
  for j := 1; j < len(v)-1; j++ {
   v[j] = ans[i][j] + ans[i][j-1]
  }
  ans = append(ans, v)
 }
 return ans[1:]
}
```
