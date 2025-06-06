import gleam/list

pub fn factors(value: Int) -> List(Int) {
  do_factors(value, 2, [])
}

fn do_factors(remainder: Int, factor: Int, acc: List(Int)) -> List(Int) {
  case remainder, factor, remainder % factor {
    r, _, _ if r <= 1 -> list.reverse(acc)
    r, n, 0 -> do_factors(r / n, n, [n, ..acc])
    r, 2, _ -> do_factors(r, 3, acc)
    r, n, _ -> do_factors(r, n + 2, acc)
  }
}
