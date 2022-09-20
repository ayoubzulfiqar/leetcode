# Remove Duplicates from Sorted Array

## Solution - 1

```dart
// BRUTE FORCE Solution
class A {
  int removeDuplicates(List<int> nums) {
    // keep track of the value
    int c = 1;
    // looping through every digit inside list
    for (int i = 1; i < nums.length; i++) {
      // if the digit is not equal to the index value of the list
      // remember :- digit start from 1 and index start from 0
      // so nums[i - 1] is to get the index
      if (nums[i] != nums[i - 1]) {
        // than the value will be  equal to the value of inside
        nums[c] = nums[i];
        // increment the value
        c++;
      }
    }
    return c;
  }

/*
Runtime: 456 ms, faster than 65.63% of Dart online submissions for Remove Duplicates from Sorted Array.
Memory Usage: 144.2 MB, less than 75.00% of Dart online submissions for Remove Duplicates from Sorted Array.
*/
}
```

## Solution - 2

```dart
class B {
  int removeDuplicates(List<int> nums) {
    // if the list is empty than we returning the zero
    if (nums.length == 0) return 0;
    int first = 0;
    int last = 0;
    while (last < nums.length) {
      if (nums[first] != nums[last]) {
        // first = first + 1;
        first += 1;
        nums[first] = nums[last];
      }
      // last = last + 1;
      last += 1;
    }

    // first = first + 1;
    return first += 1;
  }
/*
Runtime: 389 ms, faster than 93.75% of Dart online submissions for Remove Duplicates from Sorted Array.
Memory Usage: 143.9 MB, less than 84.38% of Dart online submissions for Remove Duplicates from Sorted Array.
*/
}
```

## Solution - 3

```dart
class C {
  int removeDuplicates(List<int> nums) {
    // i = indexValue :- index always start from zero
    int i = 0;
    // j = digitValue inside list
    int j = i + 1;

    // loop to check if the digitValue is shorter than length
    while (j < nums.length) {
      // if they both are not same
      if (nums[i] != nums[j]) {
        // we increment the index value
        i++;
        // than the index will be same as the digitValue
        nums[i] = nums[j];
      }

      j++;
    }
    return ++i;
  }

/*
Runtime: 491 ms, faster than 56.25% of Dart online submissions for Remove Duplicates from Sorted Array.
Memory Usage: 143 MB, less than 100.00% of Dart online submissions for Remove Duplicates from Sorted Array.
*/
}
```
