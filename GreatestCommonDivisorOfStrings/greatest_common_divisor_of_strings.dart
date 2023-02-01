/*



-* 1071. Greatest Common Divisor of Strings *-


For two strings s and t, we say "t divides s" if and only if s = t + ... + t (i.e., t is concatenated with itself one or more times).

Given two strings str1 and str2, return the largest string x such that x divides both str1 and str2.

 

Example 1:

Input: str1 = "ABCABC", str2 = "ABC"
Output: "ABC"
Example 2:

Input: str1 = "ABABAB", str2 = "ABAB"
Output: "AB"
Example 3:

Input: str1 = "LEET", str2 = "CODE"
Output: ""
 

Constraints:

1 <= str1.length, str2.length <= 1000
str1 and str2 consist of English uppercase letters.

*/
class A {
  String gcdOfStrings(String str1, String str2) {
    return (str1 + str2 == str2 + str1)
        ? str1.substring(0, str1.length.gcd(str2.length))
        : "";
  }
}

class B {
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

class C {
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
