class Solution:
    def reverse(self, x: int) -> int:
        neg = False
        if x < 0:
            neg = True
            x = abs(x)

        revX = getReversed(x)

        if neg:
            return -revX
        return revX

def getReversed(x: int) -> int:
        rev = 0
        while x > 0:
            lastDigit = x % 10
            x //= 10
            rev = rev * 10 + lastDigit

        if rev > 2**31 - 1:  
            return 0
        return rev
