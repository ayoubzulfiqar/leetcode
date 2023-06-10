/*

-* 412. Fizz Buzz *-

Given an integer n, return a string array answer (1-indexed) where:

answer[i] == "FizzBuzz" if i is divisible by 3 and 5.
answer[i] == "Fizz" if i is divisible by 3.
answer[i] == "Buzz" if i is divisible by 5.
answer[i] == i (as a string) if none of the above conditions are true.
 

Example 1:

Input: n = 3
Output: ["1","2","Fizz"]
Example 2:

Input: n = 5
Output: ["1","2","Fizz","4","Buzz"]
Example 3:

Input: n = 15
Output: ["1","2","Fizz","4","Buzz","Fizz","7","8","Fizz","Buzz","11","Fizz","13","14","FizzBuzz


*/

class A {
  List<String> fizzBuzz(int n) {
    List<String> answer = List.filled(n, "");
    for (int index = 0; index < n; index++) {
      if (index % 3 == 0 && index % 5 == 0) {
        answer.add("FizzBuzz");
      } else if (index % 3 == 0) {
        answer.add("Fizz");
      } else if (index % 5 == 0) {
        answer.add("Buzz");
      } else {
        answer.add(index.toString());
      }
    }
    return answer;
  }
}

class B {
  List<String> fizzBuzz(int n) {
    List<String> answer = [];
    for (int index = 1; index <= n; index++) {
      switch (index % 15) {
        case 0:
          answer.add("FizzBuzz");
          break;
        case 3:
        case 6:
        case 9:
        case 12:
          answer.add("Fizz");
          break;
        case 5:
        case 10:
          answer.add("Buzz");
          break;
        default:
          answer.add(index.toString());
          break;
      }
    }
    return answer;
  }
}
