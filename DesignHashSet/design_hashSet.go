package main

type MyHashSet struct {
	mp []uint32
}

func Constructor() MyHashSet {
	return MyHashSet{
		mp: make([]uint32, 125001),
	}
}

func (this *MyHashSet) Add(key int) {
	index := key / 32
	bitPosition := uint32(key % 32)
	this.mp[index] |= (1 << bitPosition)
}

func (this *MyHashSet) Remove(key int) {
	index := key / 32
	bitPosition := uint32(key % 32)
	this.mp[index] &= ^(1 << bitPosition)
}

func (this *MyHashSet) Contains(key int) bool {
	index := key / 32
	bitPosition := uint32(key % 32)
	return (this.mp[index] & (1 << bitPosition)) != 0
}
