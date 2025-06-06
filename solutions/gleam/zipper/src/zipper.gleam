pub type Tree(a) {
  Leaf
  Node(value: a, left: Tree(a), right: Tree(a))
}

pub opaque type Zipper(a) {
  Zipper(at: Tree(a), trail: List(Branch(a)))
}

pub opaque type Branch(a) {
  Left(value: a, tree: Tree(a))
  Right(value: a, tree: Tree(a))
}

pub fn to_zipper(tree: Tree(a)) -> Zipper(a) {
  Zipper(at: tree, trail: [])
}

pub fn to_tree(zipper: Zipper(a)) -> Tree(a) {
  case up(zipper) {
    Ok(z) -> to_tree(z)
    Error(Nil) -> zipper.at
  }
}

pub fn value(zipper: Zipper(a)) -> Result(a, Nil) {
  case zipper {
    Zipper(at: Node(value: a, ..), ..) -> Ok(a)
    _ -> Error(Nil)
  }
}

pub fn up(zipper: Zipper(a)) -> Result(Zipper(a), Nil) {
  case zipper.trail {
    [] -> Error(Nil)
    [Left(value: val, tree: tree), ..rest] ->
      Ok(Zipper(at: Node(val, left: zipper.at, right: tree), trail: rest))
    [Right(value: val, tree: tree), ..rest] ->
      Ok(Zipper(at: Node(val, right: zipper.at, left: tree), trail: rest))
  }
}

pub fn left(zipper: Zipper(a)) -> Result(Zipper(a), Nil) {
  case zipper.at {
    Leaf -> Error(Nil)
    Node(value: val, left: l, right: r) ->
      Ok(Zipper(at: l, trail: [Left(val, r), ..zipper.trail]))
  }
}

pub fn right(zipper: Zipper(a)) -> Result(Zipper(a), Nil) {
  case zipper.at {
    Leaf -> Error(Nil)
    Node(value: val, left: l, right: r) ->
      Ok(Zipper(at: r, trail: [Right(val, l), ..zipper.trail]))
  }
}

pub fn set_value(zipper: Zipper(a), value: a) -> Zipper(a) {
  case zipper.at {
    Leaf -> Zipper(..zipper, at: Node(value, Leaf, Leaf))
    Node(left: l, right: r, ..) -> Zipper(..zipper, at: Node(value, l, r))
  }
}

pub fn set_left(zipper: Zipper(a), tree: Tree(a)) -> Result(Zipper(a), Nil) {
  case zipper.at {
    Leaf -> Error(Nil)
    Node(value: v, right: r, ..) -> Ok(Zipper(..zipper, at: Node(v, tree, r)))
  }
}

pub fn set_right(zipper: Zipper(a), tree: Tree(a)) -> Result(Zipper(a), Nil) {
  case zipper.at {
    Leaf -> Error(Nil)
    Node(value: v, left: l, ..) -> Ok(Zipper(..zipper, at: Node(v, l, tree)))
  }
}
