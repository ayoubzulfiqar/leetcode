# 🔥 Maximum Profit in Job Scheduling 🔥 || 2 Approaches || Simple Fast and Easy

```dart
class Job {
  late int start, end, profit;

  Job(int startTime, int endTime, int profit) {
    this.start = startTime;
    this.end = endTime;
    this.profit = profit;
  }
}
```

## Solution - 1

```dart
class Solution {
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
```

## Solution - 2

```dart
class Solution {
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
```
