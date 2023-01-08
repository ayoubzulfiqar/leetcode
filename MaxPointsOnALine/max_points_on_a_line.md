# 🔥 Go Fast 🔥 || Simple Fast and Easy || with Explanation

## Approach

Idea is very simple

We will select point and for every selected point we will calculate the slope wr.t to another point and store into the map
In map we will store <slope,that selected point>
for example we have point :-[[1,1],[2,2],[3,3]......
we pick point [1,1]and for that [1,1] we will calculate the slope
w.r.t [2,2] ,[3,3]....... and store like this-
for understanding purpose i'm writing
mp[slope1,[1,1]]
mp[slope2,[1,1]]
mp[slope1,[1,1]].........
This type we will store the slope for [2,2] , [3,3],....
After storing the slope into map we will calculate the max point for that slope
For example after storing the slope map can look like this
[2/3,3]
[-90,1]//for perpendicular case
[1/3,2]...
find the max number of points having the same slope w.r.t. that selected point :-means which slope have maximum point
:- here 2/3 have 3 point so our answer will be 3+1(we are adding that point as well)

## Solution - GO

```go
func maxPoints(points [][]int) int {
	ans := 1
	n := len(points)
	for i := 0; i < n-1; i++ {
		mp := make(map[float64]int)
		for j := i + 1; j < n; j++ {
			if points[j][1] == points[i][1] {
				mp[-90]++
			} else {
				x := float64(points[j][0]-points[i][0]) / float64(points[j][1]-points[i][1])
				mp[x]++
			}
		}
		temp := 0
		for _, v := range mp {
			temp = max(temp, v+1)
		}
		ans = max(temp, ans)
	}
	return ans
}

func max(x, y int) int {
	if x > y {
		return x
	}
	return y
}
```
