# 🔥 Find Smallest Letter Greater Than Target 🔥 || 3 Solutions || Simple Fast and Easy || with Explanation

## Solution -1

The given code implements a function nextGreatestLetter that takes a list of strings letters and a target string target as input. It iterates through each letter in the letters list and compares it with the target string using the compareTo method. If a letter is found to be greater than the target, it is returned immediately. If no greater letter is found, the first letter in the letters list is returned as the default value.

The time complexity of this code is O(n), where n is the length of the letters list. This is because in the worst case, the code needs to iterate through all the letters in the letters list to find the next greatest letter.

The space complexity of this code is O(1), which means it uses a constant amount of additional space. The space used by the variables letter and target is negligible as they are just references to the strings, and the space used by the returned value is also constant.

Overall, the code has a linear time complexity and constant space complexity.

```dart
class Solution {
  String nextGreatestLetter(List<String> letters, String target) {
    for (String letter in letters) {
      if (letter.compareTo(target) > 0) {
        return letter;
      }
    }
    return letters[0];
  }
}
```

## Solution - 2

The given code implements a function nextGreatestLetter that takes a list of strings letters and a target string target as input. It uses a SplayTreeSet named jat to store the differences between the letters and the target. The code then performs comparisons and calculations to find the lexicographically next greatest letter.

Here's how the code works:

It initializes a SplayTreeSet named jat to store the differences between the letters and the target. This data structure automatically keeps the elements sorted in ascending order.
It checks if the last letter in the letters list is less than or equal to the target. If so, it means that there is no greater letter in the list, and it returns the first letter as the default value.
It iterates through each letter in the letters list.
If a letter is found to be greater than the target, it calculates the difference between the Unicode code points of the letter and the target using codeUnitAt method. The result is stored in the temp variable.
If the difference (temp) is equal to 0, it means that the current letter is equal to the target. In this case, it returns the next letter in the list as the next greatest letter.
Otherwise, it adds the difference (temp) to the jat set.
Finally, it retrieves the next greatest letter by adding the Unicode code point of the target with the first element in the jat set. It converts the resulting code point back to a string using String.fromCharCode method and returns it.
The time complexity of this code is O(n log m), where n is the length of the letters list and m is the number of unique differences (elements) in the jat set. The iteration through the letters list takes O(n) time, and each addition to the jat set takes O(log m) time. Since the jat set is sorted and self-balancing, the insertion of each element takes logarithmic time complexity.

The space complexity of this code is O(m), where m is the number of unique differences (elements) stored in the jat set. The jat set grows with the number of differences encountered in the letters list.

Overall, the code has a time complexity of O(n log m) and a space complexity of O(m), where n is the length of the letters list and m is the number of unique differences encountered.

```dart
class Solution {
  String nextGreatestLetter(List<String> letters, String target) {
    SplayTreeSet<int> jat = SplayTreeSet<int>();

    if (letters[letters.length - 1].compareTo(target) <= 0) {
      return letters[0];
    }

    for (int i = 0; i < letters.length; i++) {
      if (letters[i].compareTo(target) > 0) {
        int temp = letters[i].codeUnitAt(0) - target.codeUnitAt(0);

        if (temp == 0) {
          return letters[i + 1];
        }

        jat.add(temp);
      }
    }

    return String.fromCharCode(target.codeUnitAt(0) + jat.first);
  }
}
```

## Solution - 3

```dart
class Solution {
  String nextGreatestLetter(List<String> letters, String target) {
    int left = 0;
    int right = letters.length - 1;

    while (left <= right) {
      int mid = left + ((right - left) ~/ 2);

      if (letters[mid].compareTo(target) > 0) {
        right = mid - 1;
      } else {
        left = mid + 1;
      }
    }

    return letters[left % letters.length];
  }
}
```
