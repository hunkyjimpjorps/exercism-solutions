import gleam/bool
import gleam/list
import gleam/set

pub type Tree(a) {
  Nil
  Node(value: a, left: Tree(a), right: Tree(a))
}

pub type Error {
  DifferentLengths
  DifferentItems
  NonUniqueItems
}

pub fn tree_from_traversals(
  inorder inorder: List(a),
  preorder preorder: List(a),
) -> Result(Tree(a), Error) {
  use <- bool.guard(
    list.length(inorder) != list.length(preorder),
    Error(DifferentLengths),
  )
  use <- bool.guard(
    list.unique(inorder) != inorder || list.unique(preorder) != preorder,
    Error(NonUniqueItems),
  )
  use <- bool.guard(
    set.from_list(inorder) != set.from_list(preorder),
    Error(DifferentItems),
  )
  Ok(do_tree(preorder, inorder))
}

fn do_tree(preorder: List(a), inorder: List(a)) -> Tree(a) {
  case preorder, inorder {
    [], [] -> Nil
    [first, ..rest], inorder -> {
      let #(in_l, [_, ..in_r]) = list.split_while(inorder, fn(a) { a != first })
      let #(pre_l, pre_r) = list.split(rest, list.length(in_l))

      Node(
        value: first,
        left: do_tree(pre_l, in_l),
        right: do_tree(pre_r, in_r),
      )
    }
  }
}
