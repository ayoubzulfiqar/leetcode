/*

-* 352. Data Stream as Disjoint Intervalues *-

Given a data stream input of non-negative integers a1, a2, ..., an, summarize the numbers seen so far as a list of disjoint intervalues.

Implement the SummaryRanges class:

SummaryRanges() Initializes the object with an empty stream.
void addNum(int valueue) Adds the integer valueue to the stream.
int[][] getIntervalues() Returns a summary of the integers in the stream currently as a list of disjoint intervalues [startI, endI]. The answer should be sorted by startI.
 

Example 1:

Input
["SummaryRanges", "addNum", "getIntervalues", "addNum", "getIntervalues", "addNum", "getIntervalues", "addNum", "getIntervalues", "addNum", "getIntervalues"]
[[], [1], [], [3], [], [7], [], [2], [], [6], []]
Output
[null, null, [[1, 1]], null, [[1, 1], [3, 3]], null, [[1, 1], [3, 3], [7, 7]], null, [[1, 3], [7, 7]], null, [[1, 3], [6, 7]]]

Explanation
SummaryRanges summaryRanges = new SummaryRanges();
summaryRanges.addNum(1);      // arr = [1]
summaryRanges.getIntervalues(); // return [[1, 1]]
summaryRanges.addNum(3);      // arr = [1, 3]
summaryRanges.getIntervalues(); // return [[1, 1], [3, 3]]
summaryRanges.addNum(7);      // arr = [1, 3, 7]
summaryRanges.getIntervalues(); // return [[1, 1], [3, 3], [7, 7]]
summaryRanges.addNum(2);      // arr = [1, 2, 3, 7]
summaryRanges.getIntervalues(); // return [[1, 3], [7, 7]]
summaryRanges.addNum(6);      // arr = [1, 2, 3, 6, 7]
summaryRanges.getIntervalues(); // return [[1, 3], [6, 7]]
 

Constraints:

0 <= valueue <= 104
At most 3 * 104 calls will be made to addNum and getIntervalues.
 

Follow up: What if there are lots of merges and the number of disjoint intervalues is small compared to the size of the data stream?


*/
/*



class SummaryRanges {

  SummaryRanges() {

  }
  
  void addNum(int valueue) {

  }
  
  List<List<int>> getIntervalues() {

  }
}


*/

import 'dart:collection';

// class SummaryRanges {
//   late HashSet<int> dataSet;
//   SummaryRanges() {
//     this.dataSet = HashSet();
//   }

//   void addNum(int valueue) {
//     dataSet.add(valueue);
//   }

//   List<List<int>> getIntervalues() {
//     List<List<int>> intervalues = <int>[].map((e) => <int>[]).toList();

//     int startI = -1, endI = -1;
//     for (int n in dataSet) {
//       if (startI == -1) {
//         startI = n;
//         endI = n;
//       } else if (n == endI + 1) {
//         endI = n;
//       } else {
//         intervalues.add([startI, endI]);
//         endI = n;
//         startI = n;
//       }
//     }
//     intervalues.add([startI, endI]);
//     return intervalues;
//   }
// }

class SummaryRanges {
  HashMap<int, int> front = HashMap();
  HashMap<int, int> back = HashMap();
  HashSet<int> set = HashSet();
  SummaryRanges() {}

  void addNum(int value) {
    if (set.contains(value)) {
      return;
    }

    if (back.containsKey(value - 1) && front.containsKey(value + 1)) {
      int st = back[value - 1] ?? 0;
      int end = front[value + 1] ?? 0;
      front.remove(value + 1);
      front.remove(st);
      back.remove(end);
      back.remove(value - 1);
      front[st] = end;
      back[end] = st;
    } else if (front.containsKey(value + 1)) {
      int end = front[value + 1] ?? 0;
      front.remove(value + 1);
      back.remove(end);
      front[value] = end;
      back[end] = value;
    } else if (back.containsKey(value - 1)) {
      int st = back[value - 1] ?? 0;
      front.remove(st);
      back.remove(value - 1);
      front[st] = value;
      back[value] = st;
    } else {
      front[value] = value;
      back[value] = value;
    }
    set.add(value);
  }

  List<List<int>> getIntervalues() {
    int n = front.length;
    List<List<int>> ans =
        List.filled(n, 0).map((e) => List.filled(2, 0)).toList();
    int i = 0;
    for (MapEntry<int, int> e in front.entries) {
      int p = e.key;
      int q = e.value;
      ans[i][0] = p;
      ans[i][1] = q;
      i++;
    }
    return ans;
  }
}
