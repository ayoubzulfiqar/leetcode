# 🔥 Dart 🔥 || 4 solutions || line by line explanation

## Solution - 1

```dart
class Solution {
// Runtime: 762 ms, faster than 10.00% of Dart online submissions for Reverse Words in a String III.
// Memory Usage: 174.5 MB, less than 10.00% of Dart online submissions for Reverse Words in a String III.
  String reverseWords(String s) {
    if (s.length == 1) return s;
    String reversed = "";
    String current_word = "";
    int num_spaces = 0;
    for (int i = 0; i < s.length; ++i) {
      String c = s[i];
      if (c == ' ') {
        if (!reversed.isEmpty) {
          reversed = reversed + ' ' + current_word;
        } else {
          reversed = current_word;
        }
        current_word = "";
        num_spaces++;
      } else {
        current_word = c + current_word;
      }
    }
    // if its a string with multiple words vs a single word
    if (num_spaces != 0) {
      reversed += ' ' + current_word;
    } else {
      reversed = current_word;
    }
    return reversed;
  }
}
```

## Solution - 2

```dart
class Solution {
  // O(n)
// Runtime: 399 ms, faster than 100.00% of Dart online submissions for Reverse Words in a String III.
// Memory Usage: 155.1 MB, less than 10.00% of Dart online submissions for Reverse Words in a String III.
  String reverseWords(String s) {
    String res = '';
    String word = '';
    for (var c in s.split('')) {
      if (c == ' ') {
        res += word + c;
        word = '';
      } else {
        word = c + word;
      }
    }
    return res + word;
  }
}
```

## Solution - 3

```dart
class Solution {
  // O(n)
// Runtime: 355 ms, faster than 100.00% of Dart online submissions for Reverse Words in a String III.
// Memory Usage: 166.9 MB, less than 10.00% of Dart online submissions for Reverse Words in a String III.
  String reverseWords(String s) {
    return s
        .toString()
        .split(' ')
        .map((e) => e.split('').reversed.join(''))
        .join(' ');
  }
}
```

## Solution - 4 Two Pointer

```dart
class Solution {
// Runtime: 431 ms, faster than 80.00% of Dart online submissions for Reverse Words in a String III.
// Memory Usage: 146.7 MB, less than 100.00% of Dart online submissions for Reverse Words in a String III.
  String reverseWords(String s) {
    int len = s
        .length; // saving the length as constant so as to avoid calling s.length() again and again.

    if (len == 1) // no need to iterate if string is of length 1
      return s;

    int firstIndex, lastIndex;
    List<String> ch = s.split(
        ''); // converting the string into it's corresponding character array
    // var ch = s.codeUnits;
    var temp;

    for (int index = 0; index < len; index++) {
      firstIndex = index; // store the first index of word

      while (++index < len &&
          ch[index] !=
              ' '); // iterate until space is found i.e. to get the last index of the word

      lastIndex = index - 1; // store the last index of the word

      // reverse characters of the word
      while (firstIndex < lastIndex) {
        temp = ch[firstIndex];
        ch[firstIndex++] = ch[lastIndex];
        ch[lastIndex--] = temp;
      }
    }

    return ch.join(' '); // convert the character into string and return it
  }
}
```

## Bonus Solution - Golang

```go
func reverseWords(s string) string {
 // split by space
 w := strings.Split(s, " ")
 // iterate each word
 for k, v := range w {
  // convert to bytes array
  b := []byte(v)
  // length of current word
  n := len(v)
  // for each word, we iterate n / 2 times
  for i := 0; i < n/2; i++ {
   // swap the characters
   b[i], b[n-1-i] = b[n-1-i], b[i]
   // w[k] here is the reversed version of v
   w[k] = string(b)
  }
 }
 // build the final string
 return strings.Join(w, " ")
}
```

```go
func reverseWords(s string) string {
 byteArr := []byte(s)
 low, high := 0, len(byteArr)-1
 for low < high{
  tmp := byteArr[low]
  byteArr[low] = byteArr[high]
  byteArr[high] = tmp
  low++
  high--
 }

 arr := strings.Split(string(byteArr), " ")

 l, h := 0, len(arr)-1
 for l<h{
  t := arr[l]
  arr[l] = arr[h]
  arr[h] = t
  l++
  h--
 }

 return strings.Join(arr, " ")
}
```
