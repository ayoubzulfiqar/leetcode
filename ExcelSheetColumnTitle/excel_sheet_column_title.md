# 🔥 Find K Closest Elements 🔥 || 5 Solutions || Simple Fast and Easy || with Explanation

## Solution - 1

The problem is similar to converting a decimal number to its binary representation but instead of a binary base system where we have two digits only 0 and 1, here we have 26 characters from A-Z.
So, we are dealing with base 26 instead of base binary.
That’s not where the fun ends, we don’t have zero in this number system, as A represents 1, B represents 2 and so on Z represents 26.
To make the problem easily understandable, we approach the problem in two steps:

Convert the number to base 26 representation, considering we have 0 also in the system.
Change the representation to the one without having 0 in its system.
HOW? Here is an example

Step 1:
Consider we have number 676, How to get its representation in the base 26 system? In the same way, we do for a binary system, Instead of division and remainder by 2, we do division and remainder by 26.

Base 26 representation of 676 is : 100
Step2
But Hey, we can’t have zero in our representation. Right? Because it’s not part of our number system. How do we get rid of zero? Well it’s simple, but before doing that let’s remind one simple math trick:

Subtraction:
5000 - 9, How do you subtract 9 from 0 ? You borrow
from next significant bit, right.
In a decimal number system to deal with zero, we borrow 10 and subtract 1 from the next significant.
In the Base 26 Number System to deal with zero, we borrow 26 and subtract 1 from the next significant bit.
So Convert 10026 to a number system that does not have ‘0’, we get (25 26)26
Symbolic representation of the same is: YZ

* Time Complexity: O(log26n), as we are using a loop and in each traversal, we decrement by floor division of 26.
* Auxiliary Space: O(10000), as we are using extra space for the array.

```dart
class Solution {
// Runtime: 512 ms, faster than 50.00% of Dart online submissions for Excel Sheet Column Title.
// Memory Usage: 141.5 MB, less than 50.00% of Dart online submissions for Excel Sheet Column Title.

  String convertToTitle(int columnNumber) {
    List<int> arr = List.filled(10000, 0);
    int i = 0;

    // Step 1: Converting to number assuming
    // 0 in number system
    while (columnNumber > 0) {
      arr[i] = columnNumber % 26;
      columnNumber = columnNumber ~/ 26;
      i++;
    }

    // Step 2: Getting rid of 0, as 0 is
    // not part of number system
    for (int j = 0; j < i - 1; j++) {
      if (arr[j] <= 0) {
        arr[j] += 26;
        arr[j + 1] = arr[j + 1] - 1;
      }
    }
    String ans = '';
    for (int j = i; j >= 0; j--) {
      if (arr[j] > 0) ans += String.fromCharCode(65 + arr[j] - 1);
    }

    return ans;
  }
}
```

## Solution - 2

We can use a recursive function which definitely reduces the time and  increase the efficiency:

Alphabets are in sequential order like: ‘ABCDEFGHIJKLMNOPQRSTUVWXYZ’. You have experienced while using excel when you see columns and rows numbering are done in  Alphabetical ways.

Here’s How I purposefully think about the logic of how it is arranged.

(In Mathematical  terms, [a , b ] means from ‘a’ to ‘b’).

[1,26] = [A,Z] (Understand by ‘1’ stands for ‘A’ and ’26” stands for “Z”). For [27,52] ,it will be like [AA,AZ], For [57,78] it will be [BA,BZ]

Logic is to append an Alphabet sequentially whenever it ends up numbering at 26.

For example, if the number is ’27’ which is greater than  ’26’, then we simply need to divide by 26, and we get the remainder as 1, We see “1” as “A” and can be recursively done.

we will be using python for this.

Algorithm is:

1. Take an array and Sort the letters from A to Z . (You can also use the import string and string function to get “A to Z” in uppercase.)

2. If the number is less than or equal to ’26’, simply get the letter from the array and print it.

3. If it is greater than 26, use the Quotient  Remainder rule, if the remainder is zero, there are 2 possible ways, if the quotient is “1”, simply hash out the letter from the index [r-1]( ‘r’ is remainder), else call out the function from the num =(q-1) and append at the front to the letter indexing [r-1].

4. If the remainder is not equal to “0”, call the function for the num = (q) and append at the front to the letter indexing [r-1].
Time Complexity: O(log26n), as we are using recursion and in each recursive call, we decrement by floor division of 26.

Auxiliary Space: O(1), as we are not using any extra space.

```dart
class Solution {
// Runtime: 391 ms, faster than 50.00% of Dart online submissions for Excel Sheet Column Title.
// Memory Usage: 140.1 MB, less than 50.00% of Dart online submissions for Excel Sheet Column Title.

  String convertToTitle(int columnNumber) {
    String alpha = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
    if (columnNumber < 26)
      return alpha[columnNumber - 1];
    else {
      int q = (columnNumber ~/ 26), r = columnNumber % 26;
      if (r == 0) {
        if (q == 1)
          return alpha[(26 + r - 1)];
        else
          return convertToTitle(q - 1) + alpha[(26 + r - 1)];
      } else
        return convertToTitle(q) + alpha[r - 1];
    }
  }
}
```

## Solution - 3

```dart
class Solution {
// Runtime: 490 ms, faster than 50.00% of Dart online submissions for Excel Sheet Column Title.
// Memory Usage: 150.5 MB, less than 50.00% of Dart online submissions for Excel Sheet Column Title.

  String convertToTitle(int columnNumber) {
    if (columnNumber-- == 0) return "";
    return convertToTitle(columnNumber ~/ 26) +
        String.fromCharCode((columnNumber % 26) + 'A'.codeUnitAt(0));
  }
}
```

## Solution -  4

```dart
class Solution {
// Runtime: 305 ms, faster than 50.00% of Dart online submissions for Excel Sheet Column Title.
// Memory Usage: 157.9 MB, less than 50.00% of Dart online submissions for Excel Sheet Column Title.

  String convertToTitle(int columnNumber) {
    StringBuffer result = StringBuffer();

    while (columnNumber > 0) {
      columnNumber--;
      result.writeCharCode(((columnNumber % 26) + 'A'.codeUnitAt(0)));
      columnNumber ~/= 26;
    }
    return result.toString().split("").reversed.join("");
  }
}
```

## Solution - 5

```dart
class Solution {
// Runtime: 324 ms, faster than 50.00% of Dart online submissions for Excel Sheet Column Title.
// Memory Usage: 140 MB, less than 50.00% of Dart online submissions for Excel Sheet Column Title.

  String convertToTitle(int columnNumber) {
    return columnNumber == 0
        ? ""
        : convertToTitle(--columnNumber ~/ 26) +
            String.fromCharCode((columnNumber % 26) + 'A'.codeUnitAt(0));
  }
}
```
