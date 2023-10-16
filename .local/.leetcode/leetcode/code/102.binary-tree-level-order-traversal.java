// Category: algorithms
// Level: Medium
// Percent: 65.47262%

// Given the root of a binary tree, return the level order traversal of its
// nodes' values. (i.e., from left to right, level by level).
//
//  
// Example 1:
//
// Input: root = [3,9,20,null,null,15,7]
// Output: [[3],[9,20],[15,7]]
//
//
// Example 2:
//
// Input: root = [1]
// Output: [[1]]
//
//
// Example 3:
//
// Input: root = []
// Output: []
//
//
//  
// Constraints:
//
//
// 	The number of nodes in the tree is in the range [0, 2000].
// 	-1000 <= Node.val <= 1000
//

// start_marker

import java.util.ArrayList;
import java.util.LinkedList;
import java.util.List;
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
  public List<List<Integer>> levelOrder(TreeNode root) {
    ArrayList<List<Integer>> ans = new ArrayList<>();

    if (root == null)
      return ans;

    Queue<TreeNode> q = new LinkedList<>();
    q.offer(root);

    while (!q.isEmpty()) {
      int lvlsz = q.size();
      List<Integer> currlvl = new ArrayList<>();
      for (int i = 0; i < lvlsz; i++) {
        TreeNode curr = q.poll();
        currlvl.add(curr.val);
        if (curr.left != null)
          q.offer(curr.left);
        if (curr.right != null)
          q.offer(curr.right);
      }
      ans.add(currlvl);
    }

    return ans;
  }
}
// end_marker
