package main

type BrowserHistory struct {
	root *Node
}

type Node struct {
	value    string
	next     *Node
	previous *Node
}

func Constructor(homepage string) BrowserHistory {
	return BrowserHistory{
		root: &Node{
			value: homepage,
		},
	}
}

func (this *BrowserHistory) Visit(url string) {
	node := Node{
		value: url,
	}
	node.previous = this.root
	this.root.next = &node
	this.root = this.root.next
}

func (this *BrowserHistory) Back(steps int) string {

	for steps > 0 && this.root.previous != nil {
		this.root = this.root.previous
		steps -= 1
	}
	return this.root.value
}

func (this *BrowserHistory) Forward(steps int) string {
	for steps > 0 && this.root.next != nil {
		this.root = this.root.next
		steps -= 1
	}
	return this.root.value
}

/**
 * Your BrowserHistory object will be instantiated and called as such:
 * obj := Constructor(homepage);
 * obj.Visit(url);
 * param_2 := obj.Back(steps);
 * param_3 := obj.Forward(steps);

 */
