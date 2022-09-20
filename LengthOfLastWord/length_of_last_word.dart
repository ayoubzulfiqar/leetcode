/*


   -* Length of Last Word *-


Given a string s consisting of words and spaces, return the length of the last word in the string.

A word is a maximal substring consisting of non-space characters only.



Example 1:

Input: s = "Hello World"
Output: 5
Explanation: The last word is "World" with length 5.
Example 2:

Input: s = "   fly me   to   the moon  "
Output: 4
Explanation: The last word is "moon" with length 4.
Example 3:

Input: s = "luffy is still joyboy"
Output: 6
Explanation: The last word is "joyboy" with length 6.


Constraints:

1 <= s.length <= 104
s consists of only English letters and spaces ' '.
There will be at least one word in s.
*/

void main() {}

class A {
  int lengthOfLastWord(String s) {
    // length of the entered string
    int len = s.length;
    // index of the entered String
    int index = len - 1;
    // if th length is only 1 than we will return only one
    if (len == 1) {
      return 1;
    }
    // while loop to check every space inside the string

    while (s[index] == ' ') {
      // if there is space we will remove it
      index--;
    }
    int ans = 0;
    // while loop to  check the if there is no spaces and index is not zero
    while (s[index] != " " && index >= 0) {
      // we will decrement the index
      index--;
      // and increment the value
      ans++;
      // if the index is less than zero mean negative we will break the loop
      if (index < 0) break;
    }
    // now we will return the value
    return ans;
  }

/*
Runtime: 428 ms, faster than 65.38% of Dart online submissions for Length of Last Word.
Memory Usage: 140.4 MB, less than 92.31% of Dart online submissions for Length of Last Word.
*/
}

class B {
  int lengthOfLastWord(String s) {
    // we will use trim to remove all spaces inside string and split into single digit
    List<String> strArr = s.trim().split(" ");
    // we will take that list and remove - 1 to get the index value position
    return strArr[strArr.length - 1].length;
  }

/*
Runtime: 394 ms, faster than 76.92% of Dart online submissions for Length of Last Word.
Memory Usage: 140.8 MB, less than 61.54% of Dart online submissions for Length of Last Word.
*/
}

class C {
  int lengthOfLastWord(String s) {
    // index number of the string
    int index = s.length - 1;
    // counter is a value of each element of the string
    int counter = 0;
    // if the index is greater than 0 means not empty
    while (index >= 0) {
      // and there is no spaces
      if (s[index] != ' ') {
        break;
      }
      // we will decrements the value
      index--;
    }
    // loop to see if the index is greater than 0 and index point doesn't have spaces
    while (index >= 0 && s[index] != ' ') {
      // we will increment the value
      counter++;
      // decrement the index
      index--;
    }
    // return the value
    return counter;
  }

/*
Runtime: 367 ms, faster than 84.62% of Dart online submissions for Length of Last Word.
Memory Usage: 140.7 MB, less than 65.38% of Dart online submissions for Length of Last Word.
*/
}
