package main

import (
	"strconv"
	"strings"
)

/*
 List<String> readBinaryWatch(int num) {
    List<String> result = [];

    //range 0-3 are hours and range 4-9 are minutes
    List<int> arr = [1, 2, 4, 8, 1, 2, 4, 8, 16, 32];
    backtrack(arr, 0, 0, 0, num, result);
    return result;
  }

  void backtrack(List<int> arr, int position, int hours, int minutes, int limit,
      List<String> result) {
    //when num(limit) reaches to the zero, store hours and minutes into result list
    if (limit == 0) {
      //during recursion we might get e.g 4 + 8 = 12 hours which we must skip because max hour value could be 11
      if (hours <= 11 && minutes <= 59) {
        StringBuffer builder = StringBuffer();
        builder.write(hours);
        builder.write(":");
        builder.write(minutes <= 9 ? "0" + minutes.toString() : minutes);
        result.add(builder.toString());
      }
      return;
    }

    //standard backtracking solution add new value do recursion and then remove it

  }

  //Simple check by range: hours or minutes
  bool isHour(int position) {
    return position >= 0 && position <= 3;
  }

*/
// need updating
func readBinaryWatch(turnedOn int) []string {
	var result []string
	var arr []int = []int{1, 2, 4, 8, 1, 2, 4, 8, 16, 32}
	backTrack(arr, 0, 0, 0, turnedOn, result)
	return result
}
func isHour(position int) bool {
	return position >= 0 && position <= 3
}

func backTrack(arr []int, position int, hours int, minutes int, limit int, result []string) {
	if limit == 0 {
		if hours <= 11 && minutes <= 59 {
			builder := strings.Builder{}
			builder.WriteString(strconv.Itoa(hours))
			builder.WriteString(":")
			if minutes <= 9 {
				builder.WriteString("0" + strconv.Itoa(minutes))
			} else {
				builder.WriteString(strconv.Itoa(minutes))
			}
			result = append(result, builder.String())
			return

		}
		for i := position; i < len(arr); i++ {
			if isHour(i) {
				hours += arr[i]
			} else {
				minutes += arr[i]
			}
			backTrack(arr, i+1, hours, minutes, limit-1, result)

			if isHour(i) {
				hours -= arr[i]
			} else {
				minutes -= arr[i]
			}
		}
	}
}

// func readBinaryWatch(turnedOn int) []string {
// 	var dp []int = make([]int, 60)
// 	for i := 1; i < 60; i++ {
// 		dp[i] = dp[i/2] + (i & 1)
// 	}
// 	var res []string
// 	for hr := 0; hr < 12; hr++ {
// 		for i := 0; i < 60; i++ {
// 			if dp[i]+dp[hr] == turnedOn {
// 				if i < 10 {

// 					res = append(res, strconv.Itoa(hr)+":0"+strconv.Itoa(i))
// 				} else {
// 					res = append(res, strconv.Itoa(hr)+":"+strconv.Itoa(i))
// 				}
// 			}
// 		}
// 	}
// 	return res
// }
