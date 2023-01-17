# 🔥 3 Approaches 🔥 || Simple Fast and Easy || with Explanation

## Solution - 1

### Approach

Skip the loop until we find the first '1'
after finding first occurrence of '1' we have to keep a count of number of '1's in countOnes

if we find any '0' after occurrence of '1' it means turning that '0' to one may be one possible solution so we have to keep number of flip needed in countFlips variable

if value of countFlips is greater than countOnes(number of ones) then converting all '1' to '0' would be better option so assign value of countOnes to the countFlips

in the end we will return countFlips

### Complexity

#### Time complexity

O(n)

#### Space complexity

O(1)

```dart
class Solution {
  int minFlipsMonoIncr(String s) {
    // Initialize variables to store the minimum number of flips and the number of flips currently needed
    int ans = 0;
    int noOfFlip = 0;

    // Iterate through each character in the input string
    for (int i = 0; i < s.length; i++) {
      // If the current character is a '0', update the minimum number of flips and add 1 to the current number of flips
      if (s.codeUnitAt(i) == '0')
        ans = min(noOfFlip, ans + 1);
      // If the current character is a '1', increment the number of flips
      else
        noOfFlip++;
    }
    // Return the minimum number of flips
    return ans;
  }
}
```

## Solution - 2

### Intuition

Counting the no. of 1's to flip on left side + no. of 0's to flip on right side of each index i and then select minimum flips from it.

### Approach

Maintain a prefix and suffix array to count 1 on left side and 0 on right side.

#### Complexity

Time complexity:
O(n)

#### Space complexity

O(n)

```dart
class Solution {
  int minFlipsMonoIncr(String s) {
    int n = s.length;
    int ans = 100000;
    List<int> oneCount = List.filled(n, 0);
    List<int> zeroCount = List.filled(n, 0);
    oneCount[0] = 0;
    zeroCount[n - 1] = 0;
    for (int i = 1; i < n; i++) {
      if (s[i - 1] == '1')
        oneCount[i] = oneCount[i - 1] + 1;
      else
        oneCount[i] = oneCount[i - 1];
      if (s[n - i] == '0')
        zeroCount[n - i - 1] = zeroCount[n - i] + 1;
      else
        zeroCount[n - i - 1] = zeroCount[n - i];
    }
    for (int i = 0; i < n; i++) {
      ans = min(ans, zeroCount[i] + oneCount[i]);
    }
    return ans;
  }
}
```

### Solution - 3

```dart
class Solution {
  //TLE
  int minFlipsMonoIncr(String s) {
    int n = s.length;
    int mini = 10000;
    List<int> ans = List.filled(n, 0);
    for (int i = 0; i < n; i++) {
      ans[i] += oneCount(s.substring(0, i));
      ans[i] += zeroCount(s.substring(i + 1));
      mini = min(mini, ans[i]);
    }
    return mini;
  }

  int oneCount(String s) {
    int n = s.length;
    int cnt = 0;
    for (int i = 0; i < n; i++) {
      if (s[i] == '1') cnt++;
    }
    return cnt;
  }

  int zeroCount(String s) {
    int n = s.length;
    int cnt = 0;
    for (int i = 0; i < n; i++) {
      if (s[i] == '0') cnt++;
    }
    return cnt;
  }
}
```
