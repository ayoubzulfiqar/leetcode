/*

-* 409. Longest Palindrome *-

Given a string s which consists of lowercase or uppercase letters, return the length of the longest palindrome that can be built with those letters.

Letters are case sensitive, for example, "Aa" is not considered a palindrome here.

 

Example 1:

Input: s = "abccccdd"
Output: 7
Explanation: One longest palindrome that can be built is "dccaccd", whose length is 7.
Example 2:

Input: s = "a"
Output: 1
Explanation: The longest palindrome that can be built is "a", whose length is 1.
 

Constraints:

1 <= s.length <= 2000
s consists of lowercase and/or uppercase English letters only.

*/

class Solution {
  int longestPalindrome(String s) {
    Map<String, int> frequency = {};
    int length = 0;

    // Count the frequency of each letter
    for (int i = 0; i < s.length; i++) {
      String char = s[i];
      frequency[char] = (frequency[char] ?? 0) + 1;
    }

    // Iterate through the frequency counts
    frequency.values.forEach((count) {
      if (count % 2 == 0) {
        length += count;
      } else {
        length += count - 1;
      }
    });

    // Check for remaining letters with odd counts
    if (length < s.length) {
      length += 1;
    }

    return length;
  }
}

class B {
  int longestPalindrome(String s) {
    List<int> count = List<int>.filled(256, 0);
    int odds = 0;

    for (int i = 0; i < s.length; i++) {
      int char = s.codeUnitAt(i);
      count[char]++;
      if (count[char] % 2 == 1) {
        odds++;
      } else {
        odds--;
      }
    }

    return s.length - odds + boolToInt(odds > 0);
  }

  int boolToInt(bool b) {
    return b ? 1 : 0;
  }
}

class C {
  int longestPalindrome(String s) {
    int dp = s.runes.fold(0, (int acc, int x) {
      acc ^= 1 << (x - 65);
      return acc;
    });

    return s.length - countSetBits(dp) + (dp != 0 ? 1 : 0);
  }

  int countSetBits(int n) {
    int count = 0;
    while (n != 0) {
      count += n & 1;
      n >>= 1;
    }
    return count;
  }
}

class BitSet {
  int _value;

  BitSet() : _value = 0;

  void flip(int k) {
    _value ^= (1 << k);
  }

  bool get(int k) {
    return ((_value >> k) & 1) == 1;
  }
}

class E {
  int longestPalindrome(String s) {
    if (s.isEmpty) {
      return 0;
    }

    BitSet bitSet = BitSet();
    int ans = 0;

    for (int ch in s.runes) {
      int pos = 0;

      if (ch >= 65 && ch <= 90) {
        pos = ch - 65 + 26;
      } else {
        pos = ch - 97;
      }

      if (bitSet.get(pos)) {
        ans += 2;
      }

      bitSet.flip(pos);
    }

    return min(ans + 1, s.length);
  }

  int min(int a, int b) {
    return a < b ? a : b;
  }
}
