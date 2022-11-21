/*


-* 295. Find Median from Data Stream *-

The median is the middle value in an ordered integer list. If the size of the list is even, there is no middle value, and the median is the mean of the two middle values.

For example, for arr = [2,3,4], the median is 3.
For example, for arr = [2,3], the median is (2 + 3) / 2 = 2.5.
Implement the MedianFinder class:

MedianFinder() initializes the MedianFinder object.
void addNum(int num) adds the integer num from the data stream to the data structure.
double findMedian() returns the median of all elements so far. Answers within 10-5 of the actual answer will be accepted.


Example 1:

Input
["MedianFinder", "addNum", "addNum", "findMedian", "addNum", "findMedian"]
[[], [1], [2], [], [3], []]
Output
[null, null, null, 1.5, null, 2.0]

Explanation
MedianFinder medianFinder = new MedianFinder();
medianFinder.addNum(1);    // arr = [1]
medianFinder.addNum(2);    // arr = [1, 2]
medianFinder.findMedian(); // return 1.5 (i.e., (1 + 2) / 2)
medianFinder.addNum(3);    // arr[1, 2, 3]
medianFinder.findMedian(); // return 2.0


Constraints:

-105 <= num <= 105
There will be at least one element in the data structure before calling findMedian.
At most 5 * 104 calls will be made to addNum and findMedian.


Follow up:

If all integer numbers from the stream are in the range [0, 100], how would you optimize your solution?
If 99% of all integer numbers from the stream are in the range [0, 100], how would you optimize your solution?



*/

// class MedianFinder {
//   late List<int> list;
//   MedianFinder() {
//     this.list = [];
//   }

//   void addNum(int num) {
//     int i;
//     if (list.length > 0) {
//       for (i = 0; (i < list.length && list[i] < num); i++);
//       list.insert(i, num);
//     } else {
//       list.add(num);
//     }
//   }

//   double findMedian() {
//     int index = list.length ~/ 2;
//     if (list.length % 2 == 0) {
//       return (list[index] + list[index - 1]) / 2;
//     } else {
//       return list[index].toDouble();
//     }
//   }
// }

// class MedianFinder {
//   List<double> arr = [];
//   MedianFinder() {}

//   void addNum(int num) {
//     arr.add(num.toDouble());
//   }

//   double findMedian() {
//     // sort(arr.begin(),arr.end());
//     arr.sort();
//     int n = arr.length;
//     if (n % 2 == 0) {
//       double ans = (arr[(n ~/ 2) - 1] + arr[n ~/ 2]) / 2;
//       return ans;
//     }
//     return arr[n ~/ 2];
//   }
// }

import 'dart:collection';

// class MedianFinder {
//   Queue<int> maxHeap = Queue();
//   Queue<int> minHeap = Queue();
//   int n = 0;
//   MedianFinder() {}

//   void addNum(int num) {
//     if (n % 2 == 0) {
//       if (n == 0) {
//         insertInMaxHeap(num);
//       } else {
//         int topOfMinHeap = getMinHeapTop();
//         if (num >= topOfMinHeap) {
//           insertInMaxHeap(topOfMinHeap);
//           minHeap.removeLast();
//           insertInMinHeap(num);
//         } else {
//           insertInMaxHeap(num);
//         }
//       }
//     } else {
//       int topOfMaxHeap = getMaxHeapTop();
//       if (topOfMaxHeap < num) {
//         insertInMinHeap(num);
//       } else {
//         maxHeap.removeLast();
//         insertInMaxHeap(num);
//         insertInMinHeap(topOfMaxHeap);
//       }
//     }
//     n++;
//   }

//   double findMedian() {
//     if (n % 2 == 1) return maxHeap.first.toDouble();
//     return (getMaxHeapTop() + getMinHeapTop()) / 2;
//   }

//   void insertInMaxHeap(int val) {
//     maxHeap.add(val);
//   }

//   void insertInMinHeap(int val) {
//     minHeap.add(-val);
//   }

//   int getMinHeapTop() {
//     return -minHeap.first;
//   }

//   int getMaxHeapTop() {
//     return maxHeap.first;
//   }
// }

class MedianFinder {
  late Queue<int> smallWallet;
  late Queue<int> largeWallet;

  MedianFinder() {
    smallWallet = Queue<int>();
    largeWallet = Queue();
  }

  void addNum(int num) {
    smallWallet.add(num);
    if (!largeWallet.isEmpty && largeWallet.first < smallWallet.first)
      largeWallet.add(smallWallet.removeFirst());
    if ((smallWallet.length - largeWallet.length).abs() > 1) {
      if (largeWallet.length > smallWallet.length)
        smallWallet.add(largeWallet.removeFirst());
      else {
        largeWallet.add(smallWallet.removeFirst());
      }
    }
  }

  double findMedian() {
    if (largeWallet.length > smallWallet.length)
      return largeWallet.first * 1.0;
    else if (largeWallet.length < smallWallet.length) {
      return smallWallet.first * 1.0;
    } else {
      return (largeWallet.first + smallWallet.first) / 2.0;
    }
  }
}
