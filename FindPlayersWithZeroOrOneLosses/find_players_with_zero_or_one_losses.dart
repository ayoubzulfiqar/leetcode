/*


-* 2225. Find Players With Zero or One Losses *-

You are given an int array matches where matches[i] = [winner, loser] indicates that the player winner defeated player loser in a match.

Return a list answer of size 2 wherein

answer[0] is a list of all players that have not lost any matches.
answer[1] is a list of all players that have lost exactly one match.
The values in the two lists should be returned in increasing order.

Note

You should only consider the players that have played at least one match.
The test-cases will be generated such that no two matches will have the same outcome.
 

Example 1in

Input matches = [[1,3],[2,3],[3,6],[5,6],[5,7],[4,5],[4,8],[4,9],[10,4],[10,9]]
Output [[1,2,10],[4,5,7,8]]
Explanation
Players 1, 2, and 10 have not lost any matches.
Players 4, 5, 7, and 8 each have lost one match.
Players 3, 6, and 9 each have lost two matches.
Thus, answer[0] = [1,2,10] and answer[1] = [4,5,7,8].
Example 2in

Input matches = [[2,3],[1,3],[5,4],[6,4]]
Output [[1,2,5,6],[]]
Explanation
Players 1, 2, 5, and 6 have not lost any matches.
Players 3 and 4 each have lost two matches.
Thus, answer[0] = [1,2,5,6] and answer[1] = [].
 

Constraints

1 <= matches.length <= 105
matches[i].length == 2
1 <= winner, loser <= 105
winner != loser
All matches[i] are unique.



*/

class A {
  List<List<int>> findWinners(List<List<int>> matches) {
    Map<int, int> losers = Map();
    Set<int> winners = Set();
    for (List<int> m in matches) {
      int key = m[1];
      if (losers.containsKey(key)) {
        losers[key] = losers[key]! + 1;
      } else {
        losers[key] = 1;
      }
      winners.add(m[0]);
    }

    List<int> loserList = [];
    List<int> winnerList = [];
    for (int loser in losers.keys) {
      if (losers[loser] == 1) {
        loserList.add(loser);
      }
    }
    for (int winner in winners) {
      if (!losers.containsKey(winner)) {
        winnerList.add(winner);
      }
    }
    List<List<int>> result = [];
    result.add(winnerList..sort());
    result.add(loserList..sort());
    return result;
  }
}

class B {
  List<List<int>> findWinners(List<List<int>> matches) {
    List<int> won = List.filled(100001, 0);
    List<int> loss = List.filled(100001, 0);

    for (List<int> match in matches) {
      won[match[0]]++;
      loss[match[1]]++;
    }

    List<List<int>> ans = [];

    List<int> wonAllMatches = [];
    List<int> lostOneMatch = [];

    for (int i = 0; i < won.length; i++) {
      if (won[i] > 0 && loss[i] == 0) {
        //for checking players that have not lost any match.
        wonAllMatches.add(i);
      }

      if (loss[i] == 1) {
        lostOneMatch
            .add(i); //for checking players that have lost exactly one match.
      }
    }

    ans.add(wonAllMatches);
    ans.add(lostOneMatch);

    return ans;
  }
}

class C {
  List<List<int>> findWinners(List<List<int>> matches) {
    Map<int, int> d = Map<int, int>();
    for (int i = 0; i < matches.length; i++) {
      if (!d.containsKey(matches[i][0])) d[matches[i][0]] = 0;
      if (!d.containsKey(matches[i][1])) d[matches[i][1]] = 0;
      d[matches[i][1]] = d[matches[i][1]]! + 1;
    }

    List<List<int>> ans = [];
    for (int i = 0; i < 2; i++) ans.add([]);
    d.forEach((player, losses) {
      if (losses < 2) ans[losses].add(player);
    });
    for (int i = 0; i < 2; i++) ans[i] = ans[i].toList()..sort();
    return ans;
  }
}
