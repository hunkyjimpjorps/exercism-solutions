import gleam/int
import gleam/list

pub fn is_armstrong_number(number: Int) -> Bool {
  let assert Ok(digits) = int.digits(number, 10)
  let power = list.length(digits)

  digits
  |> list.map(pow(_, power))
  |> int.sum() == number
}

fn pow(x, n) {
  case n {
    1 -> x
    _ -> x * pow(x, n - 1)
  }
}
