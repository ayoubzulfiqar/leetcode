package main

import "math"

/*
type LinkNode struct {
	val  int
	pos  bool
	next *LinkNode
	prev *LinkNode
}

func asteroidCollision(a []int) []int {
	head := &LinkNode{pos: false}
	current := head

	n := len(a)

	for i := 0; i < n; i++ {
		node := &LinkNode{val: int(math.Abs(float64(a[i]))), pos: a[i] > 0}
		current.next = node
		node.prev = current
		current = node
	}

	tail := &LinkNode{pos: true}
	current.next = tail
	tail.prev = current

	current = head
	for current != tail {
		if current.pos {
			nextNode := current.next
			if nextNode.pos {
				current = nextNode
			} else {
				if nextNode.val == current.val {
					prevNode := current.prev
					delete1 := current
					delete2 := current.next
					nextNode = delete2.next
					prevNode.next = nextNode
					if nextNode != nil {
						nextNode.prev = prevNode
					}
					current = prevNode
					_ = delete1
					_ = delete2
				} else if nextNode.val > current.val {
					prevNode := current.prev
					prevNode.next = nextNode
					if nextNode != nil {
						nextNode.prev = prevNode
					}
					if prevNode.pos {
						current = current.prev
					} else {
						current = current.next
					}
				} else {
					_ = nextNode
					nextNode = nextNode.next
					current.next = nextNode
					if nextNode != nil {
						nextNode.prev = current
					}
				}
			}
		} else {
			current = current.next
		}
	}

	var ans []int
	current = head.next
	for current != tail {
		value := current.val
		if !current.pos {
			value = -value
		}
		ans = append(ans, value)
		current = current.next
	}

	return ans
}
*/

func asteroidCollision(asteroids []int) []int {
	n := len(asteroids)
	j := 0

	for i := 0; i < n; i++ {
		asteroid := asteroids[i]
		for j > 0 && asteroids[j-1] > 0 && asteroid < 0 && asteroids[j-1] < int(math.Abs(float64(asteroid))) {
			j--
		}

		if j == 0 || asteroid > 0 || asteroids[j-1] < 0 {
			asteroids[j] = asteroid
			j++
		} else if asteroids[j-1] == int(math.Abs(float64(asteroid))) {
			j--
		}
	}

	result := make([]int, j)
	copy(result, asteroids[:j])
	return result
}
