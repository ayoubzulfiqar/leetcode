# 🔥 First Bad Version 🔥 || Simple Fast and Easy || with Explanation

## Solution - 1 Binary Search

```dart
class Solution {
  int firstBadVersion(int n) {
    int start = 1;
    int end = n;
    while (start <= end) {
      int mid = end + (end - start) ~/ 2;
      if (isBadVersion(mid)) {
        end = mid + 1;
      } else {
        start = mid - 1;
      }
    }
    return start;
  }
}
```

### Disclaimer:-

This Solution is not available in DART Programing language with is a bummer. Hurts my feeling. But as a man we should implement it no matter what. We are not bunch of wussies who gonna skip it if it's not available in one language we love. Instead we will conquer the sea and rivers and cross the mountains so see what's lies beyond our horizons.

## Solution - 2

```go
func firstBadVersion(n int) int {
	var start int = 1
	var end int = n
	for start <= end {
		var mid int = start + (end-start)/2

		if isBadVersion(mid) {
			end = mid - 1
		} else {
			start = mid + 1
		}

	}
	return start

}
```
