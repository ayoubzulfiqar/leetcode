
# 🔥 Greedy O(1) 100% Fast 🔥 || Simple Fast and Easy || with Explanation 😈

## **Intuition and Approach**

The function `bestClosingTime` takes a string `customers` as input, where each character represents a customer who either says 'Y' (yes) or 'N' (no) to a closing time offer. The goal of the code is to determine the best time to close the shop such that the penalty is minimized. The penalty is defined as the sum of the number of customers who said 'Yes' and the number of customers who said 'No' up to a certain closing time.

The algorithm iterates through the `customers` string twice. In the first pass, it counts the total number of 'Y' (yes) customers. This gives the initial value for the penalty.

In the second pass, it simulates the shop's closing time by iteratively updating the counts of 'Y' (yes) and 'N' (no) customers. For each iteration, it calculates the current penalty, which is the sum of the remaining 'Y' customers and the accumulated 'N' customers. If the current penalty is smaller than the previously recorded penalty, it updates the answer (`ans`) to the current iteration and updates the minimum penalty (`pen`).

By the end of the second pass, the function returns the answer, which represents the best time to close the shop to minimize the penalty.

## **Space Complexity**

The code uses a constant amount of extra space for variables like `yes`, `no`, `ans`, `pen`, and `currentPen`. Therefore, the space complexity is O(1), i.e., constant.

## **Time Complexity**

The code iterates through the `customers` string twice. In the worst case, both iterations will take O(n) time, where n is the length of the input string. Thus, the time complexity is O(n).

## Code

```dart
class Solution {
  int bestClosingTime(String customers) {
    int yes = 0;
    final int n = customers.length;
    for (int i = 0; i < n; i++) {
      if (customers[i] == 'Y') yes++;
    }
    int ans = 0;
    int pen = yes;
    int no = 0;
    for (int i = 0; i < n; i++) {
      if (customers[i] == 'N') {
        no++;
      } else
        yes--;
      int currentPen = yes + no;
      if (currentPen < pen) {
        ans = i + 1;
        pen = currentPen;
      }
    }
    return ans;
  }
}
```

## [GitHub](https://github.com/ayoubzulfiqar/leetcode)
