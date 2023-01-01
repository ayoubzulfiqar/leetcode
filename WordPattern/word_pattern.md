# 🔥 Word Pattern 🔥 || Simple Fast and Easy || with Explanation

## Solution - 1

```dart
import 'dart:collection';

class Solution {
  bool wordPattern(String pattern, String s) {
    // s is the sentence so we breaking it into each and  every single word
    List<String> words = s.split('');
    // Two HashMap
    if (words.length != pattern.length) return false;

    HashMap<int, String> firstHashMap = HashMap();
    HashMap<String, bool> secondHashMap = HashMap();

    // looping through each and every character
    for (int i = 0; i < pattern.length; i++) {
      // getting the char code of every pattern
      int char = pattern.codeUnitAt(i);
      // because it has sentence so we taking the each character and making into a a single word
      // to compare with the char
      if (firstHashMap.containsKey(char) == false) {
        if (secondHashMap.containsKey(words[i]) == true) {
          return false;
        } else {
          secondHashMap[words[i]] = true;
          firstHashMap[char] = words[i];
        }
      } else {
        String mWith = firstHashMap[char]!;
        if (mWith.allMatches(words[i]) == false) {
          return false;
        }
      }
    }
    return true;
  }
}
```

## Solution - 2

```dart
import 'dart:collection';

class Solution {
  bool wordPattern(String pattern, String s) {
    // initializing HashMap because it's fast
    final HashMap<String, String> map = HashMap();
    // splitting the sentence into each individual character
    final List<String> words = s.split(' ');
    final List<String> patternWords = pattern.split('');
    // if the length is not same
    if (words.length != patternWords.length) return false;
    // looping through each and every individual pattern word
    for (int i = 0; i < patternWords.length; i++) {
      // if the key is null or empty
      if (map[patternWords[i]] == null) {
        // but value contain it
        if (map.containsValue(words[i])) {
          return false;
        }
        // assign each and every character and word
        map[patternWords[i]] = words[i];
      } else {
        // if they are nt assign than false
        if (map[patternWords[i]] != words[i]) {
          return false;
        }
      }
    }
    return true;
  }
}
```

## BONUS - GOLANG

```go
func wordPattern(pattern string, s string) bool {
	words := strings.Split(s, " ")
	if len(words) != len(pattern) {
		return false
	}
	hashMap := make(map[interface{}]int)
	for i, word := range words {
		if hashMap[word] != hashMap[pattern[i]] {
			return false
		}
		hashMap[word] = i + 1
		hashMap[pattern[i]] = i + 1
	}
	return true
}
```
