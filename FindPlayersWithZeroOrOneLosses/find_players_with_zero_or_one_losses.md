# 🔥 3 Approaches 🔥 || Simple Fast and Easy || with Explanation

## Solution - 1

```dart
class Solution {
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
```

## Solution - 2

```dart
class Solution {
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
```

## Solution - 3

```dart
class Solution {
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
```
