// Category: algorithms
// Level: Easy
// Percent: 71.8782%

// Given the root of a binary tree, return the average value of the nodes on
// each level in the form of an array. Answers within 10-5 of the actual answer
// will be accepted.   Example 1:
//
// Input: root = [3,9,20,null,null,15,7]
// Output: [3.00000,14.50000,11.00000]
// Explanation: The average value of nodes on level 0 is 3, on level 1 is 14.5,
// and on level 2 is 11. Hence return [3, 14.5, 11].
//
//
// Example 2:
//
// Input: root = [3,9,20,15,7]
// Output: [3.00000,14.50000,11.00000]
//
//
//  
// Constraints:
//
//
// 	The number of nodes in the tree is in the range [1, 10⁴].
// 	-2³¹ <= Node.val <= 2³¹ - 1
//

// start_marker

import java.util.ArrayList;
import java.util.LinkedList;
import java.util.Queue;

/**
 * Definition for a binary tree node.
 * public class TreeNode {
 * int val;
 * TreeNode left;
 * TreeNode right;
 * TreeNode() {}
 * TreeNode(int val) { this.val = val; }
 * TreeNode(int val, TreeNode left, TreeNode right) {
 * this.val = val;
 * this.left = left;
 * this.right = right;
 * }
 * }
 */
class Solution {
  public List<Double> averageOfLevels(TreeNode root) {
    List<Double> ans = new ArrayList<>();
    if (root == null)
      return ans;

    Queue<TreeNode> q = new LinkedList<>();
    q.offer(root);

    while (!q.isEmpty()) {
      int lvlsz = q.size();
      double avg = 0;
      double lvlsm = 0;

      for (int i = 0; i < lvlsz; i++) {
        TreeNode curr = q.poll();
        lvlsm += curr.val;
        if (curr.left != null)
          q.offer(curr.left);
        if (curr.right != null)
          q.offer(curr.right);
      }
      avg = lvlsm / lvlsz;
      ans.add(avg);
    }
    return ans;
  }
}
// end_marker
