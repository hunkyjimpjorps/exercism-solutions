import gleam/string
import gleam/list
import gleam/int
import gleam/result

pub fn row(index: Int, string: String) -> Result(List(Int), Nil) {
  string
  |> to_matrix()
  |> list.at(index - 1)
}

pub fn column(index: Int, string: String) -> Result(List(Int), Nil) {
  string
  |> to_matrix()
  |> list.map(list.at(_, index - 1))
  |> result.all()
}

fn to_matrix(string: String) -> List(List(Int)) {
  string
  |> string.split("\n")
  |> list.map(fn(r) {
    r
    |> string.split(" ")
    |> list.map(int.base_parse(_, 10))
    |> result.values
  })
}
