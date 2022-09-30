# 🔥 Excel Sheet Column Number 🔥 || 5 Solutions || Simple Fast and Easy || with Explanation

## Working Solutions

### Solution - 1

```dart
class Solution {
// Runtime: 656 ms, faster than 60.00% of Dart online submissions for Excel Sheet Column Number.
// Memory Usage: 158.5 MB, less than 40.00% of Dart online submissions for Excel Sheet Column Number.

  int titleToNumber(String columnTitle) {
    // Initialize the output result...
    int result = 0;
    // Traverse the whole list through the loop...
    for (int i = 0; i < columnTitle.length; i++) {
      // Process to get the excel sheet column number...
      result *= 26;
      result += columnTitle[i].codeUnitAt(0) - 'A'.codeUnitAt(0) + 1;
    }
    return result;
  }
}
```

### Solution - 2

```dart
class Solution {
// Runtime: 693 ms, faster than 40.00% of Dart online submissions for Excel Sheet Column Number.
// Memory Usage: 148.3 MB, less than 60.00% of Dart online submissions for Excel Sheet Column Number.

  int titleToNumber(String columnTitle) {
    return columnTitle.length == 0
        ? 0
        : (columnTitle.codeUnitAt(columnTitle.length - 1) -
                'A'.codeUnitAt(0) +
                1) +
            26 *
                titleToNumber(columnTitle.substring(0, columnTitle.length - 1));
  }
}
```

### Solution - 3

```dart
class Solution {
// Runtime: 726 ms, faster than 20.00% of Dart online submissions for Excel Sheet Column Number.
// Memory Usage: 148.7 MB, less than 60.00% of Dart online submissions for Excel Sheet Column Number.
  int titleToNumber(String columnTitle) {
    int ans = 0;

    for (int i = 0; i < columnTitle.length; i++) {
      ans *= 26;
      int c = columnTitle.codeUnitAt(i);
      int n = (c - 'A'.codeUnitAt(0) + 1);
      ans += n;
    }
    return ans;
  }
}
```

## Time Limit Exceeded

### Solution - 1 TLC

```dart
class Solution {
// Time Limit exceeds
  int titleToNumber(String columnTitle) {
    int sum = 0;
    for (String ch in columnTitle.split("")) {
      int diff = ch.codeUnitAt(0) - ('A'.codeUnitAt(0) - 1);
      sum = sum * 26 + diff;
    }
    return sum;
  }
}
```

### Solution - 2 TLC

Idea:
Similar to our decimal representation on base 10, the excel column title also has similar representation but with base 26.

In decimal representation, for example, 123 would mean 1x10^2 + 2x10^1 + 3x10^0
In excel column title, for example, ABC would mean 1x26^2 + 2x26^1 + 3x26^0

We can use charCodeAt to convert letter to number, but it is offset by 64, so we need to subtract 64.
Then we can use the representation from above to find the sum

```dart
class Solution {
  int titleToNumber(String columnTitle) {
    int sum = 0;
    for (int i = 0; i < columnTitle.length; i++) {
      int letter2Num = columnTitle.codeUnitAt(i) - 64;
      sum = (sum + pow(26, columnTitle.length - 1 - i) * letter2Num).toInt();
    }

    return sum;
  }
}
```
