import gleam/int
import gleam/result

pub fn egg_count(number: Int) -> Int {
  case number {
    0 -> 0
    n -> n % 2 + egg_count(n / 2)
  }
}
