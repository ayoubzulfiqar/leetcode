/*

139. Word Break


Given a string s and a dictionary of strings wordDict, return true if s can be segmented into a space-separated sequence of one or more dictionary words.

Note that the same word in the dictionary may be reused multiple times in the segmentation.

 

Example 1:

Input: s = "leetcode", wordDict = ["leet","code"]
Output: true
Explanation: Return true because "leetcode" can be segmented as "leet code".
Example 2:

Input: s = "applepenapple", wordDict = ["apple","pen"]
Output: true
Explanation: Return true because "applepenapple" can be segmented as "apple pen apple".
Note that you are allowed to reuse a dictionary word.
Example 3:

Input: s = "catsandog", wordDict = ["cats","dog","sand","and","cat"]
Output: false
 

Constraints:

1 <= s.length <= 300
1 <= wordDict.length <= 1000
1 <= wordDict[i].length <= 20
s and wordDict[i] consist of only lowercase English letters.
All the strings of wordDict are unique.

*/

//----------- Binary Search
class Solution {
  bool wordBreak(String s, List<String> wordDict) {
    final int n = s.length;
    final int m = wordDict.length;
    final List<bool> dp = List.filled(n + 1, false);
    dp[0] = true;

    wordDict.sort();

    for (int i = 0; i < n; i++) {
      if (!dp[i]) {
        continue;
      }
      for (int j = i + 1; j <= n; j++) {
        String subS = s.substring(i, j);
        int index = _binarySearchLeft(wordDict, subS);
        if (index == m) {
          break;
        }
        final String word = wordDict[index];
        if (word == subS) {
          dp[i + word.length] = true;
        } else if (word.compareTo(subS) < 0) {
          break;
        }
      }
      if (dp[n]) {
        break;
      }
    }
    return dp[n];
  }

  int _binarySearchLeft(List<String> wordDict, String target) {
    int low = 0;
    int high = wordDict.length;
    while (low < high) {
      final int mid = low + (high - low) ~/ 2;
      if (wordDict[mid].compareTo(target) < 0) {
        low = mid + 1;
      } else {
        high = mid;
      }
    }
    return low;
  }
}

// --------- Union Find
class DisjointSet {
  late List<int> roots;
  late List<int> rank;

  DisjointSet(int n) {
    roots = List<int>.filled(n, 0);
    rank = List<int>.filled(n, 0);
    for (int i = 0; i < n; i++) {
      roots[i] = i;
      rank[i] = 0;
    }
  }

  int find(int x) {
    if (roots[x] == x) {
      return x;
    }
    List<int> s = [];
    while (roots[x] != x) {
      s.add(x);
      x = roots[x];
    }
    while (s.isNotEmpty) {
      roots[s.removeLast()] = x;
    }
    return x;
  }

  bool isConnected(int x, int y) {
    return find(x) == find(y);
  }

  void union(int x, int y) {
    int rX = find(x);
    int rY = find(y);
    if (rX == rY) {
      return;
    }
    if (rank[rX] > rank[rY]) {
      roots[rY] = rX;
    } else if (rank[rX] < rank[rY]) {
      roots[rX] = rY;
    } else {
      roots[rY] = rX;
      rank[rX]++;
    }
  }

  int countRoots() =>
      Iterable<int>.generate(roots.length, (x) => find(x)).toSet().length;
}

class A {
  bool wordBreak(String s, List<String> wordDict) {
    final DisjointSet disjointSet = DisjointSet(s.length + 1);
    for (int i = 0; i < wordDict.length; i++) {
      for (int j = 0; j < s.length; j++) {
        bool isValid = true;
        for (int k = 0; k < wordDict[i].length; k++) {
          if (j + k >= s.length) {
            isValid = false;
            break;
          }
          if (wordDict[i][k] != s[j + k]) {
            isValid = false;
            break;
          }
        }
        if (isValid) {
          disjointSet.union(j, j + wordDict[i].length);
        }
      }
    }
    return disjointSet.isConnected(0, s.length);
  }
}

class C {
  bool wordBreak(String s, List<String> wordDict) {
    Set<String> st = Set<String>.from(wordDict);
    List<bool> dp = List<bool>.filled(s.length, false);

    for (int i = 0; i < s.length; i++) {
      String temp = '';
      for (int j = i; j < s.length; j++) {
        temp += s[j];
        if (st.contains(temp)) {
          if (i == 0) {
            dp[j] = true;
          } else {
            dp[j] = dp[i - 1] || dp[j];
          }
        }
      }
    }

    return dp[s.length - 1];
  }
}
