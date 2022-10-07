# 🔥 Power of Two 🔥 || 5 Solutions || Simple Fast and Easy || with Explanation

## Solution - 1 Bit Manipulation

```dart
class Solution {

  bool isPowerOfTwo(int n) {
    return n > 0 && ((n & (n - 1)) == 0);
  }
}
```

## Solution - 2 Iterative

```dart
class Solution {
  bool isPowerOfTwo(int n) {
    if (n <= 0) return false;
    while (n % 2 == 0) n ~/= 2;
    return n == 1;
  }
}
```

## Solution - 3

```dart
class Solution {
  bool isPowerOfTwo(int n) {
    return n > 0 && (n == 1 || (n % 2 == 0 && isPowerOfTwo(n ~/ 2)));
  }
}
```

## Solution - 4

```dart
class Solution {
  bool isPowerOfTwo(int n) {
    return n > 0 && (1073741824 % n == 0);
  }
}
```

## SOlution - 5

```go
// Runtime: 0 ms, faster than 100.00% of Go online submissions for Power of Two.
// Memory Usage: 2.1 MB, less than 10.91% of Go online submissions for Power of Two.
func isPowerOfTwo(n int) bool {
	return n > 0 && ((n & (n - 1)) == 0)
}
```
