/*


 -* Check If Two String Arrays are Equivalent *-


 Given two string arrays word1 and word2, return true if the two arrays represent the same string, and false otherwise.

A string is represented by an array if the array elements concatenated in order forms the string.



Example 1:

Input: word1 = ["ab", "c"], word2 = ["a", "bc"]
Output: true
Explanation:
word1 represents string "ab" + "c" -> "abc"
word2 represents string "a" + "bc" -> "abc"
The strings are the same, so return true.
Example 2:

Input: word1 = ["a", "cb"], word2 = ["ab", "c"]
Output: false
Example 3:

Input: word1  = ["abc", "d", "defg"], word2 = ["abcddefg"]
Output: true


Constraints:

1 <= word1.length, word2.length <= 103
1 <= word1[i].length, word2[i].length <= 103
1 <= sum(word1[i].length), sum(word2[i].length) <= 103
word1[i] and word2[i] consist of lowercase letters.


*/

class A {
// Runtime: 422 ms, faster than 83.33% of Dart online submissions for Check If Two String Arrays are Equivalent.
// Memory Usage: 141.7 MB, less than 33.33% of Dart online submissions for Check If Two String Arrays are Equivalent.
  bool arrayStringsAreEqual(List<String> word1, List<String> word2) {
    return word1.join("") == word2.join("");
  }
}

class B {
// Runtime: 505 ms, faster than 33.33% of Dart online submissions for Check If Two String Arrays are Equivalent.
// Memory Usage: 141.4 MB, less than 66.67% of Dart online submissions for Check If Two String Arrays are Equivalent.
  bool arrayStringsAreEqual(List<String> word1, List<String> word2) {
    int wordIdx1 = 0, wordIdx2 = 0, chIdx1 = 0, chIdx2 = 0;
    while (true) {
      int ch1 = word1[wordIdx1][chIdx1].codeUnitAt(0);
      int ch2 = word2[wordIdx2][chIdx2].codeUnitAt(0);
      if (ch1 != ch2) return false;

      chIdx1++;
      chIdx2++;
      if (chIdx1 == word1[wordIdx1].length) {
        wordIdx1++;
        chIdx1 = 0;
      }
      if (chIdx2 == word2[wordIdx2].length) {
        wordIdx2++;
        chIdx2 = 0;
      }

      if (wordIdx1 == word1.length && wordIdx2 == word2.length) break;
      if (wordIdx1 == word1.length || wordIdx2 == word2.length) return false;
    }
    return true;
  }
}

class C {
  bool arrayStringsAreEqual(List<String> word1, List<String> word2) {
    int firstPointer = 0, secondPointer = 0; // inner pointer
    int firstWord = 0, secondWord = 0; // outer pointer

    while (firstWord < word1.length && secondWord < word2.length) {
      String firstString = word1[firstWord], secondString = word2[secondWord];

      if (firstString.codeUnitAt(firstPointer) !=
          secondString.codeUnitAt(secondPointer)) return false;

      if (firstPointer < firstString.length - 1) {
        firstPointer++;
      } else {
        firstPointer = 0;
        firstWord++;
      }

      if (secondPointer < secondString.length - 1) {
        secondPointer++;
      } else {
        secondPointer = 0;
        secondWord++;
      }
    }

    return firstWord == word1.length && secondWord == word2.length;
  }
}

class D {
  bool arrayStringsAreEqual(List<String> word1, List<String> word2) {
    StringBuffer sb1 = StringBuffer();
    StringBuffer sb2 = StringBuffer();
    for (String s in word1) {
      sb1.write(s);
    }
    for (String s in word2) {
      sb2.write(s);
    }
    return sb1.toString() == (sb2.toString());
  }
}
