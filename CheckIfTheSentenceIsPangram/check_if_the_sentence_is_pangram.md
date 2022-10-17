# 🔥 Check if the Sentence Is Pangram 🔥 || 5 Solutions || Simple Fast and Easy || with Explanation

## Solution - 1 Frequency Array

### Approach

Create a bool vector mark[] of size 26.
Iterate through all characters of the string str and mark str[i] – ‘a’ or str[i] – ‘A’ as 1 for lower and upper characters respectively.
Iterate through all the indices of mark[]
If all indices are marked visited then return is a Pangram
Else return  is not a Pangram.

- Time Complexity: O(n), where n is the length of our string
- Auxiliary Space: O(1), as 26 size Boolean vector is constant.

```dart
class Solution {
// Runtime: 615 ms, faster than 16.67% of Dart online submissions for Check if the Sentence Is Pangram.
// Memory Usage: 141.4 MB, less than 50.00% of Dart online submissions for Check if the Sentence Is Pangram.
  bool checkIfPangram(String sentence) {
    // Create a hash table to mark the
    // characters present in the string
    // By default all the elements of
    // mark would be false.
    List<bool> mark = List.filled(26, false);

    // For indexing in mark[]
    int index = 0;

    // Traverse all characters
    for (int i = 0; i < sentence.length; i++) {
      // If uppercase character, subtract 'A'
      // to find index.
      if ('A'.codeUnitAt(0) <= sentence.codeUnitAt(i) &&
          sentence.codeUnitAt(i) <= 'Z'.codeUnitAt(0))
        index = sentence.codeUnitAt(i) - 'A'.codeUnitAt(0);

      // If lowercase character, subtract 'a'
      // to find index.
      else if ('a'.codeUnitAt(0) <= sentence.codeUnitAt(i) &&
          sentence.codeUnitAt(i) <= 'z'.codeUnitAt(0))
        index = sentence.codeUnitAt(i) - 'a'.codeUnitAt(0);

      // If this character is other than english
      // lowercase and uppercase characters.
      else
        continue;
      mark[index] = true;
    }

    // Return false if any character is unmarked
    for (int i = 0; i <= 25; i++) if (mark[i] == false) return (false);

    // If all characters were present
    return (true);
  }
}
```

## Solution - 2

```dart
class Solution {
import 'dart:collection';

// Runtime: 424 ms, faster than 100.00% of Dart online submissions for Check if the Sentence Is Pangram.
// Memory Usage: 143.3 MB, less than 33.33% of Dart online submissions for Check if the Sentence Is Pangram.
  bool checkIfPangram(String sentence) =>
      'z'.codeUnitAt(0) - 'a'.codeUnitAt(0) + 1 ==
      HashSet.from(sentence.split('')).length;
}
```

## Solution - 3 HashSet

```dart
import 'dart:collection';

class Solution {
// Runtime: 325 ms, faster than 100.00% of Dart online submissions for Check if the Sentence Is Pangram.
// Memory Usage: 162.3 MB, less than 16.67% of Dart online submissions for Check if the Sentence Is Pangram.
  bool checkIfPangram(String sentence) {
    HashSet<String> hashset = HashSet();
    for (int i = 0; i < sentence.length; i++) {
      hashset.add(sentence[i]);
    }
    if (hashset.length == 26) {
      return true;
    }
    return false;
  }
}
```

## Solution - 4

```dart
import 'dart:collection';

class Solution {
// Runtime: 508 ms, faster than 100.0% of Dart online submissions for Check if the Sentence Is Pangram.
// Memory Usage: 146.4 MB, less than 16.67% of Dart online submissions for Check if the Sentence Is Pangram.
  bool checkIfPangram(String sentence) {
    HashMap<String, int> hm = HashMap();
    for (int i = 0; i < sentence.length; i++) {
      hm.addEntries([MapEntry(sentence[i], 0)]);
    }
    if (hm.length == 26) {
      return true;
    }
    return false;
  }
}
```

## Solution - 5 Beautiful Regex

```dart
class Solution {
  bool checkIfPangram(String sentence) {
    return RegExp(
            r"(?=.*a)(?=.*b)(?=.*c)(?=.*d)(?=.*e)(?=.*f)(?=.*g)(?=.*h)(?=.*i)(?=.*j)(?=.*k)(?=.*l)(?=.*m)(?=.*n)(?=.*o)(?=.*p)(?=.*q)(?=.*r)(?=.*s)(?=.*t)(?=.*u)(?=.*v)(?=.*w)(?=.*x)(?=.*y)(?=.*z)")
        .hasMatch(sentence);
  }
}
```
