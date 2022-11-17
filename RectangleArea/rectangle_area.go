package main

/*

 int computeArea(
      int ax1, int ay1, int ax2, int ay2, int bx1, int by1, int bx2, int by2) {
    int a = (ax2 - ax1) * (ay2 - ay1);
    int b = (bx2 - bx1) * (by2 - by1);

    if (ax1 >= bx2 || ax2 <= bx1 || ay2 <= by1 || ay1 >= by2) return a + b;

    return (a +
            b -
            (min(bx2, ax2) - max(ax1, bx1)) * (min(ay2, by2) - max(ay1, by1)))
        .toInt();
  }

*/

func computeArea(ax1 int, ay1 int, ax2 int, ay2 int, bx1 int, by1 int, bx2 int, by2 int) int {
	var a int = (ax2 - ax1) * (ay2 - ay1)
	var b int = (bx2 - bx1) * (by2 - by1)
	if ax1 >= bx2 || ax2 <= bx1 || ay2 <= by1 || ay1 >= by2 {
		return a + b
	}

	return a +
		b -
		(min(bx2, ax2)-max(ax1, bx1))*(min(ay2, by2)-max(ay1, by1))
}

func min(a, b int) int {
	if a < b {
		return a
	}
	return b
}

func max(a, b int) int {
	if a > b {
		return a
	}
	return b
}
