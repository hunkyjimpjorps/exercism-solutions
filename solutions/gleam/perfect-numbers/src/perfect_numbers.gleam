import gleam/int
import gleam/float
import gleam/list
import gleam/order.{Eq, Gt, Lt}

pub type Classification {
  Perfect
  Abundant
  Deficient
}

pub type Error {
  NonPositiveInt
}

pub fn classify(number: Int) -> Result(Classification, Error) {
  case number <= 0 {
    True -> Error(NonPositiveInt)
    False ->
      case int.compare(aliquot(number), number) {
        Eq -> Ok(Perfect)
        Gt -> Ok(Abundant)
        Lt -> Ok(Deficient)
      }
  }
}

fn aliquot(number: Int) -> Int {
  let assert Ok(sqrt) = int.square_root(number)

  list.range(from: 1, to: float.round(sqrt))
  |> list.fold(
    from: -number,
    with: fn(acc, i) {
      case number % i, i == number / i {
        0, True -> acc + i
        0, False -> acc + i + { number / i }
        _, _ -> acc
      }
    },
  )
}
