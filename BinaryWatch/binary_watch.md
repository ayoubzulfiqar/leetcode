# 🔥 Binary Watch 🔥 || 3 Approaches || Simple Fast and Easy || with Explanation

## Solution - 1

```dart
class Solution {
  List<String> readBinaryWatch(int turnedOn) {
    List<int> dp = List.filled(60, 0); // number of set bits in ith
    for (int i = 1; i < 60; i++) {
      dp[i] = dp[i ~/ 2] + (i & 1);
    }

    List<String> res = [];

    for (int hr = 0; hr < 12; hr++) {
      for (int i = 0; i < 60; i++) {
        if (dp[i] + dp[hr] == turnedOn) {
          if (i < 10) {
            res.add(hr.toString() + ":0" + i.toString());
          } else {
            res.add(hr.toString() + ":" + i.toString());
          }
        }
      }
    }
    return res;
  }
}
```

## Solution - 2

```dart
class Solution {
  List<String> readBinaryWatch(int turnedOn) {
    List<String> result = [];
    List<int> used = List.filled(10, 0);
    helper(turnedOn, used, result, 0);
    result.sort();
    return result;
  }

  void helper(int num, List<int> used, List<String> result, int start) {
    if (num == 0) {
      String? time = getTime(used);
      if (time != null) result.add(time);
      return;
    }
    for (int i = start; i < used.length; i++) {
      if (used[i] == 0) {
        used[i] = 1;
        helper(num - 1, used, result, i + 1);
        used[i] = 0;
      }
    }
  }

  String? getTime(List<int> used) {
    HashMap<int, int> idxToVal = HashMap();
    idxToVal.addAll({0: 1, 1: 2, 2: 4, 4: 1, 5: 2, 6: 4, 7: 8, 8: 16, 9: 32});
    int hour = 0, mins = 0;
    for (int i = 0; i < used.length; i++) {
      if (used[i] == 1) {
        if (i <= 3) {
          hour += idxToVal[i] ?? 0;
        } else {
          mins += idxToVal[i] ?? 0;
        }
      }
    }
    if (hour >= 12 || mins >= 60) return null;

    StringBuffer timeStr = StringBuffer(hour.toString() + ":");
    if (mins <= 9) timeStr.write("0");
    timeStr.write(mins);
    return timeStr.toString();
  }
}
```

## Solution - 3

```dart
class Solution {
  List<String> readBinaryWatch(int num) {
    List<String> result = [];

    //range 0-3 are hours and range 4-9 are minutes
    List<int> arr = [1, 2, 4, 8, 1, 2, 4, 8, 16, 32];
    backtrack(arr, 0, 0, 0, num, result);
    return result;
  }

  void backtrack(List<int> arr, int position, int hours, int minutes, int limit,
      List<String> result) {
    //when num(limit) reaches to the zero, store hours and minutes into result list
    if (limit == 0) {
      //during recursion we might get e.g 4 + 8 = 12 hours which we must skip because max hour value could be 11
      if (hours <= 11 && minutes <= 59) {
        StringBuffer builder = StringBuffer();
        builder.write(hours);
        builder.write(":");
        builder.write(minutes <= 9 ? "0" + minutes.toString() : minutes);
        result.add(builder.toString());
      }
      return;
    }

    //standard backtracking solution add new value do recursion and then remove it
    for (int i = position; i < arr.length; i++) {
      if (isHour(i))
        hours += arr[i];
      else
        minutes += arr[i];

      backtrack(arr, i + 1, hours, minutes, limit - 1, result);

      if (isHour(i))
        hours -= arr[i];
      else
        minutes -= arr[i];
    }
  }

  //Simple check by range: hours or minutes
  bool isHour(int position) {
    return position >= 0 && position <= 3;
  }
}
```
