package main

// find the root of node x.
// here we are not using parent[x],
// because it may not contain the updated value of the connected component that x belongs to.
// therefore, we walk the ancestors of the vertex until we reach the root.
// func find(parent []int, x int) int {
// 	if parent[x] == x {
// 		return x
// 	}
// 	return find(parent, parent[x])
// }

// // the idea is to put all characters in the same group if they are equal
// // in order to do that, we can use Disjoint Set Union (dsu) aka Union Find
// // for dsu tutorial, please check out https://wingkwong.github.io/leetcode-the-hard-way/tutorials/graph-theory/disjoint-set-union
// func equationsPossible(equations []string) bool {
// 	// at the beginning, put each character index in its own group
// 	// so we will have 26 groups with one character each
// 	// i.e. 'a' in group 0, 'b' in group 1, ..., 'z' in group 25
// 	parent := make([]int, 26)
// 	for i := range parent {
// 		parent[i] = i
// 	}
// 	for _, e := range equations {
// 		if e[1] == '=' {
// 			// e.g. a == b
// 			// then we group them together
// 			// how? we use `find` function to find out the parent group of the target character index
// 			// then update parent. a & b would be in group 1 (i.e. a merged into the group where b belongs to)
// 			// or you can also do `find(parent, int(e[3] - 'a')) = find(parent, int(e[0] - 'a'))`
// 			// i.e. b merged into the group where a belongs to
// 			parent[find(parent, int(e[0]-'a'))] = find(parent, int(e[3]-'a'))
// 		}
// 	}
// 	// handle != case
// 	for _, e := range equations {
// 		// if two characters are not equal
// 		// then which means their parent must not be equal
// 		if e[1] == '!' && find(parent, int(e[0]-'a')) == find(parent, int(e[3]-'a')) {
// 			return false
// 		}
// 	}
// 	return true
// }
func equationsPossible(equations []string) bool {
	equals := map[byte]map[byte]bool{}
	not_equals := [][]byte{}
	for _, eq := range equations {
		if string(eq[1]) == "=" {
			if _, ok := equals[eq[0]]; !ok {
				equals[eq[0]] = map[byte]bool{}
			}
			equals[eq[0]][eq[3]] = true
			if _, ok := equals[eq[3]]; !ok {
				equals[eq[3]] = map[byte]bool{}
			}
			equals[eq[3]][eq[0]] = true
		} else {
			not_equals = append(not_equals, []byte{eq[3], eq[0]})
		}
	}

	for key := range equals {
		dfs(key, key, map[byte]bool{}, &equals)
	}

	for _, pair := range not_equals {
		node1 := pair[0]
		node2 := pair[1]
		if node1 == node2 {
			return false
		}
		if v, ok := equals[node1]; ok {
			if _, ok := v[node2]; ok {
				return false
			}
		}
	}
	return true
}

func dfs(start, curr byte, visited map[byte]bool, equals *map[byte]map[byte]bool) {
	if _, ok := visited[curr]; ok {
		return
	}
	visited[curr] = true
	(*equals)[start][curr] = true
	for v := range (*equals)[curr] {
		dfs(start, v, visited, equals)
	}
}
