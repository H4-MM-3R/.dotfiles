// Category: algorithms
// Level: Easy
// Percent: 55.0873%

// Given the root of a binary tree with unique values and the values of two
// different nodes of the tree x and y, return true if the nodes corresponding
// to the values x and y in the tree are cousins, or false otherwise.
//
// Two nodes of a binary tree are cousins if they have the same depth with
// different parents.
//
// Note that in a binary tree, the root node is at the depth 0, and children of
// each depth k node are at the depth k + 1.
//
//  
// Example 1:
//
// Input: root = [1,2,3,4], x = 4, y = 3
// Output: false
//
//
// Example 2:
//
// Input: root = [1,2,3,null,4,null,5], x = 5, y = 4
// Output: true
//
//
// Example 3:
//
// Input: root = [1,2,3,null,4], x = 2, y = 3
// Output: false
//
//
//  
// Constraints:
//
//
// 	The number of nodes in the tree is in the range [2, 100].
// 	1 <= Node.val <= 100
// 	Each node has a unique value.
// 	x != y
// 	x and y are exist in the tree.
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
  public boolean isCousins(TreeNode root, int x, int y) {
    TreeNode first = findNode(root, x);
    TreeNode second = findNode(root, y);

    return (level(root, first, 0) == level(root, second, 0)) &&
        (!isSiblings(root, first, second));
  }

  TreeNode findNode(TreeNode node, int tar) {
    if (node == null)
      return null;

    if (node.val == tar)
      return node;

    TreeNode left = findNode(node.left, tar);
    if (left != null)
      return left;
    return findNode(node.right, tar);
  }

  int level(TreeNode node, TreeNode x, int currLvl) {
    if (node == null)
      return 0;
    if (node == x)
      return currLvl;
    return Math.max(level(node.right, x, currLvl + 1),
                    level(node.left, x, currLvl + 1));
  }

  boolean isSiblings(TreeNode node, TreeNode x, TreeNode y) {
    if (node == null)
      return false;
    return (node.left == x && node.right == y) ||
        (node.left == y && node.right == x) || isSiblings(node.left, x, y) ||
        isSiblings(node.right, x, y);
  }
}
// end_marker
