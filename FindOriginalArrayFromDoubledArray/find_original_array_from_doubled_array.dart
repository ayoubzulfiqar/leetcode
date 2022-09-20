/*

   -*  Find Original Array From Doubled Array *-



An integer array original is transformed into a doubled array changed by appending twice the value of every element in original, and then randomly shuffling the resulting array.

Given an array changed, return original if changed is a doubled array. If changed is not a doubled array, return an empty array. The elements in original may be returned in any order.



Example 1:

Input: changed = [1,3,4,2,6,8]
Output: [1,3,4]
Explanation: One possible original array could be [1,3,4]:
- Twice the value of 1 is 1 * 2 = 2.
- Twice the value of 3 is 3 * 2 = 6.
- Twice the value of 4 is 4 * 2 = 8.
Other original arrays could be [4,3,1] or [3,1,4].


Example 2:

Input: changed = [6,3,0,1]
Output: []
Explanation: changed is not a doubled array.


Example 3:

Input: changed = [1]
Output: []
Explanation: changed is not a doubled array.


Constraints:

1 <= changed.length <= 105
0 <= changed[i] <= 105


*/

import 'dart:collection';
import 'dart:math';

class A {
  List<int> findOriginalArray(List<int> changed) {
    int n = changed.length;
    if (n % 2 == 1) return [];

    ///  sort(changed.begin(), changed.end());
    changed.sort();
    List<int> ans = [];
    Map<int, int> mp = {};
    for (int i = 0; i < n; i++) {
      mp[changed[i]++];
    }
    for (int i = 0; i < n; i++) {
      if (mp[changed[i]] == 0) continue;
      if (mp[changed[i] * 2] == 0) return [];
      ans.add(changed[i]);
      mp[changed[i]--];
      mp[changed[i] * 2];
    }
    return ans;
  }
}

class B {
  List<int> findOriginalArray(List<int> changed) {
    int n = changed.length, j = 0;
    // if the length of the input is odd, then return []
    // because doubled array must have even length
    if (n % 2 == 1) return [];
    List<int> ans = [n ~/ 2];
    // alternatively, you can find the max number in `changed`
    // then use new int[2 * mx + 1]
    List<int> cnt = [200005];
    // count the frequency of each number -   // range error index value is 0:1
    for (int x in changed) cnt[x] += 1;
    // changed.forEach((element) {
    //   // rage error
    //   cnt[element.compareTo(0)] += 1;
    // });
    // iterate from 0 to max number
    for (int i = 0; i < 200005; i++) {
      // check if the count of number i is greater than 0
      if (cnt[i] > 0) {
        // number i exists, decrease by 1
        cnt[i] -= 1;
        // look for the doubled value
        if (cnt[i * 2] > 0) {
          // doubled value exists, decrease by 1
          cnt[i * 2] -= 1;
          // add this number to ans
          ans[j++] = i--;
        } else {
          // cannot pair up, return []
          return [];
        }
      }
    }
    return ans;
  }
}

class C {
  List<int> findOriginalArray(List<int> changed) {
    List<int> temp = [changed.length ~/ 2];
    Queue<int> x = Queue();
    changed.sort();
    int i = 0;
    for (int nums in changed) {
      if (!x.isEmpty && x.first == nums)
        // range error index value is 0:1
        temp[i++] = x.removeFirst() ~/ 2;
      else
        x.add(nums * 2);
    }
    return x.length > 0 ? [] : temp;
  }
}

class D {
  List<int> findOriginalArray(List<int> changed) {
    if (changed.length < 2) return [];
    changed.sort();
    HashSet<int> visited = HashSet();
    List<int> list = [];

    int lo = 0, hi = changed.length - 1;
    int index = 0;
    for (int i = 0; i < changed.length; i++) {
      int ele = changed[i];
      if (visited.contains(i)) continue;
      //Search next double element from remaining Array or nextIndex
      lo = max(index + 1, i + 1);
      index = findMinIndex(lo, hi, changed, 2 * ele);
      if (index == -1) return [];
      list.add(ele);
      visited.add(index);
    }

    List<int> res = [list.length];
    for (int i = 0; i < list.length; i++)
      // range error
      res[i] = list.elementAt(i);

    return res;
  }

  int findMinIndex(int lo, int hi, List<int> nums, int target) {
    int res = -1;
    while (lo <= hi) {
      int mid = lo + (hi - lo) ~/ 2;
      if (nums[mid] == target) {
        res = mid;
        hi = mid - 1;
      } else if (nums[mid] > target)
        hi = mid - 1;
      else
        lo = mid + 1;
    }
    return res;
  }
}
