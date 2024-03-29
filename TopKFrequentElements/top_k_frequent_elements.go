package main

import "container/heap"

type Word struct {
	word      int
	frequency int
}

func newWord(word int, frequency int) *Word {
	return &Word{word: word, frequency: frequency}
}

type H struct {
	items []*Word
}

func (h *H) Len() int { return len(h.items) }

func (h *H) Less(i, j int) bool {
	if h.items[i].frequency != h.items[j].frequency {
		return h.items[i].frequency < h.items[j].frequency
	}
	return h.items[i].word > h.items[j].word
}

func (h *H) Swap(i, j int) { h.items[i], h.items[j] = h.items[j], h.items[i] }

func (h *H) Push(i interface{}) { h.items = append(h.items, i.(*Word)) }

func (h *H) Pop() interface{} {
	n := len(h.items)
	item := h.items[n-1]
	h.items = h.items[:n-1]
	return item
}

func topKFrequent(words []int, k int) []int {
	counts := map[int]int{}
	h := &H{}
	for _, v := range words {
		counts[v]++

	}
	for key, v := range counts {
		heap.Push(h, newWord(key, v))
		if h.Len() > k {
			heap.Pop(h)
		}
	}
	result := []int{}
	for h.Len() > 0 {
		result = append([]int{heap.Pop(h).(*Word).word}, result...)
	}
	return result
}
