/*


-* 1615. Maximal Network Rank *-

There is an infrastructure of n cities with some number of roads connecting these cities. Each roads[i] = [ai, bi] indicates that there is a bidirectional road between cities ai and bi.

The network rank of two different cities is defined as the total number of directly connected roads to either city. If a road is directly connected to both cities, it is only counted once.

The maximal network rank of the infrastructure is the maximum network rank of all pairs of different cities.

Given the integer n and the array roads, return the maximal network rank of the entire infrastructure.

 

Example 1:



Input: n = 4, roads = [[0,1],[0,3],[1,2],[1,3]]
Output: 4
Explanation: The network rank of cities 0 and 1 is 4 as there are 4 roads that are connected to either 0 or 1. The road between 0 and 1 is only counted once.
Example 2:



Input: n = 5, roads = [[0,1],[0,3],[1,2],[1,3],[2,3],[2,4]]
Output: 5
Explanation: There are 5 roads that are connected to cities 1 or 2.
Example 3:

Input: n = 8, roads = [[0,1],[1,2],[2,3],[2,4],[5,6],[5,7]]
Output: 5
Explanation: The network rank of 2 and 5 is 5. Notice that all the cities do not have to be connected.
 

Constraints:

2 <= n <= 100
0 <= roads.length <= n * (n - 1) / 2
roads[i].length == 2
0 <= ai, bi <= n-1
ai != bi
Each pair of cities has at most one road connecting them.



*/

class A {
  int maximalNetworkRank(int n, List<List<int>> roads) {
    return 0;
  }
}

class Solution {
  int maximalNetworkRank(int n, List<List<int>> roads) {
    final List<int> degrees = List<int>.filled(n, 0);
    for (List<int> road in roads) {
      final int a = road[0];
      final int b = road[1];
      degrees[a]++;
      degrees[b]++;
    }

    int maxDegree = 0;
    int secondMaxDegree = 0;
    for (int degree in degrees) {
      if (degree < secondMaxDegree) {
        continue;
      }
      secondMaxDegree = degree;
      if (secondMaxDegree > maxDegree) {
        int temp = secondMaxDegree;
        secondMaxDegree = maxDegree;
        maxDegree = temp;
      }
    }

    final List<bool> isCandidate = List<bool>.filled(n, false);
    int candidateCount = 0;
    int king = -1;
    for (int i = 0; i < n; i++) {
      if (degrees[i] == secondMaxDegree) {
        isCandidate[i] = true;
        candidateCount++;
      }
      if (maxDegree > secondMaxDegree && degrees[i] == maxDegree) {
        king = i;
      }
    }

    if (maxDegree == secondMaxDegree) {
      // Case 1: We have multiple candidates with the same max degrees.
      if (candidateCount > maxDegree + 1) {
        return maxDegree * 2;
      }
      int connectionCount = 0;
      for (List<int> road in roads) {
        final int a = road[0];
        final int b = road[1];
        if (isCandidate[a] && isCandidate[b]) {
          connectionCount++;
        }
      }
      if (connectionCount < candidateCount * (candidateCount - 1) ~/ 2) {
        return maxDegree * 2;
      }
      return maxDegree * 2 - 1;
    }

    // Case 2: We have a single max degree (king) and multiple second max degree candidates.
    int connectionCount = 0;
    for (List<int> road in roads) {
      final int a = road[0];
      final int b = road[1];
      if (a != king && b != king) {
        continue;
      }
      if (isCandidate[a] || isCandidate[b]) {
        connectionCount++;
      }
    }
    if (connectionCount < candidateCount) {
      return maxDegree + secondMaxDegree;
    }
    return maxDegree + secondMaxDegree - 1;
  }
}
