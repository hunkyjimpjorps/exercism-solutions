import gleam/int
import gleam/bool.{guard}
import gleam/list
import gleam/result.{map, try}
import gleam/string

pub fn largest_product(digits: String, span: Int) -> Result(Int, Nil) {
  use <- guard(span < 0 || span > string.length(digits), Error(Nil))
  use <- guard(span == 0, Ok(1))
  int.parse(digits)
  |> try(fn(n) {
    int.digits(n, 10)
    |> result.nil_error()
  })
  |> map(fn(ns) {
    list.window(ns, span)
    |> list.map(int.product)
    |> list.fold(0, int.max)
  })
}
