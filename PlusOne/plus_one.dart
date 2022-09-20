/*


 -* Plus One *-



You are given a large integer represented as an integer array digits, where each digits[i] is the ith digit of the integer.
The digits are ordered from most significant to least significant in left-to-right order.
The large integer does not contain any leading 0's.
Increment the large integer by one and return the resulting array of digits.



Example 1:

Input: digits = [1,2,3]
Output: [1,2,4]
Explanation: The array represents the integer 123.
Incrementing by one gives 123 + 1 = 124.
Thus, the result should be [1,2,4].


Example 2:

Input: digits = [4,3,2,1]
Output: [4,3,2,2]
Explanation: The array represents the integer 4321.
Incrementing by one gives 4321 + 1 = 4322.
Thus, the result should be [4,3,2,2].


Example 3:

Input: digits = [9]
Output: [1,0]
Explanation: The array represents the integer 9.
Incrementing by one gives 9 + 1 = 10.
Thus, the result should be [1,0].


Constraints:

1 <= digits.length <= 100
0 <= digits[i] <= 9
digits does not contain any leading 0's.

*/

void main() {
  final List<int> digits = [9];
  final a = D().plusOne(digits);
  print(a);
}

class A {
// Runtime: 449 ms, faster than 47.37% of Dart online submissions for Plus One.
// Memory Usage: 143.3 MB, less than 26.32% of Dart online submissions for Plus One.
  List<int> plusOne(List<int> digits) {
    int index = digits.length - 1;
    List<int> newItems = digits.toList();
    while (index >= 0) {
      if (digits[index] < 9) {
        newItems[index] = newItems[index] + 1;
        if (index < (digits.length - 1)) {
          newItems.replaceRange(index + 1, digits.length,
              List.generate(digits.length - index - 1, (_) => 0));
        }
        break;
      } else if (digits[index] == 9 && index == 0) {
        newItems.replaceRange(index, digits.length,
            List.generate(digits.length - index, (_) => 0));
        newItems.insert(0, 1);
        break;
      } else {
        index--;
      }
    }
    return newItems;
  }
}

class B {
// Runtime: 621 ms, faster than 5.26% of Dart online submissions for Plus One.
// Memory Usage: 142.1 MB, less than 81.58% of Dart online submissions for Plus One.
  List<int> plusOne(List<int> digits) {
    int size = digits.length - 1;

    if (digits[size] < 9) {
      digits[size]++;
      return digits;
    }

    for (int i = size; i >= 0; i--) {
      if (i == 0 && digits[0] == 9) {
        digits.removeAt(i);
        digits.insert(0, 1);
        digits.insert(1, 0);
        return digits;
      } else if (size >= 1 && digits[i - 1] < 9) {
        digits[i - 1]++;
        digits.removeAt(i);
        digits.insert(i, 0);
        return digits;
      } else {
        digits.removeAt(i);
        digits.insert(i, 0);
      }
    }
    return [];
  }
}

class C {
// Runtime: 510 ms, faster than 21.05% of Dart online submissions for Plus One.
// Memory Usage: 142.3 MB, less than 65.79% of Dart online submissions for Plus One.
  List<int> plusOne(List<int> digits) {
    int n = digits.length;
    int i = n - 1;
    while (i >= 0) {
      if (digits[i] + 1 == 10)
        digits[i] = 0;
      else {
        digits[i] = digits[i] + 1;
        return digits;
      }
      i--;
    }
    digits.insert(digits[0], 1);
    return digits;
  }
}

class D {
  List<int> plusOne(List<int> digits) {
    return (int.parse(digits.join('')) + 1)
        .toString()
        .split('')
        .map((e) => int.parse(e))
        .toList();
  }
}
