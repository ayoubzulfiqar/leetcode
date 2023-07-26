/*



-* 1870. Minimum Speed to Arrive on Time *-




You are given a floating-point number hour, representing the amount of time you have to reach the office. To commute to the office, you must take n trains in sequential order. You are also given an integer array dist of length n, where dist[i] describes the distance (in kilometers) of the ith train ride.

Each train can only depart at an integer hour, so you may need to wait in between each train ride.

For example, if the 1st train ride takes 1.5 hours, you must wait for an additional 0.5 hours before you can depart on the 2nd train ride at the 2 hour mark.
Return the minimum positive integer speed (in kilometers per hour) that all the trains must travel at for you to reach the office on time, or -1 if it is impossible to be on time.

Tests are generated such that the answer will not exceed 107 and hour will have at most two digits after the decimal point.

 

Example 1:

Input: dist = [1,3,2], hour = 6
Output: 1
Explanation: At speed 1:
- The first train ride takes 1/1 = 1 hour.
- Since we are already at an integer hour, we depart immediately at the 1 hour mark. The second train takes 3/1 = 3 hours.
- Since we are already at an integer hour, we depart immediately at the 4 hour mark. The third train takes 2/1 = 2 hours.
- You will arrive at exactly the 6 hour mark.
Example 2:

Input: dist = [1,3,2], hour = 2.7
Output: 3
Explanation: At speed 3:
- The first train ride takes 1/3 = 0.33333 hours.
- Since we are not at an integer hour, we wait until the 1 hour mark to depart. The second train ride takes 3/3 = 1 hour.
- Since we are already at an integer hour, we depart immediately at the 2 hour mark. The third train takes 2/3 = 0.66667 hours.
- You will arrive at the 2.66667 hour mark.
Example 3:

Input: dist = [1,3,2], hour = 1.9
Output: -1
Explanation: It is impossible because the earliest the third train can depart is at the 2 hour mark.
 

Constraints:

n == dist.length
1 <= n <= 105
1 <= dist[i] <= 105
1 <= hour <= 109
There will be at most two digits after the decimal point in hour.



*/

class A {
  bool isPossible(List<int> dist, int speed, double hour) {
    double ans = 0;
    for (int i = 0; i < dist.length; i++) {
      double d = dist[i] / speed;
      if (i != dist.length - 1) {
        ans += d.ceilToDouble();
      } else {
        ans += d;
      }
      if (ans > hour) {
        return false;
      }
    }
    return ans <= hour;
  }

  int minSpeedOnTime(List<int> dist, double hour) {
    int i = 1;
    int j = 10000000; // Approximate value for 1e7 in Dart
    int minSpeed = -1; // Initialize minSpeed to -1
    while (i <= j) {
      int mid = i + ((j - i) ~/ 2);
      if (isPossible(dist, mid, hour)) {
        minSpeed = mid;
        j = mid - 1;
      } else {
        i = mid + 1;
      }
    }
    return minSpeed;
  }
}

class B {
  int minSpeedOnTime(List<int> dist, double hour) {
    int n = dist.length;
    if (hour <= n - 1) return -1;
    int l = 1, r = 10000000; // This is equivalent to 1e7 in C++

    while (l < r) {
      int mid = l + ((r - l) ~/ 2);
      double time = 0.0; // Initialize time as a double

      for (int i = 0; i < n - 1; i++) {
        time += (dist[i] / mid).ceilToDouble();
      }

      time += dist[n - 1] / mid;

      if (time <= hour) {
        r = mid;
      } else {
        l = mid + 1;
      }
    }

    return l;
  }
}

class Solution {
  int ceil(double x, double y) {
    return ((x + y - 1) / y).ceil();
  }

  int minSpeedOnTime(List<int> a, double k) {
    int n = a.length;
    int l = 0, r = 1000000000, m;

    bool can(int s) {
      double t = 0;
      for (int i = 0; i + 1 < n; i++) {
        t += ceil(a[i].toDouble(),
            s.toDouble()); // add time of each train with current speed
      }
      t += a[n - 1] / s; // last train

      return t <= k;
    }

    while (l + 1 < r) {
      m = (l + r) ~/ 2;
      if (can(m)) {
        // if possible, update bounds
        r = m;
      } else {
        l = m;
      }
    }

    return r == 1000000000 ? -1 : r;
  }
}

class D {
  int minSpeedOnTime(List<int> a, double k) {
    int n = a.length;
    int l = 0, r = 10000000; // Equivalent to Go's 1e7
    int m;

    bool can(int s) {
      double t = 0.0;
      for (int i = 0; i + 1 < n; i++) {
        t += (a[i] / s).ceilToDouble();
      }
      t += a[n - 1] / s; // last train

      return t <= k;
    }

    while (l + 1 < r) {
      m = (l + r) ~/ 2;
      if (can(m)) {
        // if possible, update bounds
        r = m;
      } else {
        l = m;
      }
    }

    if (can(r)) {
      return r;
    }
    return -1;
  }
}

/*

n := len(dist)
	if hour <= float64(n-1) {
		return -1
	}
	l, r := 1, int(1e7)
	for l < r {
		mid := l + (r-l)/2
		time := 0.0
		for i := 0; i < n-1; i++ {
			time += math.Ceil(float64(dist[i]) / float64(mid))
		}
		time += float64(dist[n-1]) / float64(mid)

		if time <= hour {
			r = mid
		} else {
			l = mid + 1
		}
	}
	return l
*/

class G {
  int minSpeedOnTime(List<int> dist, double hour) {
    int left = 1;
    int right = 10000007; // The constraint mentioned in the problem

    while (left < right) {
      int mid = left + ((right - left) ~/ 2);
      int totalHours = 0;

      for (int i = 0; i < dist.length - 1; i++) {
        totalHours += (dist[i] ~/ mid);
      }

      totalHours += (dist[dist.length - 1] ~/ mid);

      if (totalHours <= hour) {
        right = mid;
      } else {
        left = mid + 1;
      }
    }

    // Check if the result is valid or not
    double finalHours = 0;
    for (int i = 0; i < dist.length - 1; i++) {
      finalHours += (dist[i] ~/ left);
    }
    finalHours += (dist[dist.length - 1] / left);

    return finalHours <= hour ? left : -1;
  }
}

extension IntExtensions on int {
  int ceilDiv(int y) {
    int div = this ~/ y;
    int rem = this % y;
    if (rem > 0) {
      div++;
    }
    return div;
  }
}

void main() {
  final g = G();
  print(g.minSpeedOnTime([1, 3, 2], 1.9));
}
