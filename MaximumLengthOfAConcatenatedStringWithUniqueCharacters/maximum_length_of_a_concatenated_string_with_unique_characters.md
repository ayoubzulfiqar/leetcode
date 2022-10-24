# 🔥 Maximum Length of a Concatenated String with Unique Characters 🔥 || 5 Solutions || with Explanation

## Approach: The idea is to use Recursion

Follow the steps below to solve the problem:

- Iterate from left to right and consider every string as a possible starting substring.
- Initialize a HashSet to store the distinct characters encountered so far.
- Once a string is selected as starting substring, check for every remaining string, if it only contains characters which have not occurred before. Append this string as a substring to the current string being generated.
- After performing the above steps, print the maximum length of a string that has been generated.

### Time Complexity: O(2N)

### Auxiliary Space: O(N * 2N)

## Solution - 1 Recursion

```dart
class Solution {
// Runtime: 779 ms, faster than 100.00% of Dart online submissions for Maximum Length of a Concatenated String with Unique Characters.
// Memory Usage: 173.7 MB, less than 100.00% of Dart online submissions for Maximum Length of a Concatenated String with Unique Characters.

  int maxLength(List<String> arr) {
    return solve(arr, 0, "");
  }

  int solve(List<String> arr, int i, String soFar) {
    if (i == arr.length) {
      if (isValid(soFar)) {
        return soFar.length;
      }
      return 0;
    }

    int size1 = solve(arr, i + 1, soFar);
    int size2 = solve(arr, i + 1, soFar + arr.elementAt(i));

    return max(size1, size2);
  }

  bool isValid(String s) {
    List<int> freq = List.filled(26, 0);

    for (int i = 0; i < s.length; i++) {
      int val = s.codeUnitAt(i) - 'a'.codeUnitAt(0);
      freq[val]++;

      if (freq[val] > 1) {
        return false;
      }
    }

    return true;
  }
}
```

## Solution - 2 Using Queue

```dart
class Solution {
// Runtime: 2126 ms, faster than 100.00% of Dart online submissions for Maximum Length of a Concatenated String with Unique Characters.
// Memory Usage: 207.2 MB, less than 100.00% of Dart online submissions for Maximum Length of a Concatenated String with Unique Characters.

  int maxLength(List<String> arr) {
    List<int> result = List.filled(1, 0);
    maxLengthUnique(arr, result, 0, "");
    return result[0];
  }

  void maxLengthUnique(
      List<String> arr, List<int> result, int index, String current) {
    int i = 0, n = arr.length;

    // We use queue to store all the combinations possible!
    Queue<String> q = Queue();
    q.add("");

    //Loop for all the strings in array.
    while (i < n) {
      int size = q.length;

      //Loop till all the elements in Queue are appended with "" and the string 'str'
      for (int loop = 0; loop < size; loop++) {
        String temp = q.removeFirst(); // temp = ""
        String dontConsider = temp; // dontConsider = ""
        String consider = temp +
            arr.elementAt(
                i); // consider = "un" --> Aboe 3 steps Repeated till the last element.

        // Function call to calculate the unique characters
        if (uniqueCharacters(dontConsider) > result[0]) {
          result[0] = dontConsider.length;
        }
        // Function call to calculate the unique characters
        if (uniqueCharacters(consider) > result[0]) {
          result[0] = consider.length;
        }
        // Adding the new strings to our queue again.
        q.add(dontConsider);
        q.add(consider);
      }
      i++;
    }
  }

  int uniqueCharacters(String string) {
    List<int> alpha = List.filled(26, 0);

    for (String character in string.split(""))
      if (alpha[character.codeUnitAt(0) - 'a'.codeUnitAt(0)]++ > 0) return -1;

    return string.length;
  }
}
```

## Solution - 3 - BackTracking

```dart
class Solution {
  // BackTracking
//Runtime: 589 ms, faster than 100.00% of Dart online submissions for Maximum Length of a Concatenated String with Unique Characters.
// Memory Usage: 148.7 MB, less than 100.00% of Dart online submissions for Maximum Length of a Concatenated String with Unique Characters.

  int max = 0;
  int maxLength(List<String> arr) {
    backTrack(arr, "", 0);
    return max;
  }

  void backTrack(List<String> arr, String current, int start) {
    if (max < current.length) max = current.length;
    for (int i = start; i < arr.length; i++) {
      if (!isValid(current, arr.elementAt(i))) continue;
      backTrack(arr, current + arr.elementAt(i), i + 1);
    }
  }

  bool isValid(String currentString, String newString) {
    List<int> array = List.filled(26, 0);
    for (int i = 0; i < newString.length; i++) {
      if (++array[newString.codeUnitAt(i) - 'a'.codeUnitAt(0)] == 2)
        return false;
      if (currentString.contains(
        newString[i] + "",
      )) return false;
    }
    return true;
  }
}
```

## Solution - 4 Depth First Search DFS

```dart
class Solution {
// Runtime: 598 ms, faster than 100.00% of Dart online submissions for Maximum Length of a Concatenated String with Unique Characters.
// Memory Usage: 152.3 MB, less than 100.00% of Dart online submissions for Maximum Length of a Concatenated String with Unique Characters.
  int result = 0;
  int maxLength(List<String> arr) {
    if (arr.isEmpty || arr.length == 0) {
      return 0;
    }

    dfs(arr, "", 0);

    return result;
  }

  void dfs(List<String> arr, String path, int idx) {
    bool isUniqueChar = isUniqueChars(path);

    if (isUniqueChar) {
      result = max(path.length, result);
    }

    if (idx == arr.length || !isUniqueChar) {
      return;
    }

    for (int i = idx; i < arr.length; i++) {
      dfs(arr, path + arr.elementAt(i), i + 1);
    }
  }

  bool isUniqueChars(String s) {
    HashSet<String> hashset = HashSet();

    for (String c in s.split("")) {
      if (hashset.contains(c)) {
        return false;
      }
      hashset.add(c);
    }
    return true;
  }
}
```

## Solution - 5  BitMask

```dart
class Solution {
// Runtime: 479 ms, faster than 100.00% of Dart online submissions for Maximum Length of a Concatenated String with Unique Characters.
// Memory Usage: 141.2 MB, less than 100.00% of Dart online submissions for Maximum Length of a Concatenated String with Unique Characters.
  int maxLength(List<String> arr) {
    int n = arr.length;
    List<int> ans = List.filled(1, 0);
    List<List<int>> bitMap =
        List.filled(n, 0).map((e) => List.filled(2, 0)).toList();
    for (int i = 0; i < n; ++i) {
      int a = 0;
      for (String ch in arr.elementAt(i).split("")) {
        int bit = ch.codeUnitAt(0) - 'a'.codeUnitAt(0);
        if (((a >> bit) & 1) == 1) {
          a = 0;
          break;
        }
        a |= (1 << bit);
      }
      bitMap[i][0] = a;
      bitMap[i][1] = a == 0 ? 0 : arr.elementAt(i).length;
    }
    dfs(arr, bitMap, ans, 0, 0, 0);
    return ans[0];
  }

  void dfs(List<String> arr, List<List<int>> bitMap, List<int> ans, int start,
      int curLen, int curBit) {
    if (ans[0] < curLen) ans[0] = curLen;
    for (int i = start; i < arr.length; ++i) {
      if ((curBit & bitMap[i][0]) != 0) continue;
      dfs(arr, bitMap, ans, i + 1, curLen + bitMap[i][1],
          curBit | bitMap[i][0]);
    }
  }
}
```
