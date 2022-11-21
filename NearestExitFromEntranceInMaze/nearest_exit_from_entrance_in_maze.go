package main

type State struct {
	r, c, l int
}

func nearestExit(maze [][]byte, entrance []int) int {
	m, n := len(maze), len(maze[0])
	q := []State{{entrance[0], entrance[1], 0}}
	v := make(map[State]struct{})
	var state, vState State
	var rr, cc int
	d4 := [][]int{{1, 0}, {-1, 0}, {0, 1}, {0, -1}}

	for len(q) > 0 {
		state, q = q[0], q[1:]

		vState = State{state.r, state.c, 0}
		if _, ok := v[vState]; ok {
			continue
		}
		v[vState] = struct{}{}

		if (state.r == 0 || state.r == m-1 || state.c == 0 || state.c == n-1) && (state.r != entrance[0] || state.c != entrance[1]) {
			return state.l
		}

		for _, d := range d4 {
			rr, cc = state.r+d[0], state.c+d[1]
			if rr >= 0 && rr < m && cc >= 0 && cc < n && maze[rr][cc] == '.' {
				q = append(q, State{rr, cc, state.l + 1})
			}
		}

	}

	return -1
}
