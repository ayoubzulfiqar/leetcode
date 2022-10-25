# 🔥 Check If Two String Arrays are Equivalent 🔥 || 3 Solutions || Simple Fast and Easy || with Explanation

## Approach Used: Arrays traversal, String comparison

### Explanation

This a very basic question. It is a beginner-friendly question which requires not much logic. We simply need to combine all the substrings in the array into one combines string for both the arrays. The order of combining should not change. After we get both the combined substring, we’ll simply compare them and return true is all the characters match, otherwise false.

### Complexity

#### Space Complexity: O(m+n) where m and n will be total characters present in array1 and array2 respectively

#### Time Complexity: O(a+b) where a and b are the length of both arrays

## Solution - 1

```dart
class Solution {
// Runtime: 422 ms, faster than 100.00% of Dart online submissions for Check If Two String Arrays are Equivalent.
// Memory Usage: 141.7 MB, less than 33.33% of Dart online submissions for Check If Two String Arrays are Equivalent.
  bool arrayStringsAreEqual(List<String> word1, List<String> word2) {
    return word1.join("") == word2.join("");
  }
}
```

## Solution - 2

```dart
class Solution {
  bool arrayStringsAreEqual(List<String> word1, List<String> word2) {
    int firstPointer = 0, secondPointer = 0; // inner pointer
    int firstWord = 0, secondWord = 0; // outer pointer

    while (firstWord < word1.length && secondWord < word2.length) {
      String firstString = word1[firstWord], secondString = word2[secondWord];

      if (firstString.codeUnitAt(firstPointer) !=
          secondString.codeUnitAt(secondPointer)) return false;

      if (firstPointer < firstString.length - 1) {
        firstPointer++;
      } else {
        firstPointer = 0;
        firstWord++;
      }

      if (secondPointer < secondString.length - 1) {
        secondPointer++;
      } else {
        secondPointer = 0;
        secondWord++;
      }
    }

    return firstWord == word1.length && secondWord == word2.length;
  }
}
```

## Solution - 3

```dart
class Solution {
  bool arrayStringsAreEqual(List<String> word1, List<String> word2) {
    StringBuffer sb1 = StringBuffer();
    StringBuffer sb2 = StringBuffer();
    for (String s in word1) {
      sb1.write(s);
    }
    for (String s in word2) {
      sb2.write(s);
    }
    return sb1.toString() == (sb2.toString());
  }
}
```
