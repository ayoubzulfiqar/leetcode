package main

import "math/rand"

type RandomizedSet struct {
	data    []int
	size    int /* store array size for faster process */
	indexes map[int]int
}

func Constructor() RandomizedSet {
	return RandomizedSet{
		data:    []int{},
		size:    0,
		indexes: map[int]int{}}
}

func (this *RandomizedSet) Insert(val int) bool {
	var (
		ok bool
	)

	if _, ok = this.indexes[val]; ok {
		return false
	}

	this.data = append(this.data, val)
	this.indexes[val] = this.size
	this.size++

	return true
}

func (this *RandomizedSet) Remove(val int) bool {
	var (
		index int
		ok    bool
	)

	if index, ok = this.indexes[val]; !ok {
		return false
	}

	this.size--
	this.data[index] = this.data[this.size]
	this.indexes[this.data[this.size]] = index
	this.data = this.data[:this.size]
	delete(this.indexes, val)

	return true
}

func (this *RandomizedSet) GetRandom() int {
	return this.data[rand.Intn(this.size)]
}
