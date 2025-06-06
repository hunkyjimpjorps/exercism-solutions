import gleam/list

pub type NestedList(a) {
  Null
  Value(a)
  List(List(NestedList(a)))
}

pub fn flatten(nested_list: NestedList(a)) -> List(a) {
  do_flatten(nested_list, [])
  |> list.reverse()
}

fn do_flatten(nested_list, acc) {
  case nested_list {
    Null | List([]) -> acc
    Value(a) -> [a, ..acc]
    List([h, ..t]) -> do_flatten(List(t), do_flatten(h, acc))
  }
}
