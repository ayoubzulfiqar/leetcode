package main

import "math"

/*

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
*/

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
