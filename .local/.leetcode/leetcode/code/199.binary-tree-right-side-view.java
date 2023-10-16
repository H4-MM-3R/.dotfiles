// Category: algorithms
// Level: Medium
// Percent: 62.158882%

// Given the root of a binary tree, imagine yourself standing on the right side
// of it, return the values of the nodes you can see ordered from top to bottom.
//
//  
// Example 1:
//
// Input: root = [1,2,3,null,5,null,4]
// Output: [1,3,4]
//
//
// Example 2:
//
// Input: root = [1,null,3]
// Output: [1,3]
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
// 	The number of nodes in the tree is in the range [0, 100].
// 	-100 <= Node.val <= 100
//

// start_marker

import java.util.ArrayList;
import java.util.LinkedList;
import java.util.List;
import java.util.Queue;

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
  public List<Integer> rightSideView(TreeNode root) {
    List<Integer> ans = new ArrayList<>();
    if (root == null)
      return ans;

    Queue<TreeNode> q = new LinkedList<>();
    q.offer(root);

    while (!q.isEmpty()) {
      int lvlsz = q.size();
      for (int i = 0; i < lvlsz; i++) {
        TreeNode curr = q.poll();
        if (i == lvlsz - 1) {
          ans.add(curr.val);
        }
        if (curr.left != null)
          q.offer(curr.left);
        if (curr.right != null)
          q.offer(curr.right);
      }
    }

    return ans;
  }
}
// end_marker
