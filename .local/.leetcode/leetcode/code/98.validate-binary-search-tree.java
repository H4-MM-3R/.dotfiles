// Category: algorithms
// Level: Medium
// Percent: 32.24521%

// Given the root of a binary tree, determine if it is a valid binary search
// tree (BST).
//
// A valid BST is defined as follows:
//
//
// 	The left subtree of a node contains only nodes with keys less than the
// node's key. 	The right subtree of a node contains only nodes with keys
// greater
// than the node's key. 	Both the left and right subtrees must also be
// binary search trees.
//
//
//  
// Example 1:
//
// Input: root = [2,1,3]
// Output: true
//
//
// Example 2:
//
// Input: root = [5,1,4,null,null,3,6]
// Output: false
// Explanation: The root node's value is 5 but its right child's value is 4.
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
//
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
  public boolean isValidBST(TreeNode root) {
    return isValidBST(root, null, null);
  }

  private boolean isValidBST(TreeNode node, Integer low, Integer high) {
    if (node == null)
      return true;

    if (low != null && node.val <= low)
      return false;
    if (high != null && node.val >= high)
      return false;
    return isValidBST(node.left, low, node.val) &&
        isValidBST(node.right, node.val, high);
  }
}
// end_marker
