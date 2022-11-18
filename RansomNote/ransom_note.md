# 🔥 Ransom Note 🔥 || 2 Approaches || Simple Fast and Easy || with Explanation

## APPROACH

So, What we doing here is... First we will initialize an array of alphabets counter.
`26 ALPHABETS in ENGLISH`

Now we loop through the entire String of magazine where char c stores the char at the index of magazine..

You might think why I typed i-'a'
It is because in ascii if you subtract any char with 'a' , it gives you index of that alphabet.
Still confused?
Let us assume a = 0 and z = 25. Now subtract a - a. You got 0 in ASCII, right?
now subtract d-a, in ASCII it is 100-97, it leaves you with 3. Isn't that the index of that character in our alphabet counter and isn't that the fact the a=0, b=1, c=2 and d=3. Got it?

Now we increment the counter for that character of its own index according to English Alphabets (Obviously)

We have our counter ready!

Now we run another for loop for ransomNote.
Remember: if the character doesn't exists in magazine for ransomNote, we return false;
or if it does exists, we decrement the counter of that character from its own index.

lastly if nothing goes wrong (we have sufficient amount of characters to make ransomNote)

Return true

## Solution - 1

```dart
class Solution {
  bool canConstruct(String ransomNote, String magazine) {
    // Base case
    if (ransomNote.length > magazine.length) return false;
    // .. English Alphabets
    List<int> alphabetCounter = List.filled(26, 0);
    // every element in the magazine
    // i represents as Index
    for (String i in magazine.split("")) {
      // saving the index value of each and every alphabet based on Character Code
      alphabetCounter[i.codeUnitAt(0) - 'a'.codeUnitAt(0)]++;
    }
    // every element in the ransom Note
    for (String i in ransomNote.split("")) {
      // if index is zero means we can not construct String because it does not exist
      if (alphabetCounter[i.codeUnitAt(0) - 'a'.codeUnitAt(0)] == 0) {
        return false;
      } else {
        // else we decrement that character exist
        alphabetCounter[i.codeUnitAt(0) - 'a'.codeUnitAt(0)]--;
      }
    }
    // all other possible cases
    return true;
  }
}
```

## Solution - 2

```dart
class Solution {
  bool canConstruct(String ransomNote, String magazine) {
    HashMap<String, int> map = HashMap();
    for (String c in magazine.split(""))
      map[c] = map.putIfAbsent(c, () => 0) + 1;

    for (String c in ransomNote.split("")) {
      if (!map.containsKey(c) || map[c]! < 1) return false;
      map[c] = map[c]! - 1;
    }

    return true;
  }
}
```
