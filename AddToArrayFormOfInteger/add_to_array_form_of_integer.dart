/*





-* 989. Add to Array-Form of Integer *-


The array-form of an integer num is an array representing its digits in left to right order.

For example, for num = 1321, the array form is [1,3,2,1].
Given num, the array-form of an integer, and an integer k, return the array-form of the integer num + k.

 

Example 1:

Input: num = [1,2,0,0], k = 34
Output: [1,2,3,4]
Explanation: 1200 + 34 = 1234
Example 2:

Input: num = [2,7,4], k = 181
Output: [4,5,5]
Explanation: 274 + 181 = 455
Example 3:

Input: num = [2,1,5], k = 806
Output: [1,0,2,1]
Explanation: 215 + 806 = 1021
 

Constraints:

1 <= num.length <= 104
0 <= num[i] <= 9
num does not contain any leading zeros except for the zero itself.
1 <= k <= 104




*/

import 'dart:collection';

class A {
  List<int> addToArrayForm(List<int> num, int k) {
    Queue<int> res = Queue();
    int carry = 0;
    int i = 0;
    /*We always start computing from array's last element and k's last digit and will 
		compute sum and carry. We will iterate it till k and index of array both have existence. 
		If one of them gets exhausted the for loop below will not work.*/
    for (i = num.length - 1; i >= 0 && k > 0; i--) {
      int temp = num[i];
      res.addFirst((temp + carry + (k % 10)) % 10);
      carry = (temp + carry + (k % 10)) ~/ 10;
      k ~/= 10;
    }
    /*If for an instance your k is greater than the number that is present in the form of 
		array then the below while loop will work.*/
    while (k != 0) {
      int compute = (k % 10) + carry;
      res.addFirst(compute % 10);
      carry = compute ~/ 10;
      k ~/= 10;
    }
    /*If for an instance the number that is present in the form of array is greater than k 
		then the below for loop will work.*/
    for (int r = i; r >= 0; r--) {
      int temp = num[r];
      res.addFirst((temp + carry) % 10);
      carry = (temp + carry) ~/ 10;
    }
    /*If there is some carry still remaining at last then add it to beginning of the 
		array-list or Queue.*/
    if (carry != 0) res.addFirst(carry);
    return res.toList();
  }
}

class B {
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
