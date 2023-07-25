package main

func peakIndexInMountainArray(arr []int) int {
	return getPeak(len(arr)/2, arr, 0, len(arr)-1)
}

func getPeak(current int, arr []int, start int, end int) int {
	if arr[current] < arr[current+1] {
		start = current
		current = (start + end) / 2
		return getPeak(current, arr, start, end)
	}
	if arr[current] < arr[current-1] {
		end = current
		current = (end - start) / 2
		return getPeak(current/2, arr, start, end)
	}
	return current
}
