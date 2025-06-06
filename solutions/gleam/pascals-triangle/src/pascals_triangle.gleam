import gleam/list

fn row(n: Int) -> List(Int) {
  case n {
    1 -> [1]
    n -> {
      let prev_row = [0, ..row(n - 1)]
      list.zip(prev_row, list.reverse(prev_row))
      |> list.map(fn(p) {
        let #(a, b) = p
        a + b
      })
    }
  }
}

pub fn rows(n: Int) -> List(List(Int)) {
  case n {
    0 -> []
    _ -> list.map(list.range(1, n), row)
  }
}