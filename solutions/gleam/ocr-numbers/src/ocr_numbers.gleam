import gleam/list
import gleam/string
import gleam/map.{type Map}
import gleam/bool
import gleam/result

pub type Output {
  Unknown
  Digit(Int)
  List(List(Output))
}

pub type Error {
  InvalidLineNumber
  InvalidRowNumber
}

const numbers = [
  " _     _  _     _  _  _  _  _ ", "| |  | _| _||_||_ |_   ||_||_|",
  "|_|  ||_  _|  | _||_|  ||_| _|", "                              ",
]

pub fn convert(input: String) -> Result(Output, Error) {
  let conversion = conversion_map()

  let ["", ..lines] = string.split(input, on: "\n")

  use <- bool.guard(list.length(lines) % 4 != 0, Error(InvalidLineNumber))
  use <- bool.guard(
    list.any(lines, fn(str) { string.length(str) % 3 != 0 }),
    Error(InvalidRowNumber),
  )

  {
    use line <- list.map(list.sized_chunk(lines, 4))
    line
    |> list.map(to_column_chunks)
    |> list.transpose()
    |> list.map(fn(strs) { result.unwrap(map.get(conversion, strs), Unknown) })
    |> wrap
  }
  |> wrap
  |> Ok()
}

fn conversion_map() -> Map(List(List(String)), Output) {
  numbers
  |> list.map(to_column_chunks)
  |> list.transpose()
  |> list.zip(list.map(list.range(0, 9), Digit))
  |> map.from_list()
}

fn to_column_chunks(str: String) -> List(List(String)) {
  str
  |> string.to_graphemes
  |> list.sized_chunk(3)
}

fn wrap(ns) -> Output {
  case ns {
    [n] -> n
    ns -> List(ns)
  }
}
