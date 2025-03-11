class Solution:
    def myAtoi(self, s: str) -> int:

        s = s.strip() 
        if not s:
            return 0

        sign = 1
        index = 0
        val = 0

        if s[0] == "-":
            sign = -1
            index += 1
        elif s[0] == "+":
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
