package main

// func halvesAreAlike(s string) bool {
// 	var st string = strings.ToLower(s)
// 	var char []string = strings.Split(st, "")
// 	var count int = 0
// 	for i := 0; i < len(char); i++ {
// 		if i == 'a' || i == 'e' || i == 'i' || i == 'o' || i == 'u' {
// 			count++
// 		}
// 	}
// 	if count%2 == 0 {
// 		return true
// 	}

// 	return false
// }

//=========== 2

// func halvesAreAlike(s string) bool {
// 	var firstCount int = 0
// 	var secondCount int = 0

// 	for i := 0; i < len(s)/2; i++ {
// 		if s[i] == 'a' ||
// 			s[i] == 'e' ||
// 			s[i] == 'i' ||
// 			s[i] == 'o' ||
// 			s[i] == 'u' ||
// 			s[i] == 'A' ||
// 			s[i] == 'E' ||
// 			s[i] == 'I' ||
// 			s[i] == 'O' ||
// 			s[i] == 'U' {
// 			firstCount++
// 		}
// 	}
// 	for i := len(s) / 2; i < len(s); i++ {
// 		if s[i] == 'a' ||
// 			s[i] == 'e' ||
// 			s[i] == 'i' ||
// 			s[i] == 'o' ||
// 			s[i] == 'u' ||
// 			s[i] == 'A' ||
// 			s[i] == 'E' ||
// 			s[i] == 'I' ||
// 			s[i] == 'O' ||
// 			s[i] == 'U' {
// 			secondCount++
// 		}
// 	}
// 	if firstCount == secondCount {
// 		return true
// 	}
// 	return false
// }

//============= 3

/*


 bool halvesAreAlike(String s) {
    // set of Vowels
    HashSet<String> vowels =
        HashSet.of(['a', 'e', 'i', 'o', 'u', 'A', 'E', 'I', 'O', 'U']);

    // just to count each and every value of occurrence
    int count = 0;
    //loop for each element in the string
    for (int i = 0; i < s.length; i++) {
      // if they both match
      if (vowels.contains(s[i])) {
        // we will set the value to count
        count += (s.length - 2 * i - 1).sign;
      }
    }
    // than return based on the matching
    return count == 0;
  }

*/
