pub fn score(x x: Float, y y: Float) -> Int {
  case x *. x +. y *. y {
    r if r <=. 1.0 -> 10
    r if r <=. 25.0 -> 5
    r if r <=. 100.0 -> 1
    _ -> 0
  }
}
