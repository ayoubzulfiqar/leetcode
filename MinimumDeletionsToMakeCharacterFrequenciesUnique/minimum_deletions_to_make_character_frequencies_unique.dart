/*

-* 1647. Minimum Deletions to Make Character Frequencies Unique *-

A string s is called good if there are no two different characters in s that have the same frequency.

Given a string s, return the minimum number of characters you need to delete to make s good.

The frequency of a character in a string is the number of times it appears in the string. For example, in the string "aab", the frequency of 'a' is 2, while the frequency of 'b' is 1.

 

Example 1:

Input: s = "aab"
Output: 0
Explanation: s is already good.
Example 2:

Input: s = "aaabbbcc"
Output: 2
Explanation: You can delete two 'b's resulting in the good string "aaabcc".
Another way it to delete one 'b' and one 'c' resulting in the good string "aaabbc".
Example 3:

Input: s = "ceabaacb"
Output: 2
Explanation: You can delete both 'c's resulting in the good string "eabaab".
Note that we only care about characters that are still in the string at the end (i.e. frequency of 0 is ignored).
 

Constraints:

1 <= s.length <= 105
s contains only lowercase English letters.


*/

class DSU {
  late List<int> par;

  DSU(int n) {
    par = List<int>.generate(n + 1, (i) => i);
  }

  int findPar(int x) => x == par[x] ? x : par[x] = findPar(par[x]);

  void merge(int u, int v) => par[v] = u;
}

class Solution {
  int minDeletions(String s) {
    // Using DSU
    // Think of this problem as a Job Sequencing Problem

    // First, store the frequency of all characters
    final List<int> a = List<int>.filled(26, 0);
    int n = s.length;
    for (int i = 0; i < n; i++) {
      a[s.codeUnitAt(i) - 'a'.codeUnitAt(0)]++;
    }

    // Find the maximum among all the frequencies
    int maxi = 0;
    for (int it in a) {
      maxi = maxi > it ? maxi : it;
    }

    // Make DSU of size - maximum
    final DSU d = DSU(maxi);
    int cnt = 0; // cnt stores the answer

    for (int i = 0; i < 26; i++) {
      // Find the nearest available free slot for
      // this frequency (corresponding to its frequency)
      final int available = d.findPar(a[i]);

      // If an available free slot is greater
      // than 0, then a free slot is available
      if (available > 0) {
        // This slot is taken by this job 'i'
        // so we need to update the greatest(nearest)
        // free slot. Note that, in merge, we
        // make the first parameter as the parent of
        // the second parameter. So future queries
        // for availableSlot will return the maximum(nearest)
        // available slot in the set of
        // "availableSlot - 1"
        d.merge(d.findPar(available - 1), available);
      }
      // We assign the nearest(greatest) frequency now
      // (frequency-assign slot) will be the number of
      // removed characters(answer)
      cnt += (a[i] - available);
    }
    return cnt;
  }
}
