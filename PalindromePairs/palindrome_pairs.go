package main

// Time Limit Exceed

// func palindromePairs(words []string) [][]int {
// 	var res [][]int

// 	var isPalindromic func(string) bool
// 	isPalindromic = func(str string) bool {
// 		if len(str) < 2 {
// 			return true
// 		}
// 		l, r := 0, len(str)-1
// 		for l < r {
// 			if str[l] != str[r] {
// 				return false
// 			}
// 			l, r = l+1, r-1
// 		}
// 		return true
// 	}

// 	for i := 0; i < len(words); i++ {
// 		for j := 0; j < len(words); j++ {
// 			if i != j && isPalindromic(words[i]+words[j]) {
// 				res = append(res, []int{i, j})
// 			}
// 		}
// 	}

// 	return res
// }

/*

Runtime: 1390 ms, faster than 42.31% of Go online submissions for Palindrome Pairs.
Memory Usage: 159.9 MB, less than 30.77% of Go online submissions for Palindrome Pairs.


type TrieNode struct {
	Children          map[byte]*TrieNode
	WordId            int
	PalindromeWordIds []int
}

type Trie struct {
	root *TrieNode
}

func (trie *Trie) insert(index int, word string) {
	node := trie.root

	for i := 0; i < len(word); i++ {
		c := word[len(word)-i-1]
		if isPalindrome(word[:len(word)-i]) {
			node.PalindromeWordIds = append(node.PalindromeWordIds, index)
		}

		if node.Children[c] == nil {
			node.Children[c] = &TrieNode{
				Children: make(map[byte]*TrieNode),
				WordId:   -1,
			}
		}

		node = node.Children[c]
	}

	node.WordId = index
}

func (trie *Trie) search(index int, word string) [][]int {
	node := trie.root
	result := [][]int{}

	for len(word) > 0 {
		if node.WordId > -1 && isPalindrome(word) {
			result = append(result, []int{index, node.WordId})
		}
		if node.Children[word[0]] == nil {
			return result
		}
		node = node.Children[word[0]]
		word = word[1:]
	}

	if node.WordId > -1 && node.WordId != index {
		result = append(result, []int{index, node.WordId})
	}

	for _, palindromeWordId := range node.PalindromeWordIds {
		result = append(result, []int{index, palindromeWordId})
	}

	return result
}

func isPalindrome(word string) bool {
	for i := 0; i < len(word)/2; i++ {
		if word[i] != word[len(word)-i-1] {
			return false
		}
	}
	return true
}

func palindromePairs(words []string) [][]int {
	trie := Trie{
		&TrieNode{
			Children: make(map[byte]*TrieNode),
			WordId:   -1,
		},
	}

	result := [][]int{}

	for i, w := range words {
		trie.insert(i, w)
	}

	for i, w := range words {
		result = append(result, trie.search(i, w)...)
	}

	return result
}
*/

// Runtime: 1088 ms, faster than 53.85% of Go online submissions for Palindrome Pairs.
// Memory Usage: 291.3 MB, less than 7.69% of Go online submissions for Palindrome Pairs.

type TrieNode struct {
	nodes [26]*TrieNode
	idx   int          // corresponding index of word in words.
	match map[int]bool // indices of word whose rest part is a palindrome.
}

// word could be "", but is unique.
func palindromePairs(words []string) [][]int {
	var ret [][]int
	root := &TrieNode{idx: -1, match: make(map[int]bool)}
	for i, word := range words {
		addWord(root, word, i)
	}
	for i, word := range words {
		matchSet := searchWord(root, word)
		for idx := range matchSet {
			if idx != i {
				ret = append(ret, []int{idx, i})
			}
		}
	}
	return ret
}

// Check the word could be the right part of a palindrome.
// E.g. "lls": "lls"+"", "ll"+"s", "l"+"ls", ""+"lls".
func searchWord(root *TrieNode, word string) map[int]bool {
	ret := make(map[int]bool)
	for i := len(word) - 1; i >= 0; i-- {
		if root.idx != -1 && isPalindrome(word[:i+1]) {
			ret[root.idx] = true
		}
		offset := word[i] - 'a'
		if root.nodes[offset] == nil {
			return ret
		}
		root = root.nodes[offset]
	}
	for k := range root.match {
		ret[k] = true
	}
	return ret
}

// Store the word and tag the palindrome property of the rest of the word.
// E.g. "abcc": ""+"abcc", "a"+"bcc", "ab"+"cc"(true), "abc"+"c"(true), "abcc"+""(true)
func addWord(root *TrieNode, word string, idx int) {
	for i := 0; i < len(word); i++ {
		if isPalindrome(word[i:]) {
			root.match[idx] = true
		}
		offset := word[i] - 'a'
		if root.nodes[offset] == nil {
			root.nodes[offset] = &TrieNode{idx: -1, match: make(map[int]bool)}
		}
		root = root.nodes[offset]
	}
	root.idx = idx
	root.match[idx] = true // "" is the rest of any string, and is also a palindrome.
}

func isPalindrome(s string) bool {
	for l, r := 0, len(s)-1; l < r; l, r = l+1, r-1 {
		if s[l] != s[r] {
			return false
		}
	}
	return true
}
