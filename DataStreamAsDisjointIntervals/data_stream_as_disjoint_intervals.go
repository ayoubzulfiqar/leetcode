package main

type SummaryRanges struct {
	nums []bool
}

func Constructor() SummaryRanges {
	return SummaryRanges{
		nums: make([]bool, 10002),
	}
}

func (this *SummaryRanges) AddNum(value int) {
	this.nums[value] = true
}

func (this *SummaryRanges) GetIntervals() [][]int {
	res := make([][]int, 0)
	lo, hi := -1, -1
	for i := range this.nums {
		if !this.nums[i] {
			if lo != -1 {
				res = append(res, []int{lo, hi})
				lo, hi = -1, -1
			}
			continue
		}
		if lo == -1 {
			lo, hi = i, i
			continue
		}
		hi = i
	}
	return res

}

// O(N) O(1)
// O(1) O(N)

/**
 * Your SummaryRanges object will be instantiated and called as such:
 * obj := Constructor();
 * obj.AddNum(value);
 * param_2 := obj.GetIntervals();
 */
