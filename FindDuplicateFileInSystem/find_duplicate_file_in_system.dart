// /*

//  -* Find Duplicate File in System *-

//  Given a list paths of directory info, including the directory path, and all the files with contents in this directory, return all the duplicate files in the file system in terms of their paths. You may return the answer in any order.

// A group of duplicate files consists of at least two files that have the same content.

// A single directory info string in the input list has the following format:

// "root/d1/d2/.../dm f1.txt(f1_content) f2.txt(f2_content) ... fn.txt(fn_content)"
// It means there are n files (f1.txt, f2.txt ... fn.txt) with content (f1_content, f2_content ... fn_content) respectively in the directory "root/d1/d2/.../dm". Note that n >= 1 and m >= 0. If m = 0, it means the directory is just the root directory.

// The output is a list of groups of duplicate file paths. For each group, it contains all the file paths of the files that have the same content. A file path is a string that has the following format:

// "directory_path/file_name.txt"


// Example 1:

// Input: paths = ["root/a 1.txt(abcd) 2.txt(efgh)","root/c 3.txt(abcd)","root/c/d 4.txt(efgh)","root 4.txt(efgh)"]
// Output: [["root/a/2.txt","root/c/d/4.txt","root/4.txt"],["root/a/1.txt","root/c/3.txt"]]
// Example 2:

// Input: paths = ["root/a 1.txt(abcd) 2.txt(efgh)","root/c 3.txt(abcd)","root/c/d 4.txt(efgh)"]
// Output: [["root/a/2.txt","root/c/d/4.txt"],["root/a/1.txt","root/c/3.txt"]]


// Constraints:

// 1 <= paths.length <= 2 * 104
// 1 <= paths[i].length <= 3000
// 1 <= sum(paths[i].length) <= 5 * 105
// paths[i] consist of English letters, digits, '/', '.', '(', ')', and ' '.
// You may assume no files or directories share the same name in the same directory.
// You may assume each given directory info represents a unique directory. A single blank space separates the directory path and file info.


// Follow up:

// Imagine you are given a real file system, how will you search files? DFS or BFS?
// If the file content is very large (GB level), how will you modify your solution?
// If you can only read the file by 1kb each time, how will you modify your solution?
// What is the time complexity of your modified solution? What is the most time-consuming part and memory-consuming part of it? How to optimize?
// How to make sure the duplicated files you find are not false positive?


// */

// import 'dart:collection';

// class A {
//   List<List<String>> findDuplicate(List<String> paths) {
//     HashMap<String, List<String>> map = HashMap();
//     List<List<String>> res = [];
//     for (String p in paths) {
//       List<String> splits = p.split("\\s");
//       String? root = null;
//       for (String s in splits) {
//         if (root == null)
//           root = s;
//         else {
//           List<String> file = s.split("[\\(\\)]");
//           if (!map.containsKey(file[1])) {
//             // map.put(file[1], List);
//             // map.forEach((key, value) {
//             //   file[1] = key;
//             // });
//             map.putIfAbsent(file[1], () => List.empty(growable: true));
//           }
//           // map.get(file[1]).add(root + "/" + file[0]);
//           // map.forEach((key, value) {
//           //   map.addAll(root + "/" + file[0])
//           // })
//         }
//       }
//     }
//     for (List<String> r in map.values) {
//       if (r.length > 1) res.add(r);
//     }
//     return res;
//   }
// }

// class B {
//   List<List<String>> findDuplicate(List<String> paths) {
//     int n = paths.length;
//     // Hashmap to store all file paths for each unique data
//     Map<String, List<String>> datafiles = {};
//     List<List<String>> ans = [];

//     for (String path in paths) {
//       String dir = "";
//       String splitpath = "";
//       String data = "";

//       for (int i = 0; i < path.length; i++) {
//         if (path[i] == '(') {
//           // Extract data from path
//           i++;
//           while (path[i] != ')') {
//             data += path[i];
//             i++;
//           }
//           //  datafiles[data].push_back(dir+'/'+splitpath);

//           data = "";
//         } else if (path[i] == ' ') {
//           // Extract filename or dirname from path
//           if (dir == "") {
//             dir = splitpath;
//           }
//           splitpath = "";
//         } else {
//           splitpath += path[i];
//         }
//       }
//     }
//     // Add all duplicate files(lenght>1) to ans
//     // for(var files in datafiles){
//     //     if(files.second.size()>1){
//     //      //   ans.push_back(files.second);
//     //     }
//     // }
//     return ans;
//   }
// }

// class C {
//   List<List<String>> findDuplicate(List<String> paths) {}
// }

// class D {
//   List<List<String>> findDuplicate(List<String> paths) {}
// }

// class E {
//   List<List<String>> findDuplicate(List<String> paths) {}
// }
