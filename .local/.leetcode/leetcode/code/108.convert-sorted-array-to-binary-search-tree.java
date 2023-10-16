// Category: algorithms
// Level: Easy
// Percent: 70.555244%

// Given an integer array nums where the elements are sorted in ascending order,
// convert it to a height-balanced binary search tree.
//
//  
// Example 1:
//
// Input: nums = [-10,-3,0,5,9]
// Output: [0,-3,9,-10,null,5]
// Explanation: [0,-10,5,null,-3,null,9] is also accepted:
//
//
//
// Example 2:
//
// Input: nums = [1,3]
// Output: [3,1]
// Explanation: [1,null,3] and [3,1] are both height-balanced BSTs.
//
//
//  
// Constraints:
//
//
// 	1 <= nums.length <= 10⁴
// 	-10⁴ <= nums[i] <= 10⁴
// 	nums is sorted in a strictly increasing order.
//

// start_marker
// Definition for a binary tree node.
public class TreeNode {
  int val;
  TreeNode left;
  TreeNode right;

  TreeNode() {}

  TreeNode(int val) { this.val = val; }

  TreeNode(int val, TreeNode left, TreeNode right) {
    this.val = val;
    this.left = left;
    this.right = right;
  }
}

class Solution {
  public TreeNode sortedArrayToBST(int[] nums) {
    if (nums == null || nums.length == 0)
      return null;

    return sortedArrayToBST(nums, 0, nums.length - 1);
  }

  private TreeNode sortedArrayToBST(int[] nums, int left, int right) {
    if (left > right)
      return null;

    int mid = left + (right - left) / 2;

    TreeNode root = new TreeNode(nums[mid]);

    root.left = sortedArrayToBST(nums, left, mid - 1);
    root.right = sortedArrayToBST(nums, mid + 1, right);
    return root;
  }
}
// end_marker
