# 🔥 2 Approaches 🔥 || Simple Fast and Easy || with Explanation

## Code -1

```dart
import 'dart:collection';

class Solution {
  List<int> addToArrayForm(List<int> num, int k) {
    Queue<int> res = Queue();
    int carry = 0;
    int i = 0;
    /*

    We always start computing from array's last element and k's last digit and will 
	compute sum and carry. We will iterate it till k and index of array both have existence. 
	If one of them gets exhausted the for loop below will not work.

    */
    for (i = num.length - 1; i >= 0 && k > 0; i--) {
      int temp = num[i];
      res.addFirst((temp + carry + (k % 10)) % 10);
      carry = (temp + carry + (k % 10)) ~/ 10;
      k ~/= 10;
    }
    /*

    If for an instance your k is greater than the number that is present in the form of 
	array then the below while loop will work.
    
    */
    while (k != 0) {
      int compute = (k % 10) + carry;
      res.addFirst(compute % 10);
      carry = compute ~/ 10;
      k ~/= 10;
    }
    /*

    If for an instance the number that is present in the form of array is greater than k 
	then the below for loop will work.
    
    */
    for (int r = i; r >= 0; r--) {
      int temp = num[r];
      res.addFirst((temp + carry) % 10);
      carry = (temp + carry) ~/ 10;
    }
    /*

    If there is some carry still remaining at last then add it to beginning of the 
	array-list or Queue.
    
    */
    if (carry != 0) res.addFirst(carry);
    return res.toList();
  }
}
```

## Intuition

We are taking k as carry.
We start from the last or lowest digit in array num add k.
Then update k and move until the highest digit.
After traversing array if carry is > 0 then we add it to beginning of num.

## Approach

Example: `num` = [2,1,5], `k` = 806
At index 2 num = [2, 1, 811]
So, `k` = 81 and `num` = [2, 1, 1]

At index 1 num = [2, 82, 1]
So, `k` = 8 and `num` = [2, 2, 1]

At index 0 num = [10, 2, 1]
So, `k` = 1 and `num` = [0, 2, 1]

Now `k` > 0
So, we add at the beginning of num
`num` = [1, 0, 2, 1]

## Complexity

### Time complexity: O(N)

### Space complexity: O(1)

## Code -2

```dart
class Solution {
  List<int> addToArrayForm(List<int> num, int k) {
    Queue<int> res = Queue();
    int len = num.length - 1;
    while (len >= 0 || k > 0) {
      if (len >= 0) {
        k += num[len--];
      }
      res.addFirst(k % 10);
      k ~/= 10;
    }
    return res.toList();
  }
}
```
