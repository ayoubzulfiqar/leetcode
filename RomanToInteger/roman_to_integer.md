# Roman to Integer

## Approach

1. Maintain a map with roman symbol and their corresponding integer equivalent - Already given in the question

2. Scan the string from right to left. Get the corresponding value to the current character from the map and add into to result

3. The special case is where the character at the left of the current character whose value is less than the value corresponding to the current character. For e.g x represent 10, but IX represents 9. In this case we have we subtract the value of the character in the left from the result

### Code

Both Solutions are perfectly fine but first one pass with flying colors and other one end up with fatal and most annoying error I think or believe it something that while loop is broken, or maybe it does execute properly on leetCode platform

#### Simple Solution

```dart

class Solution {
  int romanToInt(String s) {
    Map<String, int> romanMap = <String, int>{
      "I": 1,
      "V": 5,
      "X": 10,
      "L": 50,
      "C": 100,
      "D": 500,
      "M": 1000,
    };
    int n = s.length;
    var nums = romanMap[s[n - 1]];
    for (var i = n - 2; i >= 0; i--) {
      if (romanMap[s[i]]! >= romanMap[s[i + 1]]!) {
        if (nums != null) {
          nums += romanMap[s[i]]!;
        }
      } else {
        if (nums != null) {
          nums -= romanMap[s[i]]!;
        }
      }
    }
    return nums!;
  }
}


```

Runtime: 841 ms, faster than 88.89% of Dart online submissions for Roman to Integer.
Memory Usage: 149.6 MB, less than 66.67% of Dart online submissions for Roman to Integer.

#### Algorithmic Solution

```dart

class Solution {
  int romanToInt(String s) {
    int getInt(String s) {
      switch (s) {
        case "I":
          return 1;
        case "V":
          return 5;
        case "X":
          return 10;
        case "L":
          return 50;
        case "C":
          return 100;
        case "D":
          return 500;
        case "M":
          return 1000;

        default:
          -1;
      }
      return 0;
    }

    int n = s.length;
    int result = 0;
    int current = 0;
    int next = 0;
    int i = 0;

    while (i < n) {
      if (i == n - 1) {
        result += getInt(s[i]);
        return result;
      }
      current = getInt(s[i]);
      next = getInt(s[i + 1]);
      if (current >= next) {
        result += current;
        i++;
      } else {
        result += next - current;
        i += 2;
      }
    }

    return result;
  }
}

```

#### Error

Submission Detail
64 / 3999 test cases passed.
Status: Time Limit Exceeded
Last executed input: "MCXXV"
