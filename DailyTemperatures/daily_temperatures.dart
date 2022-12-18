/*

- 739. Daily Temperatures -*


Given an array of integers temperatures represents the daily temperatures, return an array answer such that answer[i] is the number of days you have to wait after the ith day to get a warmer temperature. If there is no future day for which this is possible, keep answer[i] == 0 instead.

 

Example 1:

Input: temperatures = [73,74,75,71,69,72,76,73]
Output: [1,1,4,2,1,1,0,0]
Example 2:

Input: temperatures = [30,40,50,60]
Output: [1,1,1,0]
Example 3:

Input: temperatures = [30,60,90]
Output: [1,1,0]
 

Constraints:

1 <= temperatures.length <= 105
30 <= temperatures[i] <= 100

*/

/*



*/

class A {
  List<int> dailyTemperatures(List<int> temperatures) {
    List<int> res = List.filled(temperatures.length, 0);
    for (int i = temperatures.length - 2; i >= 0; i--) {
      int next = i + 1;
      while (
          next < temperatures.length && temperatures[next] <= temperatures[i]) {
        if (res[next] == 0) {
          next = temperatures.length;
          break;
        }
        next += res[next];
      }
      if (next < temperatures.length) {
        res[i] = next - i;
      }
    }
    return res;
  }
}

class B {
  // TLE
  List<int> dailyTemperatures(List<int> temperatures) {
    List<int> ar = List.filled(temperatures.length, 0);
    if (temperatures.length == 1) {
      ar[0] = 0;
    } else {
      for (int x = 0; x < temperatures.length; x++) {
        int p = 0;
        // int q = 0;
        for (int y = x + 1; y < temperatures.length; y++) {
          if (temperatures[x] < temperatures[y]) {
            ar[x] = (y - x).abs();
            p++;
            break;
          }
        }
        if (p == 0) {
          ar[x] = 0;
        }
      }
    }
    return ar;
  }
}

class C {
  List<int> dailyTemperatures(List<int> temperatures) {
    if (temperatures.isEmpty || temperatures.length == 0) {
      return [0];
    }
    int n = temperatures.length;
    List<int> res = List.filled(temperatures.length, 0);
    List<int> stack = [];
    for (int j = n - 1; j >= 0; j--) {
      while (stack.isNotEmpty && temperatures[stack.last] <= temperatures[j])
        stack.removeLast();
      res[j] = stack.isEmpty ? 0 : stack.last - j;
      stack.add(j);
    }
    return res;
  }
}
