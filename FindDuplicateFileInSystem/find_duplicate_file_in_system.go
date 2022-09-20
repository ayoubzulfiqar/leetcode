package main

import "strings"

func findDuplicate(paths []string) [][]string {
	files := make(map[string][]string)
	for _, path := range paths {
		ps := strings.Split(path, " ")
		for _, file := range ps[1:] {
			fs := strings.Split(file, "(")
			files[fs[1]] = append(files[fs[1]], ps[0]+"/"+fs[0])
		}
	}

	out := [][]string{}
	for _, file := range files {
		if len(file) > 1 {
			out = append(out, file)
		}
	}

	return out
}
