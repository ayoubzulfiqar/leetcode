/*


-* 1232. Check If It Is a Straight Line *-

You are given an array coordinates, coordinates[i] = [x, y], where [x, y] represents the coordinate of a point. Check if these points make a straight line in the XY plane.

 

 

Example 1:



Input: coordinates = [[1,2],[2,3],[3,4],[4,5],[5,6],[6,7]]
Output: true
Example 2:



Input: coordinates = [[1,1],[2,2],[3,4],[4,5],[5,6],[7,7]]
Output: false
 

Constraints:

2 <= coordinates.length <= 1000
coordinates[i].length == 2
-10^4 <= coordinates[i][0], coordinates[i][1] <= 10^4
coordinates contains no duplicate point.


*/

class A {
  bool checkStraightLine(List<List<int>> coordinates) {
    int dx = coordinates[1][1] - coordinates[0][1];
    int dy = coordinates[1][0] - coordinates[0][0];
    for (int i = 2; i < coordinates.length; i++) {
      if (dx * (coordinates[i][0] - coordinates[1][0]) !=
          dy * (coordinates[i][1] - coordinates[1][1])) {
        return false;
      }
    }
    return true;
  }
}

class B {
  bool checkStraightLine(List<List<int>> coordinates) {
    int x0 = coordinates[0][0];
    int y0 = coordinates[0][1];
    int x1 = coordinates[1][0];
    int y1 = coordinates[1][1];
    for (List<int> point in coordinates) {
      int x = point[0];
      int y = point[1];
      if ((x - x0) * (y1 - y0) != (y - y0) * (x1 - x0)) return false;
    }

    return true;
  }
}

class C {
  bool checkStraightLine(List<List<int>> coordinates) {
    late double slope;
    late double c;

    if (coordinates[1][0] == coordinates[0][0]) {
      slope = double.infinity;
      c = coordinates[0][1].toDouble() - slope * coordinates[0][0].toDouble();
      for (int i = 2; i < coordinates.length; i++) {
        if (coordinates[i][0] != coordinates[0][0]) {
          return false;
        }
      }
      return true;
    }

    slope = (coordinates[1][1] - coordinates[0][1]).toDouble() /
        (coordinates[1][0] - coordinates[0][0]).toDouble();
    c = coordinates[0][1].toDouble() - slope * coordinates[0][0].toDouble();

    for (int i = 2; i < coordinates.length; i++) {
      if (coordinates[i][1] - slope * coordinates[i][0] != c) {
        return false;
      }
    }

    return true;
  }
}
