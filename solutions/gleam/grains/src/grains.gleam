import gleam/result
import gleam/list

pub type Error {
  InvalidSquare
}

pub fn square(n: Int) -> Result(Int, Error) {
  case n {
    n if n < 1 || n > 64 -> Error(InvalidSquare)
    1 -> Ok(1)
    n -> result.map(square(n - 1), fn(x) { 2 * x })
  }
}

pub fn total() -> Int {
  list.fold(
    list.range(1, 64),
    0,
    fn(acc, n) { acc + result.unwrap(square(n), 0) },
  )
}
