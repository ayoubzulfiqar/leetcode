# 🔥 100% FASt 🔥 || Simple Fast and Easy || with Explanation

## Intuition

Lets take 2 words Coffee and Donuts. We can form 2 new words by replacing/exchanging the first letter of these words.
i.e Doffee and Conuts.

Instead of just 2 words, we are given an array, we have to form all valid words that are not already present in original Array

eg: [coffee, donuts, time, toffee] will form 6 pairs, i.e coffe with donuts, time and toffee(Similar to shaking hands).

Each pair will form 2 new words. Check if the words are already present in the original array, if not increase count.

So 6 is the answer in above case.

Ideas: There is no reason to form pair with words having same start letter i.e time and toffee.
And donuts can only form 1 new word starting with T, Tonuts, no matter there are n words starting with T.

So the idea is to group the words based on the initials and separate initials from suffix.

If 2 words have same suffix, again they can't form new words.

Approach

- Create an array of size 26, each corresponding to a letter eg:a :0, b:1
- The above array is an array of HashSet. Each HashSet containing words starting from index letter.
- Group the words and put the suffix into their respective HashSet.
- Initialize i = 0 and j =i at every step(to form pairs).
- Count mutual suffix or words b/w the 2 HashSet.
- Add `2 *(groups[i].size() - mutuals)* (groups[j].size() - mutuals)` to answer at each step.
- Return Answer.

## Code -1

```dart
class Solution {
  int distinctNames(List<String> ideas) {
    List<HashSet<String>> groups = List.filled(26, HashSet());
    for (int i = 0; i < 26; ++i) {
      groups[i] = HashSet();
    }
    for (String idea in ideas) {
      groups[idea.codeUnitAt(0) - 'a'.codeUnitAt(0)].add(idea.substring(1));
    }

    int answer = 0;
    for (int i = 0; i < 25; ++i) {
      for (int j = i + 1; j < 26; ++j) {
        int mutuals = 0;
        for (String ideaA in groups[i]) {
          if (groups[j].contains(ideaA)) {
            mutuals++;
          }
        }
        answer +=
            2 * (groups[i].length - mutuals) * (groups[j].length - mutuals);
      }
    }

    return answer;
  }
}
```

## Code -2

```dart
class Solution {
  int distinctNames(List<String> ideas) {
    List<HashSet<String>> sets = List.filled(26, HashSet());
    for (int i = 0; i < 26; i++) {
      sets[i] = HashSet();
    }
    for (String s in ideas) {
      sets[s.codeUnitAt(0) - 'a'.codeUnitAt(0)].add(s.substring(1));
    }
    List<List<int>> same =
        List.filled(26, 0).map((e) => List.filled(26, 0)).toList();
    for (int i = 0; i < 26; i++) {
      for (String s in sets[i]) {
        for (int j = i + 1; j < 26; j++) {
          if (sets[j].contains(s)) {
            same[i][j]++;
          }
        }
      }
    }
    int res = 0;
    for (int i = 0; i < 26; i++) {
      for (int j = i + 1; j < 26; j++) {
        res +=
            (sets[i].length - same[i][j]) * (sets[j].length - same[i][j]) * 2;
      }
    }
    return res;
  }
}
```
