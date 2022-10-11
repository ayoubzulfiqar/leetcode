# 🔥 Shortest Word Distance 🔥 || Premium Leetcode || with Explanation

## Approach

This is a straight-forward coding problem. The distance between any two positions i_1i1​ and i_2i2​ in an array is |i_1 – i_2|∣i1​−i2​∣. To find the shortest distance between word1 and word2, we need to traverse the input array and find all occurrences i_1i1​ and i_2i2​ of the two words, and check if |i_1 – i_2|∣i1​−i2​∣ is less than the minimum distance computed so far.

## Idea

Maintain two position variables for each word.
Iterate in the string array and update two position variables accordingly.
Our Answer is the minimum absolute difference between these position variables.

 Time Complexity
 The time complexity of the above code is O(N) since we’re iterating over the entire input string exactly once.

 Space Complexity
 The space complexity of the above code is O(1) since we’re using only constant space.

```dart
class Solution {
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
```

```go
func shortestDistance(wordsDict []string, word1 string, word2 string) int {
	ans := math.MaxInt32
	firstPosition := -1
	secondPosition := -1
	for i := 0; i < len(wordsDict); i++ {
		if wordsDict[i] == word1 {
			firstPosition = i
		}
		if wordsDict[i] == word2 {
			secondPosition = i
		}
		if firstPosition != -1 && secondPosition != -1 {
			ans = int(math.Min(float64(ans), math.Abs(float64(firstPosition)-float64(secondPosition))))
		}
	}
	return ans

}
```
