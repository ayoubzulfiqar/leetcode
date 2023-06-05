# 🔥 Number to Hex 🔥 || Simple Fast and Easy || with Explanation

## Solution - 1

```dart
String toHex(int num) {
  return (num < 0)
      ? (num.toUnsigned(32)).toRadixString(16)
      : num.toRadixString(16);
}
```

### Extra - Avoid It (Not-Optimized)

```dart
extension ToHex on int {
  String toHex() {
    return (this < 0)
        ? (this.toUnsigned(32)).toRadixString(16)
        : this.toRadixString(16);
  }
}
```

## Solution - 2

```dart
String toHexString(int num) {
  if (num == 0) {
    return "0";
  }

  int n = num.toUnsigned(32);
  final String ref = "0123456789abcdef";

  String result = "";

  while (n != 0) {
    result = ref[n & 0xF] + result;
    n >>= 4;
  }

  return result;
}
```

### Extra (Optimized Version - BitManipulation)

```dart
extension ToHex on int {
  String toHexString(int num) {
    if (num == 0) {
      return "0";
    }

    int n = num.toUnsigned(32);
    final String ref = "0123456789abcdef";

    String result = "";

    while (n != 0) {
      result = ref[n & 0xF] + result;
      n >>= 4;
    }

    return result;
  }
}
```

### Bonus

To Use on Any Number In Our case we can use only on int.
But for bonus I have implemented for both double as well as int.
InShort For NUM use can use DART Generics if you want but not recommended

### [Source](https://github.com/ayoubzulfiqar/dart-utils/blob/main/extensions/to_hex.dart)

### [GitHub](https://github.com/ayoubzulfiqar/leetcode)
