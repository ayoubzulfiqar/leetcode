package main

import (
	"fmt"
)

type UndergroundSystem struct {
	stationCount int
	stationId    map[string]int
	checkIns     map[int][2]int
	timings      map[int][2]int
}

func Constructor() UndergroundSystem {
	return UndergroundSystem{
		stationCount: 0,
		stationId:    make(map[string]int),
		checkIns:     make(map[int][2]int),
		timings:      make(map[int][2]int),
	}
}

func (us *UndergroundSystem) CheckIn(id int, stationName string, t int) {
	if _, ok := us.stationId[stationName]; !ok {
		us.stationId[stationName] = us.stationCount
		us.stationCount++
	}
	us.checkIns[id] = [2]int{us.stationId[stationName], t}
}

func (us *UndergroundSystem) CheckOut(id int, stationName string, t int) {
	if _, ok := us.stationId[stationName]; !ok {
		us.stationId[stationName] = us.stationCount
		us.stationCount++
	}
	if startDetail, ok := us.checkIns[id]; ok {
		delete(us.checkIns, id)
		routeHash := startDetail[0]*10000 + us.stationId[stationName]
		travelTime := t - startDetail[1]
		if travelTime <= 0 {
			return
		}
		if timing, ok := us.timings[routeHash]; ok {
			timing[0] += travelTime
			timing[1]++
			us.timings[routeHash] = timing
		} else {
			us.timings[routeHash] = [2]int{travelTime, 1}
		}
	}
}

func (us *UndergroundSystem) GetAverageTime(startStation string, endStation string) float64 {
	routeHash := us.stationId[startStation]*10000 + us.stationId[endStation]
	startDetail := us.timings[routeHash]
	return float64(startDetail[0]) / float64(startDetail[1])
}



/*


type UndergroundSystem struct {
    
}


func Constructor() UndergroundSystem {
    
}


func (this *UndergroundSystem) CheckIn(id int, stationName string, t int)  {
    
}


func (this *UndergroundSystem) CheckOut(id int, stationName string, t int)  {
    
}


func (this *UndergroundSystem) GetAverageTime(startStation string, endStation string) float64 {
    
}

*/

/*
 * Your UndergroundSystem object will be instantiated and called as such:
 * obj := Constructor();
 * obj.CheckIn(id,stationName,t);
 * obj.CheckOut(id,stationName,t);
 * param_3 := obj.GetAverageTime(startStation,endStation);
 */



