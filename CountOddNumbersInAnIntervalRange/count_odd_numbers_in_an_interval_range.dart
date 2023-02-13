/*


-* 1523. Count Odd Numbers in an Interval Range *-

Given two non-negative integers low and high. Return the count of odd numbers between low and high (inclusive).

 

Example 1:

Input: low = 3, high = 7
Output: 3
Explanation: The odd numbers between 3 and 7 are [3,5,7].
Example 2:

Input: low = 8, high = 10
Output: 1
Explanation: The odd numbers between 8 and 10 are [9].
 

Constraints:

0 <= low <= high <= 10^9


*/

class A {
  int countOdds(int high, int low) {
    return ((high + 1) ~/ 2) - (low ~/ 2);
  }
}

class B {
  int countOdds(int high, int low) {
    if ((high & 1) == 0) high--;
    return (low > high) ? 0 : (high + 1) ~/ 2 - (low ~/ 2);
  }
}

class C {
  int countOdds(int high, int low) {
    int total = high - low + 1;
    if (total % 2 == 0)
      return total ~/ 2;
    else {
      if (low % 2 != 0)
        return total ~/ 2 + 1;
      else
        return total ~/ 2;
    }
  }
}

class D {
  int countOdds(int low, int high) {
    if (low % 2 == 0 && high % 2 == 0)
      return (high - low) ~/ 2;
    else {
      int firstOddNumber = low % 2 == 0 ? low + 1 : low;
      return (high - firstOddNumber) ~/ 2 + 1;
    }
  }
}

class F {
  int countOdds(int high, int low) {
    int count = 0;
    for (int i = low; i <= high; i++) {
      if (i % 2 != 0) count++;
    }
    return count;
  }
}

class G {
  int countOdds(int low, int high) {
    int result = 0;
    if ((low & 1) == 0) {
      result++;
      low++;
    }
    if ((high & 1) == 0) {
      result++;
      high--;
    }
    result += (high - low) ~/ 2;

    return result;
  }
}

class H {
  int countOdds(int low, int high) {
    if (low % 2 == 0 && high % 2 == 0) {
      return (high - low) ~/ 2;
    } else if (low % 2 != 0 && high % 2 != 0) {
      return 2 + (high - low) ~/ 2 - 1;
    } else {
      return 1 + (high - low) ~/ 2;
    }
  }
}
