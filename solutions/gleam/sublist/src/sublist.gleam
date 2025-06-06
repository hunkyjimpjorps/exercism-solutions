import gleam/bool
import gleam/list

pub type Comparison {
  Equal
  Unequal
  Sublist
  Superlist
}

pub fn sublist(compare list_a: List(a), to list_b: List(a)) -> Comparison {
  use <- bool.guard(list_a == list_b, Equal)
  use <- bool.guard(is_sublist(does: list_a, contain: list_b), Superlist)
  use <- bool.guard(is_sublist(does: list_b, contain: list_a), Sublist)
  Unequal
}

fn is_sublist(does list_a: List(a), contain list_b: List(a)) -> Bool {
  let len_b = list.length(list_b)

  case len_b {
    0 -> True
    _ ->
      list_a
      |> list.window(len_b)
      |> list.contains(list_b)
  }
}
