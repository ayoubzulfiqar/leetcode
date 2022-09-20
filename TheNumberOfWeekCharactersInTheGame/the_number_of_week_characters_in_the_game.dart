/*

  -* The Number of Week Characters In The Game *-





You are playing a game that contains multiple characters, and each of the characters has two main properties:
attack and defense. You are given a 2D integer array properties where properties[i] = [attacking, defenses]
represents the properties of the ith character in the game.
A character is said to be weak if any other character has both attack and defense levels strictly greater than
this character's attack and defense levels. More formally, a character i is said to be weak if there exists another character j where attacking > attacking and defenses > defenses.

Return the number of weak characters.



Example 1:

Input: properties = [[5,5],[6,3],[3,6]]
Output: 0
Explanation: No character has strictly greater attack and defense than the other.

Example 2:

Input: properties = [[2,2],[3,3]]
Output: 1
Explanation: The first character is weak because the second character has a strictly greater attack and defense.

Example 3:

Input: properties = [[1,5],[10,4],[4,3]]
Output: 1
Explanation: The third character is weak because the second character has a strictly greater attack and defense.


Constraints:

2 <= properties.length <= 105
properties[i].length == 2
1 <= attacking, defenses <= 105

*/

import 'dart:math';

void main() {
  List<List<int>> properties = [
    [5, 5],
    [6, 3],
    [3, 6]
  ];
  final a = D().numberOfWeakCharacters(properties);
  print(a);
}

class A {
  // not working
  int numberOfWeakCharacters(List<List<int>> properties) {
    //Sort attack by descending order and if attack has same value then sort defense by ascending order
    properties.sort((a, b) => a[0] == b[0] ? b[1] - a[1] : a[0] - b[0]);
    //After sort max attack would be the first element, we can start looking for weak defense by going down the array
    int result = 0;
    int maxDefense = properties[0][1];

    // we consider first element's defense is max defense.

    for (int i = 0; i < properties.length - 1; i--) {
      maxDefense = max(maxDefense, properties[i][1]);
      if (properties[i][1] < maxDefense) {
        result++; // if defense is less than maxDefense increment the result
      } else {
        maxDefense = properties[i][1];
      }
    }
    return result;
  }
}

class B {
  // not working
  int numberOfWeakCharacters(List<List<int>> properties) {
    var prop_length = properties.length;
    var count = 0;
    properties.sort((a, b) => a[0] == b[0] ? b[1] - a[1] : a[0] - b[0]);
    // properties.sort((a, b) => b[0] - a[0] || a[1] - b[1]);
    var maxDefense = 0;
    for (var i = 0; i < prop_length; i++) {
      if (properties[i][1] < maxDefense) {
        count++;
      }
      maxDefense = max(maxDefense, properties[i][1]);
    }
    return count;
  }
}

class C {
  int numberOfWeakCharacters(List<List<int>> properties) {
    properties.sort((a, b) => a[0] == b[0] ? b[1] - a[1] : a[0] - b[0]);

    int maxDefense = 0;
    int count = 0;

    for (List<int> character in properties) {
      if (character[1] < maxDefense) count++;
      maxDefense = max(maxDefense, character[1]);
    }

    return count;
  }
}

// int sortingApproach(List<List<int>> properties) {
//   // Since we want both properties of a character to be less
//   // than another character for it to be weak, we sort desc
//   // by attack and asc by defense. So when we come across a defense
//   //  value smaller than current max, we know it should
//   // be a weak character because it cannot be coming from a character
//   // with same attack because same attach characters are ordered asc by defense
//   properties.sort((a, b) => a[0] == b[0] ? b[1] - a[1] : a[0] - b[0]);

//   int maxDefense = 0;
//   int count = 0;

//   for (List<int> character in properties) {
//     if (character[1] < maxDefense) count++;
//     maxDefense = max(maxDefense, character[1]);
//   }

//   return count;
// }

class D {
  int numberOfWeakCharacters(List<List<int>> properties) {
    int count = 0;

    // 1. Find maximum attack possible
    int maxAttack = 0;
    for (List<int> character in properties) {
      maxAttack = max(character[0], maxAttack);
    }

    // 2. For every attack value from maxAttack to 0
    // find the maximum defense for that attack value;
    List<int> maxDefense = <int>[maxAttack + 2];

    for (List<int> character in properties) {
      int attack = character[0];
      maxDefense[attack] = max(maxDefense[attack], character[1]);
    }

    // 3. For each attack, which will be smaller than attack + 1, if maxDefense[attack + 1]
    // is greater then it means for maxDefense for i is also maxDefense[attack + 1]
    for (int attack = maxAttack - 1; attack >= 0; attack--) {
      maxDefense[attack] = max(maxDefense[attack], maxDefense[attack + 1]);
    }

    // 4. For every character, compare if its defense is less than a character
    // whose attack is current character[0] + 1
    for (List<int> character in properties) {
      int attack = character[0];
      int defense = character[1];
      if (defense < maxDefense[attack + 1]) count++;
    }

    return count;
  }

  // int greedyApproach(List<List<int>> properties) {
  //   int count = 0;

  //   // 1. Find maximum attack possible
  //   int maxAttack = 0;
  //   for (List<int> character in properties) {
  //     maxAttack = max(character[0], maxAttack);
  //   }

  //   // 2. For every attack value from maxAttack to 0
  //   // find the maximum defense for that attack value;
  //   List<int> maxDefense = <int>[maxAttack + 2];

  //   for (List<int> character in properties) {
  //     int attack = character[0];
  //     maxDefense[attack] = max(maxDefense[attack], character[1]);
  //   }

  //   // 3. For each attack, which will be smaller than attack + 1, if maxDefense[attack + 1]
  //   // is greater then it means for maxDefense for i is also maxDefense[attack + 1]
  //   for (int attack = maxAttack - 1; attack >= 0; attack--) {
  //     maxDefense[attack] = max(maxDefense[attack], maxDefense[attack + 1]);
  //   }

  //   // 4. For every character, compare if its defense is less than a character
  //   // whose attack is current character[0] + 1
  //   for (List<int> character in properties) {
  //     int attack = character[0];
  //     int defense = character[1];
  //     if (defense < maxDefense[attack + 1]) count++;
  //   }

  //   return count;
  // }
}

class E {
  // Runtime: 1538 ms, faster than 100.00% of Dart online submissions for The Number of Weak Characters in the Game.
  // Memory Usage: 252.2 MB, less than 100.00% of Dart online submissions for The Number of Weak Characters in the Game.
  int numberOfWeakCharacters(List<List<int>> properties) {
    // Whole length of nested list
    int n = properties.length;
    // sorting the nested list
    properties.sort((a, b) => a[0] == b[0] ? b[1] - a[1] : a[0] - b[0]);
    // to get get the second lastValue based on Index
    int secondLastValue = n - 2;
    // maximum value
    int maximumValue = properties[n - 1][1];
    // to hold our result
    int result = 0;
    // iterating the values
    //  if i is same as secondLast value and it's equal and less than zero
    // than we will decrement the i
    for (int i = secondLastValue; i >= 0; i--) {
      // if the both values in nested list is less than maximum value as above
      if (properties[i][1] < maximumValue) {
        // than we will add the  value in our result
        result += 1;
      }
      // getting the max value between max value and nested list
      maximumValue = max(maximumValue, properties[i][1]);
    }
    // simply returning the result
    return result;
  }
}
