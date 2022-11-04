/*


-* 345. Reverse Vowels of a String *-

Given a string s, reverse only all the vowels in the string and return it.

The vowels are 'a', 'e', 'i', 'o', and 'u', and they can appear in both lower and upper cases, more than once.



Example 1:

Input: s = "hello"
Output: "holle"
Example 2:

Input: s = "leetcode"
Output: "leotcede"


Constraints:

1 <= s.length <= 3 * 105
s consist of printable ASCII characters.
Accepted
403,544
Submissions
838,146


*/

class A {
  String reverseVowels(String s) {
    List<String> char = s.split("");
    int left = 0;
    int right = s.length - 1;
    while (left < right) {
      while (left < right && !isVowels(char[left])) {
        left++;
      }
      while (left < right && !isVowels(char[right])) {
        right--;
      }
      if (left < right) {
        String temp = char[left];
        char[left++] = char[right];
        char[right--] = temp;
      }
    }
    return char.join();
  }

  bool isVowels(String s) {
    return s == 'a' ||
        s == 'e' ||
        s == 'i' ||
        s == 'o' ||
        s == 'u' ||
        s == 'A' ||
        s == 'E' ||
        s == 'I' ||
        s == 'O' ||
        s == 'U';
  }
}

class B {
  // Set<String> vowels = {'a', 'e', 'i', 'o', 'u', 'A', 'E', 'I', 'O', 'U'};
  String vowels = 'aeiouAEIOU';
  String reverseVowels(String s) {
    List<String> char = s.split("");
    for (int i = 0, j = char.length - 1; i < j; i++, j--) {
      while (!vowels.contains(char[i]) && i < j) {
        i++;
      }

      while (!vowels.contains(char[j]) && i < j) {
        j--;
      }

      // [char[i], char[j]] = [char[j], char[i]];

      char[i] = char[j];
      char[j] = char[i];
    }

    return char.join('');
  }
}

class C {
  String reverseVowels(String s) {
    String str = "aeiouAEIOU";
    String dummy = "";
    for (String c in s.split("")) {
      if (str.contains("" + c)) dummy += c;
    }
    List<String> c = s.split("");
    int j = dummy.length - 1;
    for (int i = 0; i < s.length; i++) {
      if (str.contains("" + s[i])) {
        c[i] = dummy[j];
        j--;
      }
    }

    return c.join();
  }
}

class D {
  String reverseVowels(String s) {
    // Create A Pointer Which Is Start From End Of The Array.
    int pointer = s.length - 1;
    // Convert String To Array That Will More Easy To Solve This Problem.
    List<String> ansStr = s.split("");
    int i = 0; // Create A I Veritable That Start From Array Index Of 0
    // Create a All Vowels That Will Help To Check The Value Is Vowel Or Not.
    List<String> vowels = ['a', 'e', 'i', 'o', 'u', 'A', 'E', 'I', 'O', 'U'];
    // You can use regex like: /[a|e|i|o|u]/gi
    while (i < pointer) {
      // Check Condition That I Should Be Less Then Pointer This Condition Divide The Time Complexity To O(N) To O(LogN).

      if (vowels.contains(ansStr[i]) && vowels.contains(ansStr[pointer])) {
        // Here we check the condition that our I position value and Pointer position value should be vowel
        String tmp = ansStr[i];
        // If condition is true then swap this position value respectively you can create a extra swap function.
        ansStr[i++] = ansStr[pointer];
        ansStr[pointer--] = tmp;
      } else {
        if (vowels.contains(ansStr[i])) {
          // If the Ith position value is vowel then we decrement the Pointer Position value to -1;
          pointer--;
        } else {
          i++; // If the Ith position value does not a vowel then increment the Ith position by +1
        }
      }
    }
    return ansStr.join(""); // Here we convert the array to string
  }
}
