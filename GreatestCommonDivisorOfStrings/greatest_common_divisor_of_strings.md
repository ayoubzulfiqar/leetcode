# 🔥 3 Approaches 🔥 || Simple Fast and Easy || with Explanation

### Approach

str1+str2 == str2+str1 if and only if str1 and str2 have a gcd .
E.g. str1=abcabc, str2=abc, then str1+str2 = abcabcabc = str2+str1
This(str1+str2==str2+str1) is a requirement for the strings to have a gcd. If one of them is NOT a common part then gcd is "".It means we will return empty string
Proof:-str1 = mGCD, str2 = nGCD, str1 + str2 = (m + n)GCD = str2 + str1
Both the strings are made of same substring added multiple times.
Since they are multiples, next step is simply to find the gcd of the lengths of 2 strings e.g. gcd(6,3) = 3, (we can use gcd function to find that)and get the substring of length 3 from either str1 or str2.

### Code - 1

```dart
class Solution {
  String gcdOfStrings(String str1, String str2) {
    return (str1 + str2 == str2 + str1)
        ? str1.substring(0, str1.length.gcd(str2.length))
        : "";
  }
}
```

## Code - 2

```dart
class Solution {
  bool cal(String str, String ans) {
    int n = str.length;
    int m = ans.length;
    int idx = 0;
    for (int i = 0; i < n; i++) {
      if (str[i] != ans[idx]) return false;
      idx++;
      idx %= m;
    }
    return true;
  }

  String gcdOfStrings(String str1, String str2) {
    int n = str1.length;
    int m = str2.length;
    int ss = n.gcd(m);
    String ans = str1.substring(0, ss);
    if (cal(str1, ans) && cal(str2, ans)) return ans;
    return "";
  }
}
```

## Code - 3 Brute Force

```dart
class Solution {
  String gcdOfStrings(String str1, String str2) {
    String ans = "";
    for (int i = 0; i < str2.length; i++) {
      String cur = str2.substring(0, i + 1);
      List<String> curArray = str2.split(cur);
      bool flag = true;
      for (int j = 0; j < curArray.length; j++) {
        if (curArray[j] != "") {
          flag = false;
          break;
        }
      }
      if (flag) {
        List<String> cur2Array = str1.split(cur);
        for (int j = 0; j < cur2Array.length; j++) {
          if (cur2Array[j] != "") {
            flag = false;
            break;
          }
        }
        if (flag) {
          ans = cur;
        }
      }
    }
    return ans;
  }
}
```
