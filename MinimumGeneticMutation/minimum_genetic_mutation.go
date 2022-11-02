package main

func minMutation(start string, end string, bank []string) int {

	if start == end {
		return 0
	}

	charSet := []rune{'A', 'C', 'G', 'T'}
	//convert bank array to map
	bankmap := make(map[string]struct{})
	for _, seq := range bank {
		bankmap[seq] = struct{}{}
	}

	level := 0
	//visited map that stores all sequences visited
	visited := make(map[string]struct{})

	//return all possible "valid" mutations
	getNextMutation := func(mut string, pos int) []string {
		mutations := []string{}
		for _, char := range charSet {
			//generate a new seqence by replacing the character at "pos" with each character in charSet
			newseq := mut[:pos] + string(char) + mut[pos+1:]
			//check if the new sequence exist in bank, and has not been visited already
			if isInMap(newseq, bankmap) && !isInMap(newseq, visited) {
				mutations = append(mutations, newseq)
				visited[newseq] = struct{}{} //update visited map
			}
		}
		return mutations
	}

	//bfs queue
	queue := []string{}
	queue = append(queue, start)
	visited[start] = struct{}{}
	for len(queue) > 0 {
		qlen := len(queue)
		for _, seq := range queue[:qlen] {

			if seq == end {
				return level
			}
			//get all possible mutations by modifying each character of the sequence
			for idx := range seq {
				mutations := getNextMutation(seq, idx)
				queue = append(queue, mutations...)
			}
		}
		level++
		queue = queue[qlen:]
	}
	return -1
}

func isInMap(seq string, m map[string]struct{}) bool {
	_, ok := m[seq]
	return ok
}
