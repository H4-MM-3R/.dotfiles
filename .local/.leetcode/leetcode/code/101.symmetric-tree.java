// Category: algorithms
// Level: Easy
// Percent: 55.10663%

// Given the root of a binary tree, check whether it is a mirror of itself
// (i.e., symmetric around its center).
//
//  
// Example 1:
//
// Input: root = [1,2,2,3,4,4,3]
// Output: true
//
//
// Example 2:
//
// Input: root = [1,2,2,null,3,null,3]
// Output: false
//
//
//  
// Constraints:
//
//
// 	The number of nodes in the tree is in the range [1, 1000].
// 	-100 <= Node.val <= 100
//
//
//  
// Follow up: Could you solve it both recursively and iteratively?

// start_marker
// Definition for a binary tree node.

import java.util.LinkedList;
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
  public boolean isSymmetric(TreeNode root) {
    Queue<TreeNode> q = new LinkedList<>();
    q.add(root.left);
    q.add(root.right);
    while (!q.isEmpty()) {
      TreeNode left = q.poll();
      TreeNode right = q.poll();
      if (left == null && right == null)
        continue;
      if (left == null || right == null)
        return false;
      if (left.val != right.val)
        return false;
      q.add(left.left);
      q.add(right.right);
      q.add(left.right);
      q.add(right.left);
    }
    return true;
  }
}
// end_marker
