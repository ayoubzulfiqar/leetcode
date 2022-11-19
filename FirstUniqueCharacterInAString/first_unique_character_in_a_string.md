# 🔥 First Unique Character in a String 🔥 || 3 Approaches || Simple Fast and Easy || with Explanation

## Solution - 1 HashMap

```dart
class Solution {
  int firstUniqChar(String s) {
    // hashmap to store the unique values
    HashMap<String, int?> map = HashMap();
    // looping through each and every element in the String
    for (int i = 0; i < s.length; i++) {
      // assigning the int as index for every element
      map[s[i]] = (map[s[i]] ?? 0) + 1;
    }
    // looping again
    for (int i = 0; i < s.length; i++) {
      // if the element matches with index value as saved above
      if (map[s[i]] == 1) {
        // than we will return that element
        return i;
      }
    }
    // sentinel value
    return -1;
  }
}
```

## Solution - 2 Frequency Array

```dart
class Solution {
  int firstUniqChar(String s) {
    // index as ans
    int ans = 0;
    // into array list of each and every character
    List<String> chars = s.split("");
    // if that character is inside the array of character
    for (String char in chars) {
      // comparing first to last index
      if (s.indexOf(char) == s.lastIndexOf(char)) {
        // assigning the index to our value
        return ans = s.indexOf(char);
      } else {
        ans = -1;
      }
    }
    return ans;
  }
}

```

## Solution - 3

```dart
class Solution {
  int firstUniqChar(String s) {
    // frequency of array based on the length of alphabets inn ENGLISH
    List<int> freq = List.filled(26, 0);
    // looping through the length of string
    for (int i = 0; i < s.length; i++)
      // getting the index of the each individual string character
      freq[s.codeUnitAt(i) - 'a'.codeUnitAt(0)]++;
    for (int i = 0; i < s.length; i++)
      // if it matches with index we will return
      if (freq[s.codeUnitAt(i) - 'a'.codeUnitAt(0)] == 1) return i;
    return -1;
  }
}
```
