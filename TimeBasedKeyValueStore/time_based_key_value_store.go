package main

import "strconv"

//Runtime: 454 ms, faster than 85.83% of Go online submissions for Time Based Key-Value Store.
//Memory Usage: 73.3 MB, less than 10.52% of Go online submissions for Time Based Key-Value Store.

type TimeMap struct {
	timestamps map[string][]int
	values     map[string]string
}

// Constructor initializes TimeMap structure
func Constructor() TimeMap {
	return TimeMap{
		timestamps: make(map[string][]int),
		values:     make(map[string]string),
	}
}

// Set value by key and timestamp
func (tm *TimeMap) Set(key string, value string, timestamp int) {
	tm.timestamps[key] = append(tm.timestamps[key], timestamp)
	tm.values[key+strconv.Itoa(timestamp)] = value
}

// Get value by key and timestamp
func (tm *TimeMap) Get(key string, timestamp int) string {
	timestamps, ok := tm.timestamps[key]
	if !ok || timestamps[0] > timestamp {
		return ""
	}
	if timestamps[len(timestamps)-1] <= timestamp {
		return tm.values[key+strconv.Itoa(timestamps[len(timestamps)-1])]
	}
	left := 0
	right := len(timestamps) - 1
	for left < right {
		mid := left + (right-left)/2
		if timestamps[mid] == timestamp {
			return tm.values[key+strconv.Itoa(timestamps[mid])]
		}
		if timestamps[mid] < timestamp {
			left = mid + 1
		} else {
			right = mid
		}
	}
	return tm.values[key+strconv.Itoa(timestamps[left-1])]
}
