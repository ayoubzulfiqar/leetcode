/*

 -* Shortest Word Distance *-


 you’re given an array of strings and two different words.
 We need to return the shortest distance between these two words that appear in the input string.

 Example:
Input:  wordsDict = ["practice", "makes", "perfect", "coding", "makes"], word1 = "coding", word2 = "practice"
Output: 3
Explanation:

Word “coding” occurs at position 4.
Word “practice” occurs at position 1.
The shortest distance is 3.
Input:  wordsDict = ["practice", "makes", "perfect", "coding", "makes"], word1 = "makes", word2 = "coding"
Output: 1
Explanation:

Word “coding” occurs at position 4.
Word “makes” occurs at positions 2 and 5.
Shortest distance is 5-4 = 1.


*/
import 'dart:math';

class A {
// Time Complexity
// The time complexity of the above code is O(N) since we’re iterating over the entire input string exactly once.
//
// Space Complexity
// The space complexity of the above code is O(1) since we’re using only constant space.
  int shortestDistance(List<String> wordsDict, String word1, String word2) {
    int ans = double.maxFinite.toInt(), pos1 = -1, pos2 = -1;
    for (int i = 0; i < wordsDict.length; i++) {
      if (wordsDict[i] == word1) {
        pos1 = i;
      }
      if (wordsDict[i] == word2) {
        pos2 = i;
      }
      if (pos1 != -1 && pos2 != -1) {
        ans = min(ans, (pos1 - pos2).abs());
      }
    }
    return ans;
  }
}
