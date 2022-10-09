package main

/*

 bool isAnagram(String s, String t) {
    if (s.length != t.length) return false;
    final Map<String, int> mapOne = {};
    final Map<String, int> mapTwo = {};

    for (int i = 0; i < s.length; i++) {
      mapOne[s[i]] = (mapOne[s[i]] ?? 0) + 1;
      mapTwo[t[i]] = (mapTwo[t[i]] ?? 0) + 1;
    }
    final mapOneKeys = mapOne.keys.toList();
    final mapOneValues = mapOne.values.toList();

    for (int i = 0; i < mapOne.length; i++) {
      final key = mapOneKeys[i];
      final value = mapOneValues[i];

      if (mapTwo[key] != value) return false;
    }
    return true;
  }

*/
func isAnagram(s string, t string) bool {
	sr := map[byte]int{}
	tr := map[byte]int{}

	if len(s) != len(t) {
		return false
	}

	for i := 0; i < len(s); i++ {
		sr[s[i]] += 1
		tr[t[i]] += 1
	}

	for i := 0; i < len(s); i++ {
		if sr[s[i]] != tr[s[i]] {
			return false
		}
	}

	return true
}
