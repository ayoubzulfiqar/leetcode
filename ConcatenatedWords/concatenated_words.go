package main

type Trie struct {
	Children map[string]*Trie // important to make it a pointer to modify the Children.Trie value
	End      bool
}

func NewTrie() *Trie {
	return &Trie{
		Children: make(map[string]*Trie),
		End:      false,
	}
}

func addWord(t *Trie, word string) {
	var current *Trie = t
	for i := 0; i < len(word); i++ {
		letter := string(word[i])
		if _, ok := current.Children[letter]; !ok {
			current.Children[letter] = NewTrie()
		}
		current = current.Children[letter]
	}
	current.End = true
}

func searchConcat(root *Trie, word string, index int, count int) bool {
	// base case
	if index >= len(word) {
		return count >= 2
	}

	var current *Trie = root

	for i := index; i < len(word); i++ {
		letter := string(word[i])
		if _, ok := current.Children[letter]; !ok {
			break
		}

		current = current.Children[letter]

		// when we reach the end, 2 choices
		// restart or continue
		if current.End {

			// restart
			atRestart := searchConcat(root, word, i+1, count+1)
			if atRestart {
				return true
			} else {
				// continue down the branch
				continue
			}
		}
	}
	return false
}

func findAllConcatenatedWordsInADict(words []string) []string {
	var trie *Trie = NewTrie()
	for _, word := range words {
		addWord(trie, word)
	}

	var validWords []string = []string{}
	for _, word := range words {
		isFound := searchConcat(trie, word, 0, 0)
		if isFound {
			validWords = append(validWords, word)
		}
	}
	return validWords
}
