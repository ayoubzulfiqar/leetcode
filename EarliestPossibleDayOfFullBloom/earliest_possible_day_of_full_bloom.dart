/*

-* Earliest Possible Day of Full Bloom *-



You have n flower seeds. Every seed must be planted first before it can begin to grow, then bloom. Planting a seed takes time and so does the growth of a seed. You are given two 0-indexed integer arrays plantTime and growTime, of length n each:

plantTime[i] is the number of full days it takes you to plant the ith seed. Every day, you can work on planting exactly one seed. You do not have to work on planting the same seed on consecutive days, but the planting of a seed is not complete until you have worked plantTime[i] days on planting it in total.
growTime[i] is the number of full days it takes the ith seed to grow after being completely planted. After the last day of its growth, the flower blooms and stays bloomed forever.
From the beginning of day 0, you can plant the seeds in any order.

Return the earliest possible day where all seeds are blooming.



Example 1:


Input: plantTime = [1,4,3], growTime = [2,3,1]
Output: 9
Explanation: The grayed out pots represent planting days, colored pots represent growing days, and the flower represents the day it blooms.
One optimal way is:
On day 0, plant the 0th seed. The seed grows for 2 full days and blooms on day 3.
On days 1, 2, 3, and 4, plant the 1st seed. The seed grows for 3 full days and blooms on day 8.
On days 5, 6, and 7, plant the 2nd seed. The seed grows for 1 full day and blooms on day 9.
Thus, on day 9, all the seeds are blooming.
Example 2:


Input: plantTime = [1,2,3,2], growTime = [2,1,2,1]
Output: 9
Explanation: The grayed out pots represent planting days, colored pots represent growing days, and the flower represents the day it blooms.
One optimal way is:
On day 1, plant the 0th seed. The seed grows for 2 full days and blooms on day 4.
On days 0 and 3, plant the 1st seed. The seed grows for 1 full day and blooms on day 5.
On days 2, 4, and 5, plant the 2nd seed. The seed grows for 2 full days and blooms on day 8.
On days 6 and 7, plant the 3rd seed. The seed grows for 1 full day and blooms on day 9.
Thus, on day 9, all the seeds are blooming.
Example 3:

Input: plantTime = [1], growTime = [1]
Output: 2
Explanation: On day 0, plant the 0th seed. The seed grows for 1 full day and blooms on day 2.
Thus, on day 2, all the seeds are blooming.


Constraints:

n == plantTime.length == growTime.length
1 <= n <= 105
1 <= plantTime[i], growTime[i] <= 104


*/

import 'dart:math';

class B {
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

class C {
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
      flowers.add(new Pair(growTime[i], plantTime[i]));
    //=========================================================
    //Sort the flowers on basis of decreasing growTime
    // Collections.sort(flowers, (Pair a, Pair b)->{  //OR "return (a.growTime - b.growTime)"
    //     if (a.growTime > b.growTime) return -1;
    //     else if (a.growTime < b.growTime) return 1;
    //     else return 0;
    // });
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
