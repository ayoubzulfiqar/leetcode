/*


-* 904. Fruit Into Baskets *-



You are visiting a farm that has a single row of fruit trees arranged from left to right. The trees are represented by an integer array fruits where fruits[i] is the type of fruit the ith tree produces.

You want to collect as much fruit as possible. However, the owner has some strict rules that you must follow:

You only have two baskets, and each basket can only hold a single type of fruit. There is no limit on the amount of fruit each basket can hold.
Starting from any tree of your choice, you must pick exactly one fruit from every tree (including the start tree) while moving to the right. The picked fruits must fit in one of your baskets.
Once you reach a tree with fruit that cannot fit in your baskets, you must stop.
Given the integer array fruits, return the maximum number of fruits you can pick.

 

Example 1:

Input: fruits = [1,2,1]
Output: 3
Explanation: We can pick from all 3 trees.
Example 2:

Input: fruits = [0,1,2,2]
Output: 3
Explanation: We can pick from trees [1,2,2].
If we had started at the first tree, we would only pick from trees [0,1].
Example 3:

Input: fruits = [1,2,3,2,2]
Output: 4
Explanation: We can pick from trees [2,3,2,2].
If we had started at the first tree, we would only pick from trees [1,2].
 

Constraints:

1 <= fruits.length <= 105
0 <= fruits[i] < fruits.length


*/

import 'dart:collection';
import 'dart:math';

class A {
  int totalFruit(List<int> fruits) {
    List<int> counts = List.filled(fruits.length, 0);
    int maximum = 0;
    int currentMax = 0;
    int typeCount = 0;
    int start = 0;

    for (int i = 0; i < fruits.length; i++) {
      if (counts[fruits[i]] == 0) typeCount++;
      counts[fruits[i]]++;
      currentMax++;

      while (typeCount > 2 && start < i) {
        counts[fruits[start]]--;
        if (counts[fruits[start]] == 0) typeCount--;
        start++;
        currentMax--;
      }

      maximum = max(maximum, currentMax);
    }

    return maximum;
  }
}

class B {
  int totalFruit(List<int> fruits) {
    HashMap<int, int> basket = HashMap();
    int j = 0;
    int i = 0;
    int res = 0;
    for (i = 0; i < fruits.length; i++) {
      basket[fruits[i]] = (basket[fruits[i]] ?? 0) + 1;
      while (basket.length > 2) {
        basket[fruits[j]] = basket[fruits[j]]! - 1;
        basket.remove(fruits[j]);
        j++;
      }
      res = max(res, i - j + 1);
    }
    return res;
  }
}

class C {
  int totalFruit(List<int> fruits) {
    int n = fruits.length, ans = 0;
    // count the frequency of fruits
    HashMap<int, int> m = HashMap();
    // two pointers
    // - l is the pointer to the starting index of the window
    // - r is the pointer to the ending index of the window
    for (int l = 0, r = 0; r < n; r++) {
      // add fruits[r] to a hashmap
      m[fruits[r]] = (m[fruits[r]] ?? 0) + 1;
      // if there is more than two types
      if (m.length > 2) {
        // then we need to sub-tract one from the freq of leftmost element, i.e. fruits[l]
        // if it is 0, then we can erase it
        m[fruits[l]] = (m[fruits[l]] ?? 0) - 1;
        if (m[fruits[l]] == 0) m.remove(fruits[l]);
        // shrink the window by moving the `l` to the right
        l += 1;
      }
      // the maximum number of fruits we can pick is simply the window size
      ans = max(ans, r - l + 1);
    }
    return ans;
  }
}
