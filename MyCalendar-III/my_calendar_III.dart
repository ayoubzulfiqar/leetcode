/*

 -* My Calendar III *-


A k-booking happens when k events have some non-empty intersection (i.e., there is some time that is common to all k events.)

You are given some events [start, end), after each given event, return an integer k representing the maximum k-booking between all the previous events.

Implement the MyCalendarThree class:

MyCalendarThree() Initializes the object.
int book(int start, int end) Returns an integer k representing the largest integer such that there exists a k-booking in the calendar.


Example 1:

Input
["MyCalendarThree", "book", "book", "book", "book", "book", "book"]
[[], [10, 20], [50, 60], [10, 40], [5, 15], [5, 10], [25, 55]]
Output
[null, 1, 1, 2, 3, 3, 3]

Explanation
MyCalendarThree myCalendarThree = new MyCalendarThree();
myCalendarThree.book(10, 20); // return 1, The first event can be booked and is disjoint, so the maximum k-booking is a 1-booking.
myCalendarThree.book(50, 60); // return 1, The second event can be booked and is disjoint, so the maximum k-booking is a 1-booking.
myCalendarThree.book(10, 40); // return 2, The third event [10, 40) intersects the first event, and the maximum k-booking is a 2-booking.
myCalendarThree.book(5, 15); // return 3, The remaining events cause the maximum K-booking to be only a 3-booking.
myCalendarThree.book(5, 10); // return 3
myCalendarThree.book(25, 55); // return 3


Constraints:

0 <= start < end <= 109
At most 400 calls will be made to book.

*/
import 'dart:math';

class A {
//   Runtime: 1526 ms, faster than 100.00% of Dart online submissions for My Calendar III.
// Memory Usage: 174.4 MB, less than 100.00% of Dart online submissions for My Calendar III.
  late List<int> bookingStart;
  late List<int> bookingEnd;
  A() {
    this.bookingStart = [];
    this.bookingEnd = [];
  }

  int book(int start, int end) {
    // we will start adding he value inside the list start to end
    bookingStart.add(start);
    bookingEnd.add(end);
    // than we will sort out all the booking to arrange them
    bookingStart.sort();
    bookingEnd.sort();
    // index of the booking
    int i = 0;
    // count the amount of bookings we got
    int count = 0;
    // length of the booking list
    int n = bookingStart.length;
    // represent the second value of the booking
    int j = 0;
    // holds the max integer value
    int result = 0;
    // assuming that the our index value is not less than the whole length means it's not empty
    while (i < n) {
      // while the booking start is greater than the at the point of booking ending
      while (bookingStart[i] >= bookingEnd[j]) {
        // we will increment the value
        j++;
        // while keep track of the booking
        count--;
      }
      i++;
      count++;
      // than we will get the max integer
      result = max(result, count);
    }
    return result;
  }
}

extension DefaultMap<K, V> on Map<K, V> {
  V getOrElse(K key, V defaultValue) {
    if (this.containsKey(key)) {
      return this[keys]!;
    } else {
      return defaultValue;
    }
  }
}

class MyCalendarThree {
// Runtime: 1635 ms, faster than 100.00% of Dart online submissions for My Calendar III.
// Memory Usage: 164.3 MB, less than 100.00% of Dart online submissions for My Calendar III.

  late List<int> starting;
  late List<int> ending;
  MyCalendarThree() {
    starting = [];
    ending = [];
  }

  int book(int start, int end) {
    starting.add(start);
    ending.add(end);
    starting.sort();
    ending.sort();

    int i = 0;
    int j = 0;
    int ans = 0;
    int temp = 0;
    while (i < starting.length && j < ending.length) {
      if (i < starting.length &&
          j < ending.length &&
          starting.elementAt(i) < ending.elementAt(j)) {
        temp++;
        i++;
        ans = max(temp, ans);
      } else {
        temp--;
        j++;
      }
    }
    return ans;
  }
}
