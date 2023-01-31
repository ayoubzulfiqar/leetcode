/*


-* 1626. Best Team With No Conflicts *-



You are the manager of a basketball team. For the upcoming tournament, you want to choose the team with the highest overall score. The score of the team is the sum of scores of all the players in the team.

However, the basketball team is not allowed to have conflicts. A conflict exists if a younger player has a strictly higher score than an older player. A conflict does not occur between players of the same age.

Given two lists, scores and ages, where each scores[i] and ages[i] represents the score and age of the ith player, respectively, return the highest overall score of all possible basketball teams.

 

Example 1:

Input: scores = [1,3,5,10,15], ages = [1,2,3,4,5]
Output: 34
Explanation: You can choose all the players.
Example 2:

Input: scores = [4,5,6,5], ages = [2,1,2,1]
Output: 16
Explanation: It is best to choose the last 3 players. Notice that you are allowed to choose multiple people of the same age.
Example 3:

Input: scores = [1,2,3,5], ages = [8,9,10,1]
Output: 6
Explanation: It is best to choose the first 3 players. 
 

Constraints:

1 <= scores.length, ages.length <= 1000
scores.length == ages.length
1 <= scores[i] <= 106
1 <= ages[i] <= 1000

*/

import 'dart:math';

class Player {
  late int age;
  late int score;
  Player(int age, int score) {
    this.age = age;
    this.score = score;
  }
}

class A {
  // List<List<int>> dp =
  //     List.filled(1005, 0).map((e) => List.filled(1005, 0)).toList();
  int bestTeamScore(List<int> scores, List<int> ages) {
    final int n = scores.length;
    List<Player> players = [];
    // dp[i] := max score of choosing players[0..i] w/ players[i] being selected
    List<int> dp = List.filled(n, 0);

    for (int i = 0; i < n; ++i) players[i] = new Player(ages[i], scores[i]);

    players.sort((a, b) => a.age == b.age ? b.score - a.score : b.age - a.age);

    for (int i = 0; i < n; ++i) {
      // For each player, we choose it first
      dp[i] = players[i].score;
      // players[j].age >= players[i].age since we sort in descending order
      // So we only have to check that
      // players[j].score >= players[i].score
      for (int j = 0; j < i; ++j)
        if (players[j].score >= players[i].score)
          dp[i] = max(dp[i], dp[j] + players[i].score);
    }

    return dp[n];
  }
}

class B {
  int bestTeamScore(List<int> scores, List<int> ages) {
    int n = scores.length;
    List<List<int>> players =
        List.filled(n, 0).map((e) => List.filled(2, 0)).toList();

    for (int i = 0; i < n; i++) {
      players[i][0] = scores[i];
      players[i][1] = ages[i];
    }

    // Sorting Players on the basis of scores(Ascending) and break their ties on the basis of age(Ascending)
    players.sort(
        (a, b) => a[0] == b[0] ? a[1].compareTo(b[1]) : a[0].compareTo(b[0]));

    List<int> dp = List.filled(n, 0);
    int maxi = 0;
    for (int i = 0; i < n; i++) {
      dp[i] = search(dp, players, i) + players[i][0];
      maxi = max(maxi, dp[i]);
    }

    return maxi;
  }

  int search(List<int> dp, List<List<int>> players, int i) {
    int maxi = 0;
    for (int j = 0; j < i; j++) {
      if (dp[j] > maxi && players[j][1] <= players[i][1]) {
        maxi = dp[j];
      }
    }
    return maxi;
  }
}
