# 🔥 2 Solutions 🔥 || Simple Fast and Easy || with Explanation

## Solution -1

```dart
class Solution {
  List<String> ans = [];
  String str = "";
  List<String> restoreIpAddresses(String s) {
    str = s;
    soft("", 0, 0);
    return ans;
  }

  void soft(String path, int index, int dots) {
    if (dots > 4) return;
    if (dots == 4 && index >= str.length) {
      ans.add(path.substring(0, path.length - 1));
      return;
    }
    for (int length = 1;
        length <= 3 && index + length <= str.length;
        length++) {
      String nums = str.substring(index, index + length);
      if (nums[0] == '0' && length != 1)
        break;
      else if (int.parse(nums) <= 255) {
        soft(path + str.substring(index, index + length) + ".",
            index + length, dots + 1);
      }
    }
  }
}
```

## Solution - 2

```dart
class Solution {
  List<String> restoreIpAddresses(String s) {
    List<String> ips = [];
    int n = s.length;
    // iterate `s` - place 3 dots to have 4 segments
    // [seg1].[seg2].[seg3].[seg4]
    // 1st dot - we just need to run it 3 times at most
    // e.g. for 255, we can place the first dot at `2.55`, `25.5` or `255.`
    for (int i = 1; i < 4 && i < n; i++) {
      // we place the 2nd dot in a similar way
      for (int j = i + 1; j < i + 4 && j < n; j++) {
        // we place the 3rd dot in a similar way
        for (int k = j + 1; k < j + 4 && k < n; k++) {
          // now we can separate into 4 segments
          String seg1 = s.substring(0, i),
              seg2 = s.substring(i, j),
              seg3 = s.substring(j, k),
              seg4 = s.substring(k);
          // for each segment, check if it is valid
          if (ok(seg1) && ok(seg2) && ok(seg3) && ok(seg4)) {
            // if so, we build the ip address and push to answer
            ips.add(seg1 + "." + seg2 + "." + seg3 + "." + seg4);
          }
        }
      }
    }
    return ips;
  }

  bool ok(String s) {
    // string length > 3 is not a valid IP address segment
    if (s.length > 3 ||
        // empty segment is not valid
        s.length == 0 ||
        // if the first character is 0, we cannot have something like 0x, 0xx
        (s[0] == '0' && s.length > 1) ||
        // segment is out of range
        int.parse(s) > 255) {
      return false;
    }
    return true;
  }
}
```
