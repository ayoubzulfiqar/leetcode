/*



-* 131. Palindrome Partitioning *-

Given a string s, partition s such that every 
substring
 of the partition is a 
palindrome
. Return all possible palindrome partitioning of s.

 

Example 1:

Input: s = "aab"
Output: [["a","a","b"],["aa","b"]]
Example 2:

Input: s = "a"
Output: [["a"]]
 

Constraints:

1 <= s.length <= 16
s contains only lowercase English letters.


*/
class A {
  bool checkPalindrome(String str, int startIndex, int lastIndex) {
    while (startIndex <= lastIndex) {
      if (str.codeUnitAt(startIndex) != str.codeUnitAt(lastIndex)) return false;
      startIndex++;
      lastIndex--;
    }
    return true;
  }

  void palindromePartition(
      int index, List<String> ds, List<List<String>> output, String str) {
    if (index == str.length) {
      // output.add([...ds]..toList());
      output.add([...ds]);
      return;
    }
    for (int i = index; i < str.length; i++) {
      if (checkPalindrome(str, index, i)) {
        ds.add(str.substring(index, i + 1));
        palindromePartition(i + 1, ds, output, str);
        ds.remove(ds.length - 1);
      }
    }
  }

  List<List<String>> partition(String s) {
    List<List<String>> output = <String>[].map((e) => <String>[]).toList();
    List<String> ds = [];
    palindromePartition(0, ds, output, s);
    return output;
  }
}

class B {
  bool isPalindrome(String s) {
    int left = 0, right = s.length - 1;
    while (left <= right) {
      if (s[left] != s[right]) return false;
      left++;
      right--;
    }
    return true;
  }

  void helper(String s, List<String> step, List<List<String>> result) {
    // Base case
    if (s.length == 0) {
      result.add(step.toList());
      return;
    }
    for (int i = 1; i <= s.length; i++) {
      String temp = s.substring(0, i);
      if (!isPalindrome(temp))
        continue; // only do backtracking when current string is palindrome

      step.add(temp); // choose
      helper(s.substring(i, s.length), step, result); // explore
      step.remove(step.length - 1); // un-choose
    }
    return;
  }

  List<List<String>> partition(String s) {
    // Backtracking
    // Edge case
    if (s.length == 0) return [];

    List<List<String>> result = [];
    helper(s, [], result);
    return result;
  }
}

class C {
  bool checkPalindrome(String str, int startIndex, int lastIndex) {
    while (startIndex <= lastIndex) {
      if (str[startIndex] != str[lastIndex]) return false;
      startIndex++;
      lastIndex--;
    }
    return true;
  }

  void palindromePartition(
      int index, List<String> ds, List<List<String>> output, String str) {
    if (index == str.length) {
      output.add(List.filled(ds.length - 1, ""));
      return;
    }
    for (int i = index; i < str.length; i++) {
      if (checkPalindrome(str, index, i)) {
        ds.add(str.substring(index, i - index + 1));
        palindromePartition(i + 1, ds, output, str);
        ds.removeLast();
      }
    }
  }

  List<List<String>> partition(String s) {
    List<List<String>> output = [];
    List<String> ds = [];
    palindromePartition(0, ds, output, s);
    return output;
  }
}
