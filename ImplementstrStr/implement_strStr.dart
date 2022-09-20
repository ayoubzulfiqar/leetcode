/*

Implement strStr().

Given two strings needle and haystack, return the index of the first occurrence of needle in haystack, or -1 if needle is not part of haystack.

Clarification:

What should we return when needle is an empty string? This is a great question to ask during an interview.

For the purpose of this problem, we will return 0 when needle is an empty string. This is consistent to C's strstr() and Java's indexOf().



Example 1:

Input: haystack = "hello", needle = "ll"
Output: 2
Example 2:

Input: haystack = "aaaaa", needle = "bba"
Output: -1


Constraints:

1 <= haystack.length, needle.length <= 104
haystack and needle consist of only lowercase English characters.

*/

void main() {
  final a = E().strStr("aaa", "aaaa");
  print(a);
}

class A {
  // RangeError (index): Invalid value: Not in inclusive range 0..2: 3
  int strStr(String haystack, String needle) {
    if (needle.isEmpty && haystack.isEmpty) return 0;
    for (var i = 0; i < haystack.length; i++) {
      for (var j = 0; j < needle.length; j++) {
        if (haystack[i + j] != needle[j]) break;
        if (j == needle.length - 1) return i;
      }
    }
    return -1;
  }
}

class B {
  //RangeError (index): Invalid value: Not in inclusive range 0..2: 3
  int strStr(String haystack, String needle) {
    int haystackLength = haystack.length;
    int haystackLengthCopy = haystackLength;
    int needleLength = needle.length;
    int firstIndex = 0;
    int needlePosition = 0;
    bool boMatch = true;
    if (needleLength == 0) return 0;
    while (haystackLengthCopy != 0) {
      for (var i = haystackLength - haystackLengthCopy;
          i < (haystackLength - haystackLengthCopy) + needleLength;
          i++) {
        if (haystack[i] != needle[needlePosition++]) {
          boMatch = false;
          break;
        } else {
          boMatch = true;
        }
      }
      if (boMatch == true) {
        firstIndex = haystackLength - haystackLengthCopy;
        break;
      } else {
        needlePosition = 0;
        haystackLengthCopy -= 1;
      }
      if (boMatch == false) return -1;
    }
    return firstIndex;
  }
}

class C {
  // RangeError (index): Invalid value: Not in inclusive range 0..2: 3
  int strStr(String haystack, String needle) {
    // if (needle.length == 0) return 0;
    int ans = -1;
    int h = haystack.length;
    int n = needle.length;
    for (var i = 0; i < h; i++) {
      if (haystack[i] == needle[0]) {
        if (haystack.substring(i, n) == needle) {
          ans = i;
          break;
        }
      }
    }
    return ans;
  }
}

class D {
  int strStr(String haystack, String needle) {
    return haystack.indexOf(needle);
  }

/*
Runtime: 457 ms, faster than 46.15% of Dart online submissions for Implement strStr().
Memory Usage: 140 MB, less than 84.62% of Dart online submissions for Implement strStr().
*/
}

class E {
  // RangeError (end): Invalid value: Not in inclusive range 1..3: 4
  int strStr(String haystack, String needle) {
    int len = needle.length;
    var first = haystack.substring(1, needle.length);
    if (first == needle) return 0;
    for (var i = 1; i < haystack.length - needle.length + 1; ++i) {
      first = first.substring(1);
      first += haystack[i + len - 1];
      if (first == needle) return i;
    }

    return -1;
  }
}
