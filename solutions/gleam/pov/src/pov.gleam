import gleam/list.{Continue, Stop}
import gleam/option.{type Option, None, Some}

pub type Tree(a) {
  Tree(label: a, children: List(Tree(a)))
}

pub fn from_pov(tree: Tree(a), from: a) -> Result(Tree(a), Nil) {
  get_new_root_of(tree, from, None)
}

pub fn path_to(
  tree tree: Tree(a),
  from from: a,
  to to: a,
) -> Result(List(a), Nil) {
  case from_pov(tree, from) {
    Ok(tree) -> find_path(tree, to, [])
    Error(_) -> Error(Nil)
  }
}

fn find_path(tree: Tree(a), target: a, path: List(a)) -> Result(List(a), Nil) {
  let updated_path = [tree.label, ..path]
  case tree {
    Tree(label, _) if label == target -> Ok(list.reverse(updated_path))
    Tree(_, []) -> Error(Nil)
    Tree(_, children) ->
      children
      |> list.fold_until(
        Error(Nil),
        fn(prior, child) {
          case prior {
            Ok(_) -> Stop(prior)
            _ -> Continue(find_path(child, target, updated_path))
          }
        },
      )
  }
}

fn get_new_root_of(
  tree: Tree(a),
  root: a,
  parent: Option(a),
) -> Result(Tree(a), Nil) {
  case tree {
    Tree(label, []) if label != root -> Error(Nil)
    Tree(label, _) if label == root -> Ok(tree)
    Tree(label, children) ->
      parent
      |> option.map(trim_tree(_, children))
      |> option.unwrap(children)
      |> list.fold_until(
        Error(Nil),
        fn(prior, child) {
          case prior {
            Ok(_) -> Stop(prior)
            _ ->
              Continue(
                swap_root(tree, child)
                |> get_new_root_of(root, Some(label)),
              )
          }
        },
      )
  }
}

fn trim_tree(label: a, trees: List(Tree(a))) -> List(Tree(a)) {
  list.filter(trees, fn(tree) { tree.label != label })
}

fn swap_root(parent: Tree(a), child: Tree(a)) -> Tree(a) {
  let new_child = Tree(parent.label, trim_tree(child.label, parent.children))
  Tree(child.label, [new_child, ..child.children])
}
