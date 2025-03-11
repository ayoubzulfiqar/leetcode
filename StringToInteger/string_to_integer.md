
# 🔥 String To Integer (Atoi) 🔥|| Simple Fast and Easy || with Explanation

Converts a string to an integer, mimicking the behavior of the C `atoi` function.

**Explanation:**

1.  **Whitespace Removal:**
    * The input string `s` is stripped of leading and trailing whitespace using `s.strip()`.
2.  **Empty String Check:**
    * If the stripped string is empty, the function returns 0.
3.  **Sign Determination:**
    * The code checks the first character of the string for a sign (`'+'` or `'-'`).
    * If a `'-'` is found, the `sign` variable is set to -1; otherwise, it defaults to 1.
    * The `index` is incremented to move past the sign character.
4.  **Digit Extraction and Conversion:**
    * The code iterates through the remaining characters of the string as long as they are digits.
    * For each digit, it converts the character to its integer equivalent using `int(s[index])` and adds it to the `val` variable.
    * The `val` variable is multiplied by 10 in each iteration to construct the integer.
5.  **Overflow Handling:**
    * During the integer construction, the code checks if `val` exceeds the 32-bit signed integer range (`[-2147483648, 2147483647]`).
    * If an overflow occurs:
        * If the `sign` is positive, it returns `2147483647`.
        * If the `sign` is negative, it returns `-2147483648`.
6.  **Return Value:**
    * Finally, the function returns the calculated integer value (`sign * val`).

## **Code:**

```python
class Solution:
    def myAtoi(self, s: str) -> int:
        s = s.strip()
        if not s:
            return 0

        sign = 1
        index = 0
        val = 0

        if s[0] == '-':
            sign = -1
            index += 1
        elif s[0] == '+':
            index += 1

        while index < len(s) and s[index].isdigit():
            val = val * 10 + int(s[index])
            if val > 2147483647 or val < -2147483648:
                if sign == 1:
                    return 2147483647
                else:
                    return -2147483648
            index += 1

        return sign * val
```


## **Code - Golang**

```go
func myAtoi(s string) int {
	if len(s) == 0 {
		return 0
	}

	sign := 1 // -1 negative
	index := 0
	val := 0

	for len(s) > index && s[index] == ' ' {
		index++
	}

	if index >= len(s) {
		return 0
	}

	if v := s[index]; v == '-' || v == '+' {
		if v == '-' {
			sign = -1
		}

		index++
	}

	for {
		if index == len(s) {
			break
		}

		if isNumericRune(s[index]) == false {
			return sign * val
		}

		val = val*10 + int(s[index]) - '0'

		if val > 2147483647 || val < -2147483648 {
			if sign == 1 {
				return 2147483647
			}

			return -2147483648
		}

		index++
	}

	return sign * val
}

func isNumericRune(x byte) bool {
	return x >= '0' && x <= '9'
}

```


## Space and Time Complexity

**Time Complexity:**

* **O(n)**, where `n` is the length of the input string `s`.
    * The `strip()` operation takes O(n) time in the worst case.
    * The `while` loop iterates through the string at most once.

**Space Complexity:**

* **O(1)** (constant).
    * The code uses a fixed number of variables (`sign`, `index`, `val`), regardless of the input string's size.
    * The `strip()` operation in python generally returns a new string, but in the case of no leading or trailing white space, it will return the same string. Therefore the space complexity remains constant.