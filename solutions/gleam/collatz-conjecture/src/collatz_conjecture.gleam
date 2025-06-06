import gleam/result
import gleam/int

pub type Error {
  NonPositiveNumber
}

pub fn steps(number: Int) -> Result(Int, Error) {
  case number, number % 2 {
    n, _ if n <= 0 -> Error(NonPositiveNumber)
    1, _ -> Ok(0)
    n, 0 -> result.map(steps(n / 2), int.add(_, 1))
    n, 1 -> result.map(steps(3 * n + 1), int.add(_, 1))
  }
}