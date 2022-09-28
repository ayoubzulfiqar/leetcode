# 🔥 DART || Read N Characters Given Read4 Solution || with Explanation

## Reader4 Class

### Or

```dart
// if you don't wanna override
class Reader4 {
  int read4(List<int> buf4){
      return 0;
  }
}
```

```dart
abstract class Reader4 {
  int read4(List<int> buf4);
}
```

```dart
class Solution extends Reader4 {
  int read(List<int> buf, int n) {
    int copyCharIndex = 0;
    int charRead = 4;
    List<int> buf4 = List.filled(4, 0);
    while (copyCharIndex < n && charRead == 4) {
        // charRead = Reader4().read4(buf4)
      charRead = read4(buf4);
      for (var i = 0; i < charRead; i++) {
        if (copyCharIndex == n) {
          return n;
        }
        buf[copyCharIndex++] = buf4[i];
      }
    }
    return copyCharIndex;
  }


// this override is because of abstract class
  @override
  int read4(List<int> buf4) {
    throw UnimplementedError();
  }
}
```

## Solution - 2

```dart
class Solution extends Reader4 {
  int read(List<int> buf, int n) {
    List<int> buf4 = [4];
    int i4 = 0; // buf4's index
    int n4 = 0; // buf4's size
    int i = 0; // buf's index
    while (i < n) {
      if (i4 == n4) {
        // all characters in buf4 are consumed
        i4 = 0; // reset buf4's index
        // charRead = Reader4().read4(buf4)
        n4 = read4(buf4); // read 4 (or less) chars from file to buf4
        if (n4 == 0) // reach the EOF
          return i;
      }
      buf[i++] = buf4[i4++];
    }

    return i;
  }

  @override
  int read4(List<int> buf4) {
    throw UnimplementedError();
  }
}
```
