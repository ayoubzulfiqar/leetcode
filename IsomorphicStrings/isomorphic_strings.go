package main

func isIsomorphic(s string, t string) bool {
	if len(s) != len(t) {
		return false
	}

	m := make(map[byte]byte)
	mt := make(map[byte]byte)

	for i := 0; i < len(s); i++ {
		t1 := t[i]

		if value, ok := m[t1]; ok {
			if value != s[i] {
				return false
			}
		} else {
			m[t1] = s[i]
		}

		s1 := s[i]

		if value, ok := mt[s1]; ok {
			if value != t[i] {
				return false
			}
		} else {
			mt[s1] = t[i]
		}
	}

	return true
}
