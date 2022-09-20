// /*

//  -* Palindrome Pairs *-



//  Given a list of unique words, return all the pairs of the distinct indices (i, j) in the given list, so that the concatenation of the two words words[i] + words[j] is a palindrome.



// Example 1:

// Input: words = ["abcd","dcba","lls","s","sssll"]
// Output: [[0,1],[1,0],[3,2],[2,4]]
// Explanation: The palindromes are ["dcbaabcd","abcddcba","slls","llssssll"]
// Example 2:

// Input: words = ["bat","tab","cat"]
// Output: [[0,1],[1,0]]
// Explanation: The palindromes are ["battab","tabbat"]
// Example 3:

// Input: words = ["a",""]
// Output: [[0,1],[1,0]]


// Constraints:

// 1 <= words.length <= 5000
// 0 <= words[i].length <= 300
// words[i] consists of lower-case English letters.




// */

// import 'dart:collection';

// class A {
//   List<List<int>> palindromePairs(List<String> words) {
//     List<List<int>> pairs = [];
//     if (words == null) return pairs;
//     HashMap<String, int> map = HashMap();
//     //  for (int i = 0; i < words.length; ++i) map.put(words[i], i);
//     for (int i = 0; i < words.length; ++i) {
//       map.putIfAbsent(words[i], () => i);
//     }
//     for (int i = 0; i < words.length; ++i) {
//       int l = 0, r = 0;
//       while (l <= r) {
//         String s = words[i].substring(l, r);
//         // int j = map.get(StringBuffer(s).toString().split("").reversed.join());
//         int j =
//             map[StringBuffer(s).toString().split("").reversed.join()] as int;

//         if (i != j &&
//             isPalindrome(words[i]
//                 .substring(l == 0 ? r : 0, l == 0 ? words[i].length : l)))
//           pairs.add((l == 0 ? {i, j} : {j, i}).toList());
//         if (r < words[i].length)
//           ++r;
//         else
//           ++l;
//       }
//     }
//     return pairs;
//   }

//   bool isPalindrome(String s) {
//     for (int i = 0; i < s.length ~/ 2; ++i)
//       if (s.codeUnitAt(i) != s.codeUnitAt(s.length - 1 - i)) return false;
//     return true;
//   }
// }

// class B {
//   List<List<int>> palindromePairs(List<String> words) {
//     var i, j, wordLength, prefix, suffix, reversedPrefix, reversedSuffix;
//   Map dict = {};
//   List<List<int>> result = [];
//   int length = words.length;

//   if (words.isEmpty || length == 0) {
//     return [];
//   }

//   for (i = 0; i < length; i += 1) {
//     dict[words[i]] = i;
//   }

//   for (i = 0; i < length; i += 1) {
//     wordLength = words[i].length;

//     prefix = '';
//     suffix = words[i];
//     reversedPrefix = '';
//     reversedSuffix = suffix.toString().split('').reversed.join('');

//     for (j = 0; j < wordLength + 1; j += 1) {
//       if (j != 0) {
//         prefix += words[i][j - 1];
//         suffix = suffix.slice(1);
//         reversedPrefix = words[i][j - 1] + reversedPrefix;
//         reversedSuffix = reversedSuffix.slice(0, reversedSuffix.length - 1);
//       }

//       if (j != 0 && prefix == reversedPrefix && reversedSuffix in dict && dict[reversedSuffix] != i) {
//       result.add([dict[reversedSuffix], i]);
//       }

//       if (suffix == reversedSuffix && reversedPrefix in dict && dict[reversedPrefix] != i) {
//         result.add([i, dict[reversedPrefix]]);
//       }
//     }
//   }
//   return result;
//   }
// }


// class C {

//   /*

//   95 / 136 test cases passed.
// Status: Time Limit Exceeded
// Submitted: 0 minutes ago
// Last executed input:
// ["egjc","cffdegafjghcjbja","ceaebcgaahfbdecff","hfegaijc","ccbggiabdjid","fieffehfdjg","dehb","hefdiff","dcfdeidifdie
//   */
//   List<List<int>> palindromePairs(List<String> words) {
// List<List<int>> res = [];
//         for(int i=0;i<words.length;i++)
//         {
//             for(int j=0;j<words.length;j++)
//             {
//                 if(i!=j)
//                 {
//                     if(check(words[i]+words[j]))
//                        // res.push_back({i,j});

//                        res.add([i, j]);
//                 }
//             }
//         }
//         return res;
//     }
//     bool check(String a)
//     {
//         int i=0,j=a.length-1;
//         while(i<=j)
//         {
//             if(a[i]!=a[j])
//                 return false;
//             i++;
//             j--;
//         }
//         return true;
//     }


// }

// class D {
//   List<List<int>> palindromePairs(List<String> words) {

//     List<List<int>> res = [];
//         if(words.length<2)
//             return res;
//         Map<String,int> mp = {};
//         for(int i=0;i<words.length;i++)
//             mp[words[i]] = i;

//         for(int i=0;i<words.length;i++)
//         {
//             for(int j=0;j<=words[i].length;j++)
//             {
//                 String prefixString = words[i].substring(0,j);
//                 String suffixString = words[i].substring(j);

//                 if(isPalindrome(prefixString))
//                 {
//                     String reverseString = suffixString.toString().split("").reversed.join();
//                   //  reverse(reverseString.begin(),reverseString.end());
//                     if(mp.count(reverseString) && mp[reverseString]!=i)
//                     {
//                         res.add([mp[reverseString],i]);
//                     }
//                 }

//                 if(isPalindrome(suffixString))
//                 {
//                     String reverseString = suffixString.toString().split("").reversed.join();
//                    // reverse(reverseString.begin(),reverseString.end());
//                     if(mp.count(reverseString) && mp[reverseString]!=i && !suffixString.isEmpty)
//                     {
//                         res.add([i,mp[reverseString]]);
//                     }
//                 }

//             }
//         }
//         return res;

//   }
//     bool isPalindrome(String str)
//     {
//         int i=0;
//         int j=str.length-1;
//         while(i<=j)
//         {
//             if(str[i]!=str[j])
//                 return false;
//             i++;j--;
//         }
//         return true;
//     }
// }

// class E {
//   List<List<int>> palindromePairs(List<String> words) {}
// }

// class F {
//   List<List<int>> palindromePairs(List<String> words) {}
// }
