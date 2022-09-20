/*



  -* Bag of Tokens *-


You have an initial power of power, an initial score of 0, and a bag of tokens
46 tokens[i] is the value of the ith token (0-indexed).

Your goal is to maximize your total score by potentially playing each token in one of two ways:

If your current power is at least tokens[i], you may play the ith token face up, losing tokens[i] power and gaining 1 score.
If your current score is at least 1, you may play the ith token face down, gaining tokens[i] power and losing 1 score.
Each token may be played at most once and in any order. You do not have to play all the tokens.

Return the largest possible score you can achieve after playing any number of tokens.



Example 1:

Input: tokens = [100], power = 50
Output: 0
Explanation: Playing the only token in the bag is impossible
because you either have too little power or too little score.


Example 2:

Input: tokens = [100,200], power = 150
Output: 1
Explanation: Play the 0th token (100) face up, your power becomes 50 and score becomes 1.
There is no need to play the 1st token since you cannot play it face up to add to your score.
Example 3:

Input: tokens = [100,200,300,400], power = 200
Output: 2
Explanation: Play the tokens in this order to get a score of 2:
1. Play the 0th token (100) face up, your power becomes 100 and score becomes 1.
2. Play the 3rd token (400) face down, your power becomes 500 and score becomes 0.
3. Play the 1st token (200) face up, your power becomes 300 and score becomes 1.
4. Play the 2nd token (300) face up, your power becomes 0 and score becomes 2.


Constraints:

0 <= tokens.length <= 1000
0 <= tokens[i], power < 104

*/

// class A {
//   int bagOfTokensScore(List<int> tokens, int power) {
//     tokens.sort();
//     int i = 1, j = 0, n = tokens.length;
//     while (i < j) {
//       if (tokens[i] <= power) {
//         power -= tokens[i];
//         i += 1;
//       } else if (i - (n - j) & j > i + 1) {
//         j -= 1;
//         power += tokens[j];
//       } else
//         break;
//     }
//     return i - (n - j);
//   }
// }

import 'dart:math';

class A {
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
        break;
    }
    // return the total max score
    return maxScore;
  }
}

class B {
  // Two Pointers Solution

// Runtime: 653 ms, faster than 100.00% of Dart online submissions for Bag of Tokens.
// Memory Usage: 147.6 MB, less than 100.00% of Dart online submissions for Bag of Tokens.

/*

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

*/
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
          // breaking because we can't play anymore
          break;
      }
    }
    return scores;
  }
}

class D {
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

// class E {
//   int bagOfTokensScore(List<int> tokens, int power) {
//     int n = tokens.length;
//     if (!n) return n;
//     //  sort(tokens.begin(),tokens.end());
//     tokens.sort();
//     List<int> j = [];


//     List<int> n = prefix(n, tokens[0]);
//     for (int i = 1; i < n; i++) {
//       prefix[i] =
//           tokens[i] + prefix[i - 1]; // prefix to have prefix of power by tokens
//     }

//     int score = 0, c = 0; // no of tokens we face down
//     score = upper_bound(prefix.begin(), prefix.end(), power) -
//         prefix.begin(); // no of token we can face up with initial power

//     for (int i = n - 1; i >= 0; i--) {
//       // we try to face down large tokens and see how much tokens we can face up using prefix vector

//       if (score > 0) {
//         power += tokens[i]; // face down ith token
//         c++; // count of tokens faced down ++
//         score = max(
//             score,
//             (int)(upper_bound(prefix.begin(), prefix.begin() + i + 1, power) -
//                     prefix.begin()) -
//                 (c)); // the tokens we can face up using this power
//       }
//     }

//     return score;
//   }
// }
