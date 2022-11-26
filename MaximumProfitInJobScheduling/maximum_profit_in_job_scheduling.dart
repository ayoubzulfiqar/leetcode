/*

-* 1235. Maximum Profit in Job Scheduling *-

We have n jobs, where every job is scheduled to be done from startTime[i] to endTime[i], obtaining a profit of profit[i].

You're given the startTime, endTime and profit arrays, return the maximum profit you can take such that there are no two jobs in the subset with overlapping time range.

If you choose a job that ends at time X you will be able to start another job that starts at time X.

 

Example 1:



Input: startTime = [1,2,3,3], endTime = [3,4,5,6], profit = [50,10,40,70]
Output: 120
Explanation: The subset chosen is the first and fourth job. 
Time range [1-3]+[3-6] , we get profit of 120 = 50 + 70.
Example 2:



Input: startTime = [1,2,3,4,6], endTime = [3,5,10,6,9], profit = [20,20,100,70,60]
Output: 150
Explanation: The subset chosen is the first, fourth and fifth job. 
Profit obtained 150 = 20 + 70 + 60.
Example 3:



Input: startTime = [1,1,1], endTime = [2,3,4], profit = [5,6,4]
Output: 6
 

Constraints:

1 <= startTime.length == endTime.length == profit.length <= 5 * 104
1 <= startTime[i] < endTime[i] <= 109
1 <= profit[i] <= 104

 */

import 'dart:math';

class Job {
  late int start, end, profit;

  Job(int startTime, int endTime, int profit) {
    this.start = startTime;
    this.end = endTime;
    this.profit = profit;
  }
}

class A {
  int jobScheduling(List<int> startTime, List<int> endTime, List<int> profit) {
    int n = profit.length;
    Job job = Job(startTime.length, endTime.length, profit.length);
    List<Job> jobs = List.filled(n, job);
    for (int i = 0; i < startTime.length; i++) {
      jobs[i] = (Job(startTime[i], endTime[i], profit[i]));
    }

    List<int> dp = List.filled(jobs.length, 0);
    // Arrays.sort(jobs, (a,b)->(a.end - b.end))
    jobs.sort((a, b) => a.end - b.end);

    dp[0] = jobs[0].profit;
    for (int i = 1; i < jobs.length; i++) {
      dp[i] = max(jobs[i].profit, dp[i - 1]);
      for (int j = i - 1; j >= 0; j--) {
        if (jobs[j].end <= jobs[i].start) {
          dp[i] = max(dp[i], jobs[i].profit + dp[j]);
          break;
        }
      }
    }
    int maxi = 0;
    for (int val in dp) {
      maxi = max(val, maxi);
    }
    return maxi;
  }
}

class B {
  int jobScheduling(List<int> startTime, List<int> endTime, List<int> profit) {
    if (startTime.length == 0) {
      return 0;
    }

    List<Job> jobs = [];
    for (int index = 0; index < startTime.length; ++index) {
      jobs.add(Job(startTime[index], endTime[index], profit[index]));
    }

    jobs.sort((a, b) => a.start - b.start);

    return dfs(jobs, 0, Map<int, int>());
  }

  int dfs(List<Job> jobs, int currentJobIndex, Map<int, int> maxProfits) {
    if (currentJobIndex >= jobs.length) {
      return 0;
    }

    if (maxProfits.containsKey(currentJobIndex)) {
      return maxProfits[currentJobIndex]!;
    }

    int next = binarySearch(jobs, currentJobIndex);
    int inc = jobs[currentJobIndex].profit + dfs(jobs, next, maxProfits);
    int exc = dfs(jobs, currentJobIndex + 1, maxProfits);

    int maxProfit = max(inc, exc);
    maxProfits[currentJobIndex] = maxProfit;
    return maxProfit;
  }

  int binarySearch(List<Job> jobs, int currentJobIndex) {
    int lo = currentJobIndex;
    int high = jobs.length - 1;
    int result = jobs.length;

    while (lo <= high) {
      int mid = lo + (high - lo) ~/ 2;

      if (jobs[currentJobIndex].end <= jobs[mid].start) {
        result = mid;
        high = mid - 1;
      } else {
        lo = mid + 1;
      }
    }
    return result;
  }
}
