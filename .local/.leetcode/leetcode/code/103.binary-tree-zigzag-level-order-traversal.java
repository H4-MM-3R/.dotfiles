// Category: algorithms
// Level: Medium
// Percent: 57.71864%

// Given the root of a binary tree, return the zigzag level order traversal of
// its nodes' values. (i.e., from left to right, then right to left for the next
// level and alternate between).
//
//  
// Example 1:
//
// Input: root = [3,9,20,null,null,15,7]
// Output: [[3],[20,9],[15,7]]
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
// 	-100 <= Node.val <= 100
//

// start_marker
// Definition for a binary tree node.

import java.util.ArrayList;
import java.util.Deque;
import java.util.LinkedList;
import java.util.List;

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
  public List<List<Integer>> zigzagLevelOrder(TreeNode root) {
    List<List<Integer>> ans = new ArrayList<>();

    if (root == null)
      return ans;

    Deque<TreeNode> q = new LinkedList<>();
    q.offer(root);

    boolean reverse = false;

    while (!q.isEmpty()) {
      int lvlsz = q.size();
      List<Integer> currlvl = new ArrayList<>(lvlsz);
      for (int i = 0; i < lvlsz; i++) {
        if (!reverse) {
          TreeNode curr = q.pollFirst();
          currlvl.add(curr.val);
          if (curr.left != null)
            q.addLast(curr.left);
          if (curr.right != null)
            q.addLast(curr.right);
        } else {
          TreeNode curr = q.pollLast();
          currlvl.add(curr.val);
          if (curr.right != null)
            q.addFirst(curr.right);
          if (curr.left != null)
            q.addFirst(curr.left);
        }
      }
      reverse = !reverse; // switching
      ans.add(currlvl);
    }
    return ans;
  }
}
// end_marker
