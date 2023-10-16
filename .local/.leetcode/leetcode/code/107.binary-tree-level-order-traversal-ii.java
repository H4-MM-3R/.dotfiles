// Category: algorithms
// Level: Medium
// Percent: 61.96622%

// Given the root of a binary tree, return the bottom-up level order traversal
// of its nodes' values. (i.e., from left to right, level by level from leaf to
// root).
//
//  
// Example 1:
//
// Input: root = [3,9,20,null,null,15,7]
// Output: [[15,7],[9,20],[3]]
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
// Definition for a binary tree node.

import java.util.ArrayList;
import java.util.LinkedList;
import java.util.List;
import java.util.Queue;

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
  public List<List<Integer>> levelOrderBottom(TreeNode root) {
    List<List<Integer>> ans = new ArrayList<>();
    if (root == null)
      return ans;

    Queue<TreeNode> q = new LinkedList<>();
    q.offer(root);

    while (!q.isEmpty()) {
      int lvlsz = q.size();
      List<Integer> currlvl = new ArrayList<>(lvlsz);
      for (int i = 0; i < lvlsz; i++) {
        TreeNode curr = q.poll();
        currlvl.add(curr.val);
        if (curr.left != null)
          q.offer(curr.left);
        if (curr.right != null)
          q.offer(curr.right);
      }
      ans.add(0, currlvl);
    }
    return ans;
  }
}
// end_marker
