/*

 -* Reverse Words in a String III *-

 Given a string s, reverse the order of characters in each word within a sentence while still preserving whitespace and initial word order.



Example 1:

Input: s = "Let's take LeetCode contest"
Output: "s'teL ekat edoCteeL tsetnoc"
Example 2:

Input: s = "God Ding"
Output: "doG gniD"


Constraints:

1 <= s.length <= 5 * 104
s contains printable ASCII characters.
s does not contain any leading or trailing spaces.
There is at least one word in s.
All the words in s are separated by a single space.

*/

class A {
// Runtime: 762 ms, faster than 10.00% of Dart online submissions for Reverse Words in a String III.
// Memory Usage: 174.5 MB, less than 10.00% of Dart online submissions for Reverse Words in a String III.
  String reverseWords(String s) {
    if (s.length == 1) return s;
    String reversed = "";
    String current_word = "";
    int num_spaces = 0;
    for (int i = 0; i < s.length; ++i) {
      String c = s[i];
      if (c == ' ') {
        if (!reversed.isEmpty) {
          reversed = reversed + ' ' + current_word;
        } else {
          reversed = current_word;
        }
        current_word = "";
        num_spaces++;
      } else {
        current_word = c + current_word;
      }
    }
    // if its a string with multiple words vs a single word
    if (num_spaces != 0) {
      reversed += ' ' + current_word;
    } else {
      reversed = current_word;
    }
    return reversed;
  }
}

class B {
  // O(n)
// Runtime: 399 ms, faster than 100.00% of Dart online submissions for Reverse Words in a String III.
// Memory Usage: 155.1 MB, less than 10.00% of Dart online submissions for Reverse Words in a String III.
  String reverseWords(String s) {
    String res = '';
    String word = '';
    for (var c in s.split('')) {
      if (c == ' ') {
        res += word + c;
        word = '';
      } else {
        word = c + word;
      }
    }
    return res + word;
  }
}

class C {
  // O(n)
// Runtime: 355 ms, faster than 100.00% of Dart online submissions for Reverse Words in a String III.
// Memory Usage: 166.9 MB, less than 10.00% of Dart online submissions for Reverse Words in a String III.
  String reverseWords(String s) {
    return s
        .toString()
        .split(' ')
        .map((e) => e.split('').reversed.join(''))
        .join(' ');
  }
}

// Two Pointer
class D {
// Runtime: 431 ms, faster than 80.00% of Dart online submissions for Reverse Words in a String III.
// Memory Usage: 146.7 MB, less than 100.00% of Dart online submissions for Reverse Words in a String III.
  String reverseWords(String s) {
    int len = s
        .length; // saving the length as constant so as to avoid calling s.length() again and again.

    if (len == 1) // no need to iterate if string is of length 1
      return s;

    int firstIndex, lastIndex;
    List<String> ch = s.split(
        ''); // converting the string into it's corresponding character array
    // var ch = s.codeUnits;
    var temp;

    for (int index = 0; index < len; index++) {
      firstIndex = index; // store the first index of word

      while (++index < len &&
          ch[index] !=
              ' '); // iterate until space is found i.e. to get the last index of the word

      lastIndex = index - 1; // store the last index of the word

      // reverse characters of the word
      while (firstIndex < lastIndex) {
        temp = ch[firstIndex];
        ch[firstIndex++] = ch[lastIndex];
        ch[lastIndex--] = temp;
      }
    }

    return ch.join(' '); // convert the character into string and return it
  }
}
