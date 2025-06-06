import gleam/int
import gleam/list
import gleam/result

pub fn egg_count(number: Int) -> Int {
  number
  |> int.digits(2)
  |> result.unwrap([])
  |> list.filter(fn(n) { n == 1 })
  |> list.length()
}
