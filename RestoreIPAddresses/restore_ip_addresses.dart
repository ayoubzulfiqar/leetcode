/*


-* 93. Restore IP Addresses *-


A valid IP address consists of exactly four integers separated by single dots. Each integer is between 0 and 255 (inclusive) and cannot have leading zeros.

For example, "0.1.2.201" and "192.168.1.1" are valid IP addresses, but "0.011.255.245", "192.168.1.312" and "192.168@1.1" are invalid IP addresses.
Given a string s containing only digits, return all possible valid IP addresses that can be formed by inserting dots into s. You are not allowed to reorder or remove any digits in s. You may return the valid IP addresses in any order.

 

Example 1:

Input: s = "25525511135"
Output: ["255.255.11.135","255.255.111.35"]
Example 2:

Input: s = "0000"
Output: ["0.0.0.0"]
Example 3:

Input: s = "101023"
Output: ["1.0.10.23","1.0.102.3","10.1.0.23","10.10.2.3","101.0.2.3"]
 

Constraints:

1 <= s.length <= 20
s consists of digits only.


*/
class A {
  List<String> ans = [];
  String str = "";
  List<String> restoreIpAddresses(String s) {
    str = s;
    magical("", 0, 0);
    return ans;
  }

  void magical(String path, int index, int dots) {
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
        magical(path + str.substring(index, index + length) + ".",
            index + length, dots + 1);
      }
    }
  }
}

class B {
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
