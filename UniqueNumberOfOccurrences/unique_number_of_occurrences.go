package main

/*

bool uniqueOccurrences(List<int> arr) {
    HashMap<int, int> map = HashMap();

    for (int i = 0; i < arr.length; i++) {
      int ele = arr[i];
      if (map.containsKey(ele)) {
        map[ele] = (map[ele] ?? 0) + 1;
      } else {
        map[ele] = 1;
      }
    }

    List<int> freq = List.filled(1000, 0); //Constraint given

    for (MapEntry<int, int> e in map.entries) {
      int n = e.value;
      if (freq[n] != 0) {
        return false;
      }
      freq[n]++;
    }

    return true;
  }

*/

func uniqueOccurrences(arr []int) bool {
	// hashmap to store our keys & values
	var hashMap = make(map[int]int)
	// looping through each and every element of the array
	for i := 0; i < len(arr); i++ {
		// individual element of the array
		var element int = arr[i]
		// if the hashmap have contain our key
		if _, key := hashMap[element]; key {
			// than we will assign the the value + 1
			hashMap[element] = hashMap[element] + 1
		} else {
			// else it's just 1
			hashMap[element] = 1
		}
	}
	// frequency array
	var frequency = make([]int, 1000)
	// _ use to skip key and than we will loop through the values of the map
	for _, value := range hashMap {
		// if the value is not zero
		if frequency[value] != 0 {
			// return false
			return false
		}
		// and we will walk to see next value ++ means walking
		frequency[value]++
	}
	// else return true
	return true
}
