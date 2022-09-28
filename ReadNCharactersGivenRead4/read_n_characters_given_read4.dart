/*


Given a file and assume that you can only read the file using a given method read4, implement a method to read n characters.
Method read4:
The API read4 reads four consecutive characters from file, then writes those characters into the buffer array buf4.
The return value is the number of actual characters read.
Note that read4() has its own file pointer, much like FILE *fp in C.
Definition of read4:
    Parameter:  char[] buf4
    Returns:    int

buf4[] is a destination, not a source. The results from read4 will be copied to buf4[].
Below is a high-level example of how read4 works:
File file("abcde"); // File is "abcde", initially file pointer (fp) points to 'a'
char[] buf4 = new char[4]; // Create buffer with enough space to store characters
read4(buf4); // read4 returns 4. Now buf4 = "abcd", fp points to 'e'
read4(buf4); // read4 returns 1. Now buf4 = "e", fp points to end of file
read4(buf4); // read4 returns 0. Now buf4 = "", fp points to end of file
Method read:
By using the read4 method, implement the method read that reads n characters from file and store it in the buffer array buf. Consider that you cannot manipulate file directly.
The return value is the number of actual characters read.
Definition of read:
    Parameters:	char[] buf, int n
    Returns:	int

buf[] is a destination, not a source. You will need to write the results to buf[].
Note:
Consider that you cannot manipulate the file directly. The file is only accessible for read4 but not for read.
The read function will only be called once for each test case.
You may assume the destination buffer array, buf, is guaranteed to have enough space for storing ncharacters.
Example 1:
Input: file = "abc", n = 4
Output: 3
Explanation: After calling your read method, buf should contain "abc". We read a total of 3 characters from the file, so return 3.
Note that "abc" is the file's content, not buf. buf is the destination buffer that you will have to write the results to.
Example 2:
Input: file = "abcde", n = 5
Output: 5
Explanation: After calling your read method, buf should contain "abcde". We read a total of 5 characters from the file, so return 5.
Example 3:
Input: file = "abcdABCD1234", n = 12
Output: 12
Explanation: After calling your read method, buf should contain "abcdABCD1234". We read a total of 12 characters from the file, so return 12.
Example 4:
Input: file = "leetcode", n = 5
Output: 5
Explanation: After calling your read method, buf should contain "leetc". We read a total of 5 characters from the file, so return 5.
Constraints:
1 <= file.length <= 500
file consist of English letters and digits.
1 <= n <= 1000

*/

/*


APPROACH 1


As we know, we have to implement the ‘READ’ method using the ‘READ4’ method.

So first, we call the ‘READ4’ method and pass a ‘TEMP_BUFFER’ array/list of 4 sizes.
And this method returns the number of characters reads from the ‘FILE’ and all these characters are
stored in this ‘TEMP_BUFFER’ array/list. When we read the ‘N’ characters from the ‘FILE’ we return the number of actual
characters that are read from ‘FILE’.




As we know, the ‘READ’ method is called any number of times. So we have to store the remaining
characters of the ‘TEMP_BUFFER’ array/list also. So that's why we declare this ‘TEMP_BUFFER’
array/list as a global variable.



Here is the algorithm:



We declare an array/list ‘TEMP_BUFFER’ of size 4 in which we store the current 4 characters of the ‘FILE’.
We declare two variables ‘TEMP_POINTER’ and ‘TEMP_COUNT’ where ‘TEMP_POINTER’ points to the location of the
current character in ‘TEMP_BUFFER’ and  ‘TEMP_COUNT’ stores how many characters are present in ‘TEMP_BUFFER’.
We declare a variable ‘COUNTER’ which represents the number of characters read from the ‘FILE’.
We run a loop while ‘COUNTER’ less than ‘N’:
If ‘TEMP_POINTER’ == 0:
‘TEMP_COUNT’ = ‘READ4[‘TEMP_BUFFER’].
If ‘TEMP_COUNT’ == 0:
Break.
We run a loop while ‘COUNTER’ less than ‘N’ and ‘TEMP_POINTER’ less than ‘TEMP_COUNT’:
BUFFER[POINTER] =  ‘TEMP_BUFFER[‘TEMP_POINTER’]’
POINTER.
‘TEMP_POINTER’.
If ‘TEMP_POINTER’ equal to ‘TEMP_COUNT’:
‘TEMP_POINTER’ = 0.
Return ‘COUNTER’.


*/

abstract class Reader4 {
  int read4(List<int> buf4);
}

class Solution extends Reader4 {
  int read(List<int> buf, int n) {
    List<int> buf4 = [4];
    int i4 = 0; // buf4's index
    int n4 = 0; // buf4's size
    int i = 0; // buf's index
    while (i < n) {
      if (i4 == n4) {
        // all characters in buf4 are consumed
        i4 = 0; // reset buf4's index
        n4 = read4(buf4); // read 4 (or less) chars from file to buf4
        if (n4 == 0) // reach the EOF
          return i;
      }
      buf[i++] = buf4[i4++];
    }

    return i;
  }

  @override
  int read4(List<int> buf4) {
    throw UnimplementedError();
  }
}

class Solution2 extends Reader4 {
  int read(List<int> buf, int n) {
    int copyCharIndex = 0;
    int charRead = 4;
    List<int> buf4 = List.filled(4, 0);
    while (copyCharIndex < n && charRead == 4) {
      charRead = read4(buf4);
      for (var i = 0; i < charRead; i++) {
        if (copyCharIndex == n) {
          return n;
        }
        buf[copyCharIndex++] = buf4[i];
      }
    }
    return copyCharIndex;
  }

  @override
  int read4(List<int> buf4) {
    throw UnimplementedError();
  }
}
