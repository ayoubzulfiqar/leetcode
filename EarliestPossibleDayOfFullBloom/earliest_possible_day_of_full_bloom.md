# 🔥 3 Solutions 🔥 || Simple Fast and Easy || with Explanation

## Solution - 1 Sorting

```dart
class Pair {
  late int growTime, plantTime;
  Pair(int growTime, int plantTime) {
    this.growTime = growTime;
    this.plantTime = plantTime;
  }
}

class Solution {
  int earliestFullBloom(List<int> plantTime, List<int> growTime) {
    List<Pair> flowers = [];
    int flowerCount = plantTime.length;
    for (int i = 0; i < flowerCount; i++)
      flowers.add( Pair(growTime[i], plantTime[i]));
    //=========================================================
    //Sort the flowers on basis of decreasing growTime
    flowers.sort((Pair a, Pair b) {
      if (a.growTime > b.growTime)
        return -1;
      else if (a.growTime < b.growTime)
        return 1;
      else
        return 0;
    });
    //========================================================
    //currentTime denotes the time at which I finished planting the current flower
    //After the currentTime I am now free to plant another plant while the current flower grows
    //  SAVE TIME :)
    int currentTime = 0, mxBloomTime = 0;
    for (Pair flower in flowers) {
      currentTime += flower.plantTime;
      int bloomTime = currentTime +
          flower.growTime; //current flower will bloom at bloomTime
      mxBloomTime = max(mxBloomTime, bloomTime);
    }
    //=======================================================
    return mxBloomTime;
  }
}

```

## Solution - 2 Greedy

### GREEDY LOGIC

1. We can only save time while the flower is "Growing". We are not occupied while some flower is growing
2. So to save time

- Pick the flower with highest growing time at each step
- More growing time means more free time with us
- More free time means we can occupy ourselves in planting some other flower

```dart
class Solution {
  int earliestFullBloom(List<int> plantTime, List<int> growTime) {
    // sort by growTime
    int n = plantTime.length;
    List<int> arr = List.filled(100001, 0);
    for (int i = 0; i < n; i++) {
      arr[growTime[i]] += plantTime[i];
    }
    int current = 0, ans = 0;
    for (int i = arr.length - 1; i >= 1; i--) {
      if (arr[i] == 0) continue;
      current += arr[i];
      ans = max(ans, current + i);
    }
    return ans;
  }
}
```

## Solution - 3 2D Array

```dart
class Solution {
  int earliestFullBloom(List<int> plantTime, List<int> growTime) {
    int n = plantTime.length;
    List<List<int>> pairs =
        List.filled(n, 0).map((e) => List.filled(2, 0)).toList();
    for (int i = 0; i < n; i++) {
      pairs[i][0] = plantTime[i];
      pairs[i][1] = growTime[i];
    }
    pairs.sort((a, b) => b[1] - a[1]);
    int plantingDays = 0;
    int totalDays = 0;
    for (List<int> pair in pairs) {
      totalDays = max(totalDays, plantingDays + pair[0] + pair[1]);
      plantingDays += pair[0];
    }
    return totalDays;
  }
}
```
