pub type GbTree(k, v)

@external(erlang, "gb_trees", "empty")
pub fn new_gb_tree() -> GbTree(k, v)

// insert(Key, Value, Tree1) -> Tree2
@external(erlang, "gb_trees", "insert")
fn ext_insert(key: k, value: v, tree: GbTree(k, v)) -> GbTree(k, v)

pub fn insert(tree: GbTree(k, v), key: k, value: v) -> GbTree(k, v) {
  ext_insert(key, value, tree)
}

// delete_any(Key, Tree1) -> Tree2
@external(erlang, "gb_trees", "delete_any")
fn ext_delete(key: k, tree: GbTree(k, v)) -> GbTree(k, v)

pub fn delete(tree: GbTree(k, v), key: k) -> GbTree(k, v) {
  ext_delete(key, tree)
}
