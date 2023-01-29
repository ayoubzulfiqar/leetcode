package main

import "container/list"

type LFUCache struct {
	keyToNode map[int]*list.Element
	freqList  []*list.List
	cap       int
	minFreq   int
}

type Payload struct {
	key   int
	value int
	freq  int
}

func Constructor(capacity int) LFUCache {
	freqList := make([]*list.List, 200001)
	return LFUCache{
		keyToNode: make(map[int]*list.Element),
		freqList:  freqList,
		cap:       capacity,
		minFreq:   1,
	}
}

// O(1)
func (this *LFUCache) Get(key int) int {
	// if key is present, (1) remove element from freqList
	//                    (2) increment element's freq and insert into back of freqList[element's freq]
	// if key is not present, return -1

	if ele, ok := this.keyToNode[key]; ok {
		value := ele.Value.(*Payload).value
		this.updateListNode(ele, &value)
		return value
	}
	return -1
}

// O(1)
func (this *LFUCache) Put(key int, value int) {
	// if key is present, (1) remove element from freqList
	//                    (2) increment element's freq and insert into back of freqList[element's freq]
	// if key is not present, (1) if capacity reached, remove element with least frequency (iterate from bottom of freqList) and least recently used (first node of freqList[x])
	//                        (2) insert new element at end of freqList[1]

	if this.cap == 0 {
		return
	}

	if ele, ok := this.keyToNode[key]; ok {
		this.updateListNode(ele, &value)
		return
	}

	if len(this.keyToNode) == this.cap {
		if this.freqList[this.minFreq] != nil && this.freqList[this.minFreq].Len() > 0 {
			ele := this.freqList[this.minFreq].Front()
			this.freqList[this.minFreq].Remove(ele)
			delete(this.keyToNode, ele.Value.(*Payload).key)
		}
		if this.freqList[this.minFreq].Len() == 0 {
			this.minFreq++
		}
	}

	payload := &Payload{
		key:   key,
		value: value,
		freq:  1,
	}
	this.minFreq = payload.freq
	if this.freqList[payload.freq] == nil {
		this.freqList[payload.freq] = list.New()
	}
	newEle := this.freqList[payload.freq].PushBack(payload)
	this.keyToNode[key] = newEle
}

func (this *LFUCache) updateListNode(ele *list.Element, value *int) {
	payload := ele.Value.(*Payload)
	if value != nil {
		payload.value = *value
	}
	this.freqList[payload.freq].Remove(ele)
	if payload.freq == this.minFreq && this.freqList[payload.freq].Len() == 0 {
		this.minFreq = payload.freq + 1
	}
	payload.freq++
	if this.freqList[payload.freq] == nil {
		this.freqList[payload.freq] = list.New()
	}
	newEle := this.freqList[payload.freq].PushBack(payload)
	this.keyToNode[payload.key] = newEle
}

/**
 * Your LFUCache object will be instantiated and called as such:
 * obj := Constructor(capacity);
 * param_1 := obj.Get(key);
 * obj.Put(key,value);
 */
