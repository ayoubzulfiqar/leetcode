# 🔥 Reverse Integer 🔥 || Simple Fast and Easy || with Explanation


## Code

```go
func reverse(x int) int {

	var neg bool
	if x < 0 {
		neg = true
		x = x * -1
	}

	revX := getReversed(x)
	if neg == true {
		return revX * -1
	}
	return revX
}

func getReversed(x int) int {
	var rev, lastDigit int
	for x > 0 {
		lastDigit = x % 10
		x = x / 10
		rev = rev*10 + lastDigit
	}
	if rev > (math.MaxInt32) {
		return 0
	}
	return rev
}
```

1.  **`reverse(x int) int` Function:**
    * This function takes an integer `x` as input and returns the reversed integer.
    * It first checks if `x` is negative. If it is, it sets a boolean variable `neg` to `true` and converts `x` to its absolute value.
    * It then calls the `getReversed(x)` function to reverse the digits of the (now positive) `x`.
    * Finally, it checks the `neg` flag. If the original number was negative, it negates the reversed integer `revX` before returning it. Otherwise, it returns `revX` directly.

2.  **`getReversed(x int) int` Function:**
    * This function takes a positive integer `x` as input and returns its reversed value.
    * It initializes two integer variables: `rev` (to store the reversed integer) and `lastDigit`.
    * It uses a `for` loop to iterate through the digits of `x`.
    * Inside the loop:
        * `lastDigit` is extracted using the modulo operator (`% 10`).
        * `x` is divided by 10 (integer division) to remove the last digit.
        * `rev` is updated by multiplying it by 10 and adding `lastDigit`. This effectively shifts the existing digits of `rev` to the left and adds the new digit to the right.
    * It checks for integer overflow by comparing `rev` to `math.MaxInt32`. If `rev` exceeds this maximum value, it returns 0.
    * It returns the reversed integer `rev`.

**Time and Space Complexity**

**Time Complexity:**

* **`getReversed(x int)`:** The `for` loop iterates once for each digit in the input integer `x`. The number of digits in `x` is proportional to log<sub>10</sub>(n), where n is the absolute value of `x`. Therefore, the time complexity of `getReversed` is O(log<sub>10</sub>(n)).
* **`reverse(x int)`:** This function calls `getReversed` and performs constant-time operations. Thus, the time complexity of `reverse` is also O(log<sub>10</sub>(n)).

**Space Complexity:**

* **`getReversed(x int)`:** The function uses a constant amount of extra space for the variables `rev` and `lastDigit`. Therefore, the space complexity is O(1).
* **`reverse(x int)`:** This function uses a constant amount of extra space for the variable `neg` and the return value. Therefore, the space complexity is O(1).
* Overall, the space complexity of the code is O(1).

*
**Time Complexity:**

* O(log<sub>10</sub>(n)), where n is the absolute value of the input integer.

**Space Complexity:**

* O(1) (constant space).

