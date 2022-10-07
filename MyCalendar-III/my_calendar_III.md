# 🔥 My Calendar III 🔥 || 3 Solutions || Simple Fast and Easy || with Explanation

## Solution - 1

```dart
class MyCalendarThree {
//   Runtime: 1526 ms, faster than 100.00% of Dart online submissions for My Calendar III.
// Memory Usage: 174.4 MB, less than 100.00% of Dart online submissions for My Calendar III.
  late List<int> bookingStart;
  late List<int> bookingEnd;
  MyCalendarThree() {
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
```

## Solution - 2

```dart
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
```

## Solution - 3

```go
// Runtime: 45 ms, faster than 100.00% of Go online submissions for My Calendar III.
// Memory Usage: 7.2 MB, less than 100.00% of Go online submissions for My Calendar III.

type indexed = struct {
    idx int32
    val int32
}
type MyCalendarThree []indexed

func Constructor() MyCalendarThree {
    return MyCalendarThree{}
}

func appendSorted2(sli []indexed, former, later indexed) []indexed {
    var f = func(item indexed) func(int) bool {
        return func(i int) bool {
            if sli[i].idx == item.idx {
                return sli[i].val >= item.val
            }
            return sli[i].idx >= item.idx
        }
    }
    iF, iL := sort.Search(len(sli), f(former)), sort.Search(len(sli), f(later))
    if iF == len(sli) {
        return append(sli, former, later)
    }
    if iL == len(sli) {
        sli = append(sli, later, indexed{})
        copy(sli[iF+1:], sli[iF:])
        sli[iF] = former
        return sli
    }
    sli = append(sli, indexed{}, indexed{})
    copy(sli[iL+2:], sli[iL:])
    if iF != iL {
        copy(sli[iF+1:iL+1], sli[iF:iL])
    }
    sli[iF], sli[iL+1] = former, later
    return sli
}

func (c *MyCalendarThree) Book(start, end int) (max int) {
    *c = appendSorted2(*c, indexed{int32(start), 1}, indexed{int32(end), -1})
    var current int
    for _, v := range *c {
        current += int(v.val)
        if current > max {
            max = current
        }
    }
    return
}
```
