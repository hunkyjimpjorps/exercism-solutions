import gleam/bool
import gleam/list

pub fn primes_up_to(upper_bound: Int) -> List(Int) {
  case upper_bound {
    l if l <= 1 -> []
    2 -> [2]
    l -> do_primes_up_to(range_step(3, l, 2), l, [2])
  }
}

fn do_primes_up_to(
  candidates: List(Int),
  limit: Int,
  acc: List(Int),
) -> List(Int) {
  let assert [h, ..t] = candidates
  case h * h > limit {
    True -> list.append(list.reverse(acc), candidates)
    False ->
      t
      |> list.filter(fn(n) { !list.contains(range_step(2 * h, limit, h), n) })
      |> do_primes_up_to(limit, [h, ..acc])
  }
}

fn range_step(from: Int, to: Int, step: Int) -> List(Int) {
  do_range_step(from, to, step, [from])
}

fn do_range_step(from: Int, to: Int, step: Int, acc: List(Int)) -> List(Int) {
  let assert [h, ..] = acc
  case h + step <= to {
    True -> do_range_step(from, to, step, [h + step, ..acc])
    False -> list.reverse(acc)
  }
}
