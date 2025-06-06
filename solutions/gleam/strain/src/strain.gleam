pub fn keep(list: List(t), predicate: fn(t) -> Bool) -> List(t) {
  case list {
    [] -> []
    [h, ..t] ->
      case predicate(h) {
        True -> [h, ..keep(t, predicate)]
        False -> keep(t, predicate)
      }
  }
}

pub fn discard(list: List(t), predicate: fn(t) -> Bool) -> List(t) {
  keep(list, fn(x) { !predicate(x) })
}
