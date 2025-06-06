import gleam/list.{Continue, Stop}

pub type Resistance {
  Resistance(unit: String, value: Int)
}

fn to_digit(color: String) -> Int {
  case color {
    "black" -> 0
    "brown" -> 1
    "red" -> 2
    "orange" -> 3
    "yellow" -> 4
    "green" -> 5
    "blue" -> 6
    "violet" -> 7
    "grey" -> 8
    "white" -> 9
  }
}

fn pow(x, n) {
  case n {
    0 -> 1
    n ->
      case n % 2 {
        0 -> pow(x * x, n / 2)
        1 -> x * pow(x, n - 1)
      }
  }
}

pub fn label(colors: List(String)) -> Result(Resistance, Nil) {
  let [tens, ones, zeroes, ..] = colors
  let value =
    { 10 * to_digit(tens) + to_digit(ones) } * pow(10, to_digit(zeroes))

  let #(reduced_value, unit) =
    list.fold_until(
      ["kilo", "mega", "giga"],
      #(value, ""),
      fn(acc, i) {
        let #(current_val, _) = acc

        case current_val > 1000 {
          True -> Continue(#(current_val / 1000, i))
          False -> Stop(acc)
        }
      },
    )

  Ok(Resistance(unit <> "ohms", reduced_value))
}
