import gleam/int
import gleam/bool
import gleam/list
import gleam/result
import gleam/string

pub fn largest_product(digits: String, span: Int) -> Result(Int, Nil) {
  use <- bool.guard(span < 0 || span > string.length(digits), Error(Nil))
  use <- bool.guard(span == 0, Ok(1))
  int.parse(digits)
  |> result.try(fn(n) {
    int.digits(n, 10)
    |> result.replace_error(Nil)
  })
  |> result.map(fn(ns) {
    list.window(ns, span)
    |> list.map(int.product)
    |> list.fold(0, int.max)
  })
}
