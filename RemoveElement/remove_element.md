# Remove Element

## Solution - 1

```dart
class A {
  int removeElement(List<int> nums, int val) {
    // index start from zero
    int index = 0;

    // looping on every element inside the list
    for (var i = 0; i < nums.length; i++) {
      // if the element is not same as value
      if (nums[i] != val) {
        // we increment thee value and assign it to the element of the list
        nums[index++] = nums[i];
        // index++;
      }
    }
    // we will return the index
    return index;
  }

/*
Runtime: 568 ms, faster than 5.41% of Dart online submissions for Remove Element.
Memory Usage: 142.3 MB, less than 86.49% of Dart online submissions for Remove Element.
*/
}
```

## Solution - 2

```dart
class B {
  int removeElement(List<int> nums, int val) {
    int a = 0;
    int b = 0;

    while (b < nums.length) {
      if (nums[a] == val) {
        if (nums[b] == val) {
          b += 1;
        } else {
          int temp = nums[a];
          nums[a] = nums[b];
          nums[b] = temp;
        }
      } else {
        a += 1;
        b += 1;
      }
    }
    return a;
  }

  // 113 / 113 test cases passed, but took too long.
}
```

## SOlution - 3

```dart
class C {
  int removeElement(List<int> nums, int val) {
    // index of the list
    int index = 0;
    // value of the list
    int value = 0;
    // loop to see if the lent is not less than zero
    while (value < nums.length) {
      // if the value is same as the val
      if (nums[value] == val) {
        // loop to see the the length is greater and value inside the list is same as val
        while (value < nums.length && nums[value] == val) {
          // we will increment value
          value++;
        }
      }
      // if the value is still less than list length
      if (value < nums.length) {
        // nums[index]- start from zero and will equal to the value of the list
        nums[index] = nums[value];
        // increment index
        index++;
        // increment value
        value++;
      }
    }
    // returning the index
    return index;
  }

/*
Runtime: 327 ms, faster than 94.59% of Dart online submissions for Remove Element.
Memory Usage: 157.8 MB, less than 5.41% of Dart online submissions for Remove Element.
*/
}
```
