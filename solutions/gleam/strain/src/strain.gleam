pub fn keep(list: List(t), predicate: fn(t) -> Bool) -> List(t) {
  tco_filter(list, predicate, [])
}

pub fn discard(list: List(t), predicate: fn(t) -> Bool) -> List(t) {
  tco_filter(list, fn(x) { !predicate(x) }, [])
}

fn tco_filter(list: List(t), predicate: fn(t) -> Bool, acc: List(t)) -> List(t) {
  case list {
    [] -> acc
    [h, ..t] ->
      case predicate(h) {
        True -> tco_filter(t, predicate, [h, ..acc])
        False -> tco_filter(t, predicate, acc)
      }
  }
}
