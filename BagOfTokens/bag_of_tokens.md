# ️‍🔥 Dart 🔥 || Easy and Simple Solution || 100% Faster Code || Explained Line By Line

## Solution - 1 Sorting

```dart
class Solution {
//   Time Complexity : O(nlogn)
//   Space Complexity : O(1)
// Runtime: 336 ms, faster than 100.00% of Dart online submissions for Bag of Tokens.
// Memory Usage: 158.9 MB, less than 100.00% of Dart online submissions for Bag of Tokens.

  int bagOfTokensScore(List<int> tokens, int power) {
    // length of the tokens
    int n = tokens.length;
    // if the length is zero we will return zero because it empty
    if (n == 0) return 0;
    // sorting tokens smallest to largest
    tokens.sort();
    // holding the value of the inside list
    int value = 0;
    //index of tokens inside tokens list
    int index = n - 1;
    // value to hold the current score
    int currentScore = 0;
    // value to hold max score
    int maxScore = 0;
    // assuming that our value is less than and equal the idex
    while (value <= index) {
      // for example power is greater than tokens value
      if (power >= tokens[value]) {
        // than we will subtract the power from the token value
        power -= tokens[value];
        // and we will increment the current score
        currentScore++;
        // for example if current score is greater than max score than
        // our max score will be current score and than we will increment the value
        if (currentScore > maxScore) maxScore = currentScore;
        value++;
        // for example if current score is just greater than 1 point

      } else if (currentScore >= 1) {
        // than we will increment the value of power with based on
        //  the value which is available at index point
        power += tokens[index];
        // we decrement the index value
        index--;
        // and also current score
        currentScore--;
      } else
     // breaking because we can't play anymore
        break;
    }
    // return the total max score
    return maxScore;
  }
}
```

## Solution - 2 Two Pointers Solution

### Explanation

We can solve this question using two pointer approach!

Intuition :

Sort the tokens list.
Pointer i initially points towards the beginning of the list. (lowest power required to spend to earn a point which adds to the score)
Pointer j, initially points towards the end of the list. (largest possible power we can get by spending only a single point from our score)
Why greedy ?

We always tend to increase our score. So, until we have enough power, we keep incrementing i by subtracting the power (tokens[i]) from our current power and we'll add a single point to our score every time.

When we don't have enough power, we'll try to get the maximum power from the tokens array by spending only the least score that we can which is one. Now, subtract a single point from your current score and add the power (tokens[j]) to your current power and decrement j by 1.

Remember, you'll only spend your single point from your score, only when you are sure that you'll get at least one more point from the tokens list. Else, its okay not to play the token. It indirectly means this scenario :

You are out of power. You are left with only one element in the array. Your current score is >= 1. In this situation even if you spend a single point of your score on playing a token and getting power, it's of no use right ? We're just wasting one point of ours for no benefit!!

```dart
class Solution {
// Runtime: 653 ms, faster than 100.00% of Dart online submissions for Bag of Tokens.
// Memory Usage: 147.6 MB, less than 100.00% of Dart online submissions for Bag of Tokens.

  int bagOfTokensScore(List<int> tokens, int power) {
    int scores = 0;
    int s = 0, e = tokens.length - 1;
    tokens.sort((a, b) => a - b);
    if (e + 1 == 0 || power < tokens[0]) return 0;
    while (s <= e) {
      if (power >= tokens[s]) {
        scores++;
        power -= tokens[s++];
      } else {
        if (e - s >= 1) {
          power += tokens[e--];
          scores--;
        } else
          break;
      }
    }
    return scores;
  }
}
```

## Solution - 3

```dart
class Solution {
// Runtime: 607 ms, faster than 100.00% of Dart online submissions for Bag of Tokens.
// Memory Usage: 148 MB, less than 100.00% of Dart online submissions for Bag of Tokens.
  int bagOfTokensScore(List<int> tokens, int power) {
    // play i-th token face up -> lose tokens[i] power -> choose the smallest one
    // play i-th token face down -> gain tokens[i] power -> choose the largest one
    // hence, sort tokens first
    tokens.sort();
    // two pointes - l for tracking face up & r for tracking face down
    int l = 0, r = tokens.length - 1;
    int currentScore = 0, maxScore = 0;
    while (l <= r) {
      // there are 3 cases
      if (tokens[l] <= power) {
        // case 1. play l-th tokens face up if its power <= the current power
        // ---
        // losing tokens[l] power
        power -= tokens[l];
        // and gaining 1 score
        currentScore += 1;
        // cur_score can be mx_score potentially
        maxScore = max(maxScore, currentScore);
        // move the pointer to the right
        l += 1;
      } else if (currentScore >= 1) {
        // case 2. play r-th tokens face down if the current score is at least 1
        // ---
        // gaining tokens[r] power
        power += tokens[r];
        // and losing 1 score
        currentScore -= 1;
        // move the pointer to the left
        r -= 1;
      } else {
        // case 3. impossible to play
        // ---
        // either you don't enough power or enough score
        break;
      }
    }
    return maxScore;
  }
}
```

## Bonus Solution

```go
package main

import "sort"

func bagOfTokensScore(tokens []int, P int) int {
 // to hold the value  of our score
 var score int = 0
 // sorting the token and slicing because sort.slice is more stable
 sort.Slice(tokens, func(i, j int) bool { return tokens[i] < tokens[j] })
 // loop if the token length is greater than 0 abd power is also greater and equal
 // than the first value of the token list
 for len(tokens) > 0 && P >= tokens[0] {
  // we will decrement the first value of token from the power
  P = P - tokens[0]
  // increment the score because we point a score
  score++
  tokens = tokens[1:]
  // if the length of the list of tokens is more than 1 and power is less than first value of the list
  if len(tokens) > 1 && P < tokens[0] {
   // than we will increment the value of power inside the first index of the token
   P = P + tokens[len(tokens)-1]
   // we will decrement the score
   score--
   tokens = tokens[:len(tokens)-1]
  }
 }
 // than we will total score we have achieved
 return score
}

```
