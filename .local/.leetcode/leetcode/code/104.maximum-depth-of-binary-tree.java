// Category: algorithms
// Level: Easy
// Percent: 74.41956%

// Given the root of a binary tree, return its maximum depth.
//
// A binary tree's maximum depth is the number of nodes along the longest path
// from the root node down to the farthest leaf node.
//
//  
// Example 1:
//
// Input: root = [3,9,20,null,null,15,7]
// Output: 3
//
//
// Example 2:
//
// Input: root = [1,null,2]
// Output: 2
//
//
//  
// Constraints:
//
//
// 	The number of nodes in the tree is in the range [0, 10⁴].
// 	-100 <= Node.val <= 100
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
  public int maxDepth(TreeNode root) { return height(root, 0); }

  int height(TreeNode node, int curr) {
    if (node == null)
      return 0;

    return Math.max(height(node.left, curr + 1), height(node.right, curr + 1)) +
        1;
  }
}
// end_marker
