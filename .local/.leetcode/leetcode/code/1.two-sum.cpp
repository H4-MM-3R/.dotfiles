// Category: algorithms
// Level: Easy
// Percent: 50.52243%

// Given an array of integers nums and an integer target, return indices of the
// two numbers such that they add up to target.
//
// You may assume that each input would have exactly one solution, and you may
// not use the same element twice.
//
// You can return the answer in any order.
//
//  
// Example 1:
//
// Input: nums = [2,7,11,15], target = 9
// Output: [0,1]
// Explanation: Because nums[0] + nums[1] == 9, we return [0, 1].
//
//
// Example 2:
//
// Input: nums = [3,2,4], target = 6
// Output: [1,2]
//
//
// Example 3:
//
// Input: nums = [3,3], target = 6
// Output: [0,1]
//
//
//  
// Constraints:
//
//
// 	2 <= nums.length <= 10⁴
// 	-10⁹ <= nums[i] <= 10⁹
// 	-10⁹ <= target <= 10⁹
// 	Only one valid answer exists.
//
//
//  
// Follow-up: Can you come up with an algorithm that is less than O(n²) time
// complexity?
#include <unordered_map>
#include <vector>

// start_marker
using std::unordered_map;
using std::vector;

class Solution {
public:
  vector<int> twoSum(vector<int> &nums, int target) {
    vector<int> ans;
    unordered_map<int, int> mp;
    for (int i = 0; i < nums.size(); i++) {
      int other_num = target - nums[i];

      if (mp.find(other_num) == mp.end()) {
        mp[nums[i]] = i;
      } else {
        ans.push_back(i);
        ans.push_back(mp[other_num]);
      }
    }
    return ans;
  }
};
// end_marker
