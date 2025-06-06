import gleam/list

pub type Tree {
  Nil
  Node(data: Int, left: Tree, right: Tree)
}

pub fn to_tree(data: List(Int)) -> Tree {
  list.fold(data, Nil, insert_to_tree)
}

pub fn sorted_data(data: List(Int)) -> List(Int) {
  data
  |> to_tree()
  |> get_from_tree()
}

fn insert_to_tree(tree: Tree, item: Int) -> Tree {
  case tree {
    Nil -> Node(data: item, left: Nil, right: Nil)
    Node(data: a, left: l, right: r) if a >= item ->
      Node(data: a, left: insert_to_tree(l, item), right: r)
    Node(data: a, left: l, right: r) ->
      Node(data: a, left: l, right: insert_to_tree(r, item))
  }
}

fn get_from_tree(tree: Tree) -> List(Int) {
  case tree {
    Nil -> []
    Node(data: item, left: l, right: r) ->
      list.flatten([get_from_tree(l), [item], get_from_tree(r)])
  }
}
