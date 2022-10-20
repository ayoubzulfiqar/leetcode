/*

-* Integer to Roman *-

Roman numerals are represented by seven different symbols: I, V, X, L, C, D and M.

Symbol       Value
I             1
V             5
X             10
L             50
C             100
D             500
M             1000
For example, 2 is written as II in Roman numeral, just two one's added together. 12 is written as XII, which is simply X + II. The number 27 is written as XXVII, which is XX + V + II.

Roman numerals are usually written largest to smallest from left to right. However, the numeral for four is not IIII. Instead, the number four is written as IV. Because the one is before the five we subtract it making four. The same principle applies to the number nine, which is written as IX. There are six instances where subtraction is used:

I can be placed before V (5) and X (10) to make 4 and 9.
X can be placed before L (50) and C (100) to make 40 and 90.
C can be placed before D (500) and M (1000) to make 400 and 900.
Given an integer, convert it to a roman numeral.



Example 1:

Input: num = 3
Output: "III"
Explanation: 3 is represented as 3 ones.
Example 2:

Input: num = 58
Output: "LVIII"
Explanation: L = 50, V = 5, III = 3.
Example 3:

Input: num = 1994
Output: "MCMXCIV"
Explanation: M = 1000, CM = 900, XC = 90 and IV = 4.


Constraints:

1 <= num <= 3999


*/

import 'dart:collection';

class A {
  String intToRoman(int num) {
    //first we create a table of roman word and their values..
    List<String> romanWord = [
      "I",
      "IV",
      "V",
      "IX",
      "X",
      "XL",
      "L",
      "XC",
      "C",
      "CD",
      "D",
      "CM",
      "M"
    ];
    List<int> value = [1, 4, 5, 9, 10, 40, 50, 90, 100, 400, 500, 900, 1000];
    //initialize and set the index i...
    int i = romanWord.length - 1;
    //create the solution which will be in string format...
    String sol = "";
    //a loop will be made to begin the procedure...
    while (num > 0) {
      //this loop is working untill the the vslue of integer is less or equal to num...
      while (value[i] <= num) {
        //Append the roman numeral into an solution string...
        sol += romanWord[i];
        //subtract the integral value from the given integer...
        //Subtract the current number until the given integer is greater than the current number.
        num -= value[i];
      }
      i--;
    }
    //Once we are done with all the roman numerals, we return the solution.
    return sol;
  }
}

class B {
  String intToRoman(int num) {
    List<int> number = [1000, 900, 500, 400, 100, 90, 50, 40, 10, 9, 5, 4, 1];
    List<String> roman = [
      "M",
      "CM",
      "D",
      "CD",
      "C",
      "XC",
      "L",
      "XL",
      "X",
      "IX",
      "V",
      "IV",
      "I"
    ];

    String res = "";

    for (int i = 0; i <= number.length - 1; i++) {
      if (num / number[i] >= 1) {
        res += roman[i] * (num ~/ number[i]);
        num = num - (num ~/ number[i]) * number[i];
      }
      if (num == 0) break;
    }
    return res;
  }
}

class C {
  String intToRoman(int num) {
    String romanNumeral = "";
    while (num >= 1000) {
      romanNumeral += "M";
      num -= 1000;
    }
    while (num >= 900) {
      romanNumeral += "CM";
      num -= 900;
    }
    while (num >= 500) {
      romanNumeral += "D";
      num -= 500;
    }
    while (num >= 400) {
      romanNumeral += "CD";
      num -= 400;
    }
    while (num >= 100) {
      romanNumeral += "C";
      num -= 100;
    }
    while (num >= 90) {
      romanNumeral += "XC";
      num -= 90;
    }
    while (num >= 50) {
      romanNumeral += "L";
      num -= 50;
    }
    while (num >= 40) {
      romanNumeral += "XL";
      num -= 40;
    }
    while (num >= 10) {
      romanNumeral += "X";
      num -= 10;
    }
    while (num >= 9) {
      romanNumeral += "IX";
      num -= 9;
    }
    while (num >= 5) {
      romanNumeral += "V";
      num -= 5;
    }
    while (num >= 4) {
      romanNumeral += "IV";
      num -= 4;
    }
    while (num >= 1) {
      romanNumeral += "I";
      num -= 1;
    }

    return romanNumeral;
  }
}

class D {
  String intToRoman(int num) {
    final StringBuffer sb = StringBuffer();
    final List<String> thousands = ["", "M", "MM", "MMM"];
    final List<String> hundreds = [
      "",
      "C",
      "CC",
      "CCC",
      "CD",
      "D",
      "DC",
      "DCC",
      "DCCC",
      "CM"
    ];
    final List<String> tens = [
      "",
      "X",
      "XX",
      "XXX",
      "XL",
      "L",
      "LX",
      "LXX",
      "LXXX",
      "XC"
    ];
    final List<String> ones = [
      "",
      "I",
      "II",
      "III",
      "IV",
      "V",
      "VI",
      "VII",
      "VIII",
      "IX"
    ];

    sb.write(thousands[num ~/ 1000]);
    sb.write(hundreds[(num % 1000) ~/ 100]);
    sb.write(tens[(num % 100) ~/ 10]);
    sb.write(ones[num % 10]);

    return sb.toString();
  }
}

class E {
  HashMap<int, String> up = HashMap();
  String intToRoman(int num) {
    up[5] = "V";
    up[10] = "X";
    up[50] = "L";
    up[100] = "C";
    up[500] = "D";
    up[1000] = "M";
    return comp(num);
  }

  String comp(int num) {
    if (num == 0) return "";
    if (num == 1) {
      return "I";
    }
    if (num == 2) return "II";
    if (num == 3) {
      return "III";
    }
    if (num == 4) {
      return "IV";
    }
    if (num == 9) {
      return "IX";
    }
    if (num >= 40 && num < 50) {
      return "XL" + comp(num - 40);
    }
    if (num >= 90 && num < 100) {
      return "XC" + comp(num - 90);
    }
    if (num >= 400 && num < 500) {
      return "CD" + comp(num - 400);
    }
    if (num >= 900 && num < 1000) {
      return "CM" + comp(num - 900);
    }

    List<int> arr = [5, 10, 50, 100, 500, 1000];
    int i = 0;
    for (; i <= 5; i++) {
      if (arr[i] > num) break;
    }

    int val = arr[i - 1];
    return up[val]! + comp(num - val);
  }
}
