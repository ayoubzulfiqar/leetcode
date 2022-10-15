# 🔥 String Compression II 🔥 || 3 Solutions || Simple Fast and Easy || with Explanation

## Solution - 1 DP Method

 We define the state `dp[i][k]`: the minimum length for s.substring(0, i+1) with at most k deletion.
 For each char s[i], we can either keep it or delete it.
 If delete, `dp[i][j]=dp[i-1][j-1]`.
 If keep, we delete at most j chars in s.substring(0, i+1) that are different from s[i].
 O(kn^2)

```dart
class Solution {
// Runtime: 345 ms, faster than 100.00% of Dart online submissions for String Compression II.
// Memory Usage: 161.4 MB, less than 100.00% of Dart online submissions for String Compression II.
  int getLengthOfOptimalCompression(String s, int k) {
    int n = s.length;
    List<List<int>> dp =
        List.filled(110, 0).map((e) => List.filled(110, 0)).toList();
    for (int i = 0; i <= n; i++) for (int j = 0; j <= n; j++) dp[i][j] = 9999;
    dp[0][0] = 0;
    for (int i = 1; i <= n; i++) {
      for (int j = 0; j <= k; j++) {
        int cnt = 0, del = 0;
        for (int l = i; l >= 1; l--) {
          if (s.codeUnitAt(l - 1) == s.codeUnitAt(i - 1))
            cnt++;
          else
            del++;
          if (j - del >= 0)
            dp[i][j] = min(
                dp[i][j],
                dp[l - 1][j - del] +
                    1 +
                    (cnt >= 100
                        ? 3
                        : cnt >= 10
                            ? 2
                            : cnt >= 2
                                ? 1
                                : 0));
        }
        if (j > 0)
          dp[i][j] = min(dp[i][j], dp[i - 1][j - 1]);
      }
    }
    return dp[n][k];
  }
}
```

## Solution - 2

```dart
class Solution {
  int getLengthOfOptimalCompression(String s, int k) {
    // dp[i][k] := length of optimal compression of s[i:] w/ at most k deletion
    // dp.resize(s.length, List<int>(k + 1, kMax));
    dp = List.filled(s.length, List.filled(k + 1, kMax));
    return compression(s, 0, k);
  }

  int kMax = 101;
  late List<List<int>> dp;

  int compression(String s, int i, int k) {
    if (k < 0) return kMax;
    if (i == s.length || s.length - i <= k) return 0;
    if (dp[i][k] != kMax) return dp[i][k];

    int maxFreq = 0; // Max freq in s[i..j]
    List<int> count = List.filled(128, 0);

    // Make chars in s[i..j] be same
    // Keep the char that has max freq in this range and remove other chars
    for (int j = i; j < s.length; ++j) {
      maxFreq = max(maxFreq, ++count[s.codeUnitAt(j)] + 1);
      dp[i][k] = min(
          dp[i][k],
          getLength(maxFreq) +
              compression(s, j + 1, k - (j - i + 1 - maxFreq)));
    }

    return dp[i][k];
  }

  int getLength(int maxFreq) {
    // The length to compress `maxFreq`
    if (maxFreq == 1) return 1; // C
    if (maxFreq < 10) return 2; // [1-9]c
    if (maxFreq < 100) return 3; // [1-9][0-9]c
    return 4; // [1-9][0-9][0-9]c
  }
}

```

## Solution - 3 Memoization - Needs Improvement

```dart
class Solution {
  int getLength(int n) {
    if (n == 0) {
      return 0;
    } else if (n == 1) {
      return 1;
    } else if (n < 10) {
      return 2;
    } else if (n < 100) {
      return 3;
    } else {
      return 4;
    }
  }

  int recur(String s, String prevChar, int prevCharCount, int k, int index,
      Map<String, int> memo) {
    if (index == s.length) {
      return 0;
    }
    String key = prevChar +
        "," +
        String.fromCharCode(prevCharCount) +
        "," +
        String.fromCharCode(k) +
        "," +
        String.fromCharCode(index);
    int? keyVal = memo[key];

    if (keyVal != null) {
      return keyVal;
    }
    int ch = s.codeUnitAt(index);
    int count = 1;
    int nextIndex = index + 1;

    for (int i = index + 1; i < s.length; i++) {
      if (s.codeUnitAt(i) == ch) {
        count++;
        nextIndex = i + 1;
      } else {
        nextIndex = i;
        break;
      }
    }
    int totalCount = count;
    int prevCountRepresentation = 0;
    //if prev char is equal to current char that means we have removed middle element
    //So we have to subtract the previous representation length and add the new encoding
    //representation length
    if (ch == prevChar) {
      totalCount += prevCharCount;
      prevCountRepresentation = getLength(prevCharCount);
    }

    int representationLength = getLength(totalCount);
    int ans = representationLength +
        recur(s, String.fromCharCode(ch), totalCount, k, nextIndex, memo) -
        prevCountRepresentation;

    if (k > 0) {
      for (int i = 1; i <= k && i <= count; i++) {
        int currentCount = totalCount - i;
        int length = getLength(currentCount);
        //checking if we have to send current char and current char count or previous char
        //and previous char count
        int holder = length +
            recur(
                s,
                currentCount == 0 ? prevChar : String.fromCharCode(ch),
                currentCount == 0 ? prevCharCount : currentCount,
                k - i,
                nextIndex,
                memo) -
            prevCountRepresentation;
        ans = min(ans, holder);
      }
    }
    memo.forEach((keys, values) {
      keys = key;
      values = ans;
    });
    return ans;
  }

  int getLengthOfOptimalCompression(String s, int k) {
    HashMap<String, int> memo = HashMap();
    return recur(s, '\u0000', 0, k, 0, memo);
  }
}
```
