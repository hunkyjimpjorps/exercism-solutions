import gleam/list
import gleam/int
import gleam/order
import gleam/result

pub type Error {
  ImpossibleTarget
}

pub fn find_fewest_coins(
  coins: List(Int),
  target: Int,
) -> Result(List(Int), Error) {
  coins
  |> list.sort(order.reverse(int.compare))
  |> do_search(target, [], Error(ImpossibleTarget))
}

fn do_search(
  coins: List(Int),
  target: Int,
  current: List(Int),
  best: Result(List(Int), Error),
) -> Result(List(Int), Error) {
  let current_length = list.length(current)
  let best_length = list.length(result.unwrap(best, []))

  case coins, target, best {
    _, _, Ok(_) if current_length >= best_length -> best
    _, 0, _ -> Ok(current)
    [], _, _ -> best
    [coin, ..rest], _, _ if coin > target ->
      do_search(rest, target, current, best)
    [coin, ..rest], _, _ -> {
      let remaining = do_search(coins, target - coin, [coin, ..current], best)
      do_search(rest, target, current, remaining)
    }
  }
}
