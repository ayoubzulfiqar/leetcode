package main

/*
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


*/

func bestClosingTime(customers string) int {
	var yes int = 0
	var n int = len(customers)
	for i := 0; i < n; i++ {
		if customers[i] == 'Y' {
			yes++
		}
	}
	var ans int = 0
	var pen int = yes
	var no int = 0
	for i := 0; i < n; i++ {
		if customers[i] == 'N' {
			no++
		} else {
			yes--
		}
		var currentPen int = yes + no
		if currentPen < pen {
			ans = i + 1
			pen = currentPen
		}
	}

	return ans
}
