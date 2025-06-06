import gleam/list
import gleam/int

pub fn sum(factors factors: List(Int), limit limit: Int) -> Int {
  { limit - 1 }
  |> list.range(1, _)
  |> list.filter(fn(n) { list.any(factors, fn(f) { f != 0 && n % f == 0 }) })
  |> int.sum()
}
