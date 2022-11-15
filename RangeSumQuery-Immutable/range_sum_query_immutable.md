# 🔥 Range Sum Query - Immutable 🔥 || 3 Solutions || Simple Fast and Easy || with Explanation

## Solution - 1

```dart
class NumArray {
  late List<int> prefixSum;

  NumArray(List<int> nums) {
    if (nums == 0) {
      throw ArgumentError("Panic: Input is Empty");
    }

    this.prefixSum = List.filled(nums.length + 1, 0);

    for (int i = 1; i <= nums.length; i++) {
      prefixSum[i] = prefixSum[i - 1] + nums[i - 1];
    }
  }

  int sumRange(int left, int right) {
    if (left < 0 || right >= prefixSum.length - 1) {
      throw RangeError("Panic: Input indices are out of bounds");
    }

    // Here both left and right are inclusive.
    // right maps to right+1 in prefixSum. left maps to left+1 in prefixSum.
    // To get the result subtract the prefixSum before left index from prefixSum at
    // right index.
    return prefixSum[right + 1] - prefixSum[left];
  }
}
```

## Solution - 2

```dart
class NumArray {
  late List<int> nums;
  late List<int> prefixSum;
  NumArray(List<int> nums) {
    this.nums = nums;
    this.prefixSum = getPrefixSum();
  }

  int sumRange(int left, int right) {
    if (left == 0) return prefixSum[right];
    return prefixSum[right] - prefixSum[left - 1];
  }

  List<int> getPrefixSum() {
    int sum = 0;
    List<int> ans = List.filled(nums.length, 0);

    for (int i = 0; i < nums.length; i++) {
      sum += nums[i];
      ans[i] = sum;
    }

    return ans;
  }
}
```

## Solution - 3

```dart

class NumArray {
  List<int> arr = [];
  NumArray(List<int> nums) {
    this.arr = nums;
  }

  int sumRange(int left, int right) {
    int sum = 0;
    for (int i = left; i <= right; i++) sum += this.arr[i];
    return sum;
  }
}
```
