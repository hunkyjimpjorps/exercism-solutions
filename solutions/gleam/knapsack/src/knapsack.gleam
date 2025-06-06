pub type Item {
  Item(value: Int, weight: Int)
}

pub type Knapsack {
  Knapsack(value: Int, remaining: Int)
}

pub fn maximum_value(items: List(Item), maximum_weight: Int) -> Int {
  pack_knapsack(items, Knapsack(value: 0, remaining: maximum_weight)).value
}

fn pack_knapsack(items: List(Item), sack: Knapsack) -> Knapsack {
  case items {
    [] -> sack
    [current, ..rest] if current.weight > sack.remaining ->
      pack_knapsack(rest, sack)
    [current, ..rest] -> {
      let leave_it = pack_knapsack(rest, sack)
      let take_it =
        Knapsack(
          value: sack.value + current.value,
          remaining: sack.remaining - current.weight,
        )
        |> pack_knapsack(rest, _)
      case leave_it.value > take_it.value {
        True -> leave_it
        False -> take_it
      }
    }
  }
}
