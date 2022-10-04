# 🔥 Isomorphic Strings 🔥 || 3 Solutions || Simple Fast and Easy || with Explanation

## Solution - 1

```dart
class Solution {
// Runtime: 625 ms, faster than 16.13% of Dart online submissions for Isomorphic Strings.
// Memory Usage: 140.6 MB, less than 100.00% of Dart online submissions for Isomorphic Strings.
  bool isIsomorphic(String s, String t) {
    // Base case: for different length of two strings...
    if (s.length != t.length) return false;
    // Create two maps for s & t strings...
    List<int> map1 = List.filled(256, 0);
    List<int> map2 = List.filled(256, 0);
    // Traverse all elements through the loop...
    for (int idx = 0; idx < s.length; idx++) {
      // Compare the maps, if not equal, return false...
      if (map1[s.codeUnitAt(idx)] != map2[t.codeUnitAt(idx)]) return false;
      // Insert each character if string s and t into separate map...
      map1[s.codeUnitAt(idx)] = idx + 1;
      map2[t.codeUnitAt(idx)] = idx + 1;
    }
    return true; // Otherwise return true...
  }
}
```

## Solution - 2

```dart
class C {
// Runtime: 611 ms, faster than 16.13% of Dart online submissions for Isomorphic Strings.
// Memory Usage: 144.2 MB, less than 64.52% of Dart online submissions for Isomorphic Strings.
  bool isIsomorphic(String s, String t) {
    // Second map to hold the value and key of second String (t)
    // First map to hold the value and key of first String (s)
    Map mapS = {}, mapT = {};
    //iterating through each element of the string
    for (int i = 0; i < s.length; i++) {
        // if they both are not null means they have values
      if (mapS[s[i]] != null && mapT[t[i]] != null) {
        // so the first map will hold the each string element individually fo every element
        // base on key and value
        mapS[s[i]] = t[i];
        mapT[t[i]] = s[i];
        // this cause if their value is not same as the element of the each string
      } else if (mapS[s[i]] != t[i] || mapT[t[i]] != s[i]) return false;
    }
    return true;
  }
}
```

## Solution - 3

```go
func isIsomorphic(s string, t string) bool {
	if len(s) != len(t) {
		return false
	}

	m := make(map[byte]byte)
	mt := make(map[byte]byte)

	for i := 0; i < len(s); i++ {
		t1 := t[i]

		if value, ok := m[t1]; ok {
			if value != s[i] {
				return false
			}
		} else {
			m[t1] = s[i]
		}

		s1 := s[i]

		if value, ok := mt[s1]; ok {
			if value != t[i] {
				return false
			}
		} else {
			mt[s1] = t[i]
		}
	}

	return true
}

```
