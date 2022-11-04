# 🔥 Reverse Vowels of a String 🔥 || 3 Approaches || Simple Fast and Easy || with Explanation

## Solution -1

```dart
class Solution {
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
```

## Solution - 2

```dart
class Solution {
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
```

## Solution - 3

```dart
class Solution {
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
```
