/*


 -* Maximum Length of a Concatenated String with Unique Characters *-

 You are given an array of strings arr. A string s is formed by the concatenation of a subsequence of arr that has unique characters.

Return the maximum possible length of s.

A subsequence is an array that can be derived from another array by deleting some or no elements without changing the order of the remaining elements.



Example 1:

Input: arr = ["un","iq","ue"]
Output: 4
Explanation: All the valid concatenations are:
- ""
- "un"
- "iq"
- "ue"
- "uniq" ("un" + "iq")
- "ique" ("iq" + "ue")
Maximum length is 4.
Example 2:

Input: arr = ["cha","r","act","ers"]
Output: 6
Explanation: Possible longest valid concatenations are "chaers" ("cha" + "ers") and "acters" ("act" + "ers").
Example 3:

Input: arr = ["abcdefghijklmnopqrstuvwxyz"]
Output: 26
Explanation: The only string in arr has all 26 characters.


Constraints:

1 <= arr.length <= 16
1 <= arr[i].length <= 26
arr[i] contains only lowercase English letters.


*/
import 'dart:collection';
import 'dart:math';

class A {
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

class B {
  // Recursion
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

class C {
  // Depth First Search
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

class D {
// BitMask
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

class E {
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
