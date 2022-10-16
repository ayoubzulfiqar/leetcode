/*


 -* Minimum Difficulty of a Job Schedule *-

You want to schedule a list of jobs in d days. Jobs are dependent (i.e To work on the ith job, you have to finish all the jobs j where 0 <= j < i).

You have to finish at least one task every day. The difficulty of a job schedule is the sum of difficulties of each day of the d days. The difficulty of a day is the maximum difficulty of a job done on that day.

You are given an integer array jobDifficulty and an integer d. The difficulty of the ith job is jobDifficulty[i].

Return the minimum difficulty of a job schedule. If you cannot find a schedule for the jobs return -1.



Example 1:


Input: jobDifficulty = [6,5,4,3,2,1], d = 2
Output: 7
Explanation: First day you can finish the first 5 jobs, total difficulty = 6.
Second day you can finish the last job, total difficulty = 1.
The difficulty of the schedule = 6 + 1 = 7
Example 2:

Input: jobDifficulty = [9,9,9], d = 4
Output: -1
Explanation: If you finish a job per day you will still have a free day. you cannot find a schedule for the given jobs.
Example 3:

Input: jobDifficulty = [1,1,1], d = 3
Output: 3
Explanation: The schedule is one job per day. total difficulty will be 3.


Constraints:

1 <= jobDifficulty.length <= 300
0 <= jobDifficulty[i] <= 1000
1 <= d <= 10


*/
import 'dart:collection';
import 'dart:math';

class A {
  void dfs(List<int> jobDifficulty, int d, int idx, List<int> mini, int sum) {
    int jobs = jobDifficulty.length;
    // Base Case
    if (idx == jobs && d == 0) {
      mini[0] = min(sum, mini[0]);
      return;
    }
    if (d == 0 || jobs - idx < d) return;

    int diff = 0;
    for (int i = idx; i < jobs; i++) {
      diff = max(diff, jobDifficulty[i]);
      dfs(jobDifficulty, d - 1, i + 1, mini, sum + diff);
    }
    return;
  }

  int minDifficulty(List<int> jobDifficulty, int d) {
    // Corner Case
    if (jobDifficulty.length == 0) throw new ArgumentError();
    int jobs = jobDifficulty.length;
    if (jobs < d) return -1;

    List<int> min = <int>[1];
    min[0] = double.maxFinite.toInt();
    dfs(jobDifficulty, d, 0, min, 0);
    return min[0];
  }
}

class B {
  // TLE
  int minDifficulty(List<int> jobDifficulty, int d) {
    int len = jobDifficulty.length;
    if (d > len) return -1;
    // new int[d][len];
    List<List<int>> minDifficulty =
        List.filled(d, 0).map((e) => List.filled(len, 0)).toList();
    for (int i = 1; i < d; i++) {
      // Arrays.fill(minDifficulty[i], double.maxFinite.toInt());
      List.filled(minDifficulty[i].length, double.maxFinite.toInt());
    }
    int maxDifficulty = 0;
    for (int i = 0; i <= len - d; i++) {
      maxDifficulty = max(maxDifficulty, jobDifficulty[i]);
      minDifficulty[0][i] = maxDifficulty;
    }
    for (int day = 1; day < d; day++) {
      for (int to = day; to <= len - d + day; to++) {
        int currentDayDifficulty = jobDifficulty[to];
        int result = double.maxFinite.toInt();
        for (int j = to - 1; j >= day - 1; j--) {
          result =
              min(result, minDifficulty[day - 1][j] + currentDayDifficulty);
          currentDayDifficulty = max(currentDayDifficulty, jobDifficulty[j]);
        }
        minDifficulty[day][to] = result;
      }
    }
    return minDifficulty[d - 1][len - 1];
  }
}

class C {
// Runtime: 1382 ms, faster than 100.00% of Dart online submissions for Minimum Difficulty of a Job Schedule.
// Memory Usage: 152.5 MB, less than 100.00% of Dart online submissions for Minimum Difficulty of a Job Schedule.
  int minDifficulty(List<int> jobDifficulty, int d) {
    if (jobDifficulty.length < d || d <= 0) {
      return -1;
    }
    int n = jobDifficulty.length;
    List<int> dp = List.filled(n, 0);

    // initialization for d = 1
    dp[0] = jobDifficulty[0];
    for (int i = 1; i < n; i++) {
      dp[i] = max(dp[i - 1], jobDifficulty[i]);
    }

    for (int i = 2; i <= d; i++) {
      for (int j = n - 1; j >= i - 1; j--) {
        // space optimization requires this
        dp[j] = double.maxFinite.toInt();

        int lastMax = jobDifficulty[j]; // last sub-array's max difficulty
        for (int k = j - 1; k >= i - 2; k--) {
          // assume second last sub-array ends at A[k]
          lastMax = max(lastMax, jobDifficulty[k + 1]); // max(A[k+1..j])
          dp[j] = min(dp[j], lastMax + dp[k]);
        }
      }
    }
    return dp[n - 1];
  }
}

class D {
  int minDifficulty(List<int> jobDifficulty, int d) {
    if (jobDifficulty.length < d || d <= 0) {
      return -1;
    }
    int n = jobDifficulty.length;
    List<int> dp = List.filled(n, 0);
    List<int> old = List.filled(n, 0); // old dp

    // initialization for d = 1
    dp[0] = jobDifficulty[0];
    for (int i = 1; i < n; i++) {
      dp[i] = max(dp[i - 1], jobDifficulty[i]);
    }

    for (int i = 2; i <= d; i++) {
      // swap old and dp
      List<int> tmp = old;
      old = dp;
      dp = tmp;

      // descending stack for jobDifficulty, persisting index and oldMin(index)
      Queue<List<int>> stack = Queue();
      for (int j = i - 1; j < n; j++) {
        int oldMin = old[j - 1];
        while (stack.isNotEmpty &&
            jobDifficulty[stack.first[0]] <= jobDifficulty[j]) {
          oldMin = min(oldMin, stack.removeLast()[1]);
        }
        dp[j] = oldMin + jobDifficulty[j];
        if (stack.isNotEmpty) {
          dp[j] = min(dp[j], dp[stack.first[0]]);
        }
        // int[]{j, oldMin}
        stack.add(List.filled(j, oldMin));
      }
    }
    return dp[n - 1];
  }
}
