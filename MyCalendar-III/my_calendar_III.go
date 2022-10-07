package main

import "math"

type MyCalendarThree struct {
	vals map[int]int
	lazy map[int]int
}

func Constructor() MyCalendarThree {
	vals := make(map[int]int)
	lazy := make(map[int]int)

	return MyCalendarThree{
		vals: vals,
		lazy: lazy,
	}
}

func (this *MyCalendarThree) Book(start int, end int) int {
	this.Update(start, end-1, 0, int(math.Pow(10, 9)), 1)
	return this.vals[1]
}

func (this *MyCalendarThree) Update(start int, end int, left int, right int, idx int) {
	if start > right || end < left {
		return
	}

	if start <= left && right <= end {
		this.vals[idx]++
		this.lazy[idx]++
	} else {
		mid := (right-left)/2 + left
		this.Update(start, end, left, mid, idx*2)
		this.Update(start, end, mid+1, right, idx*2+1)
		this.vals[idx] = this.lazy[idx] + max(this.vals[2*idx], this.vals[2*idx+1])
	}
}

func max(x, y int) int {
	if x > y {
		return x
	}
	return y
}

/*

type indexed = struct {
    idx int32
    val int32
}
type MyCalendarThree []indexed

func Constructor() MyCalendarThree {
    return MyCalendarThree{}
}

func appendSorted2(sli []indexed, former, later indexed) []indexed {
    var f = func(item indexed) func(int) bool {
        return func(i int) bool {
            if sli[i].idx == item.idx {
                return sli[i].val >= item.val
            }
            return sli[i].idx >= item.idx
        }
    }
    iF, iL := sort.Search(len(sli), f(former)), sort.Search(len(sli), f(later))
    if iF == len(sli) {
        return append(sli, former, later)
    }
    if iL == len(sli) {
        sli = append(sli, later, indexed{})
        copy(sli[iF+1:], sli[iF:])
        sli[iF] = former
        return sli
    }
    sli = append(sli, indexed{}, indexed{})
    copy(sli[iL+2:], sli[iL:])
    if iF != iL {
        copy(sli[iF+1:iL+1], sli[iF:iL])
    }
    sli[iF], sli[iL+1] = former, later
    return sli
}

func (c *MyCalendarThree) Book(start, end int) (max int) {
    *c = appendSorted2(*c, indexed{int32(start), 1}, indexed{int32(end), -1})
    var curr int
    for _, v := range *c {
        curr += int(v.val)
        if curr > max {
            max = curr
        }
    }
    return
}


*/
