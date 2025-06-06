pub fn accumulate(list: List(a), fun: fn(a) -> b) -> List(b) {
  case list {
    [] -> []
    [h, ..t] -> [fun(h), ..accumulate(t, fun)]
  }
}
