import gleam/int
import gleam/float
import gleam/list

pub type Classification {
  Perfect
  Abundant
  Deficient
}

pub type Error {
  NonPositiveInt
}

pub fn classify(number: Int) -> Result(Classification, Error) {
  case number {
    n if n <= 0 -> Error(NonPositiveInt)
    n ->
      case aliquot(n) {
        sum if n == sum -> Ok(Perfect)
        sum if n < sum -> Ok(Abundant)
        _ -> Ok(Deficient)
      }
  }
}

fn aliquot(number: Int) -> Int {
  let assert Ok(sqrt) = int.square_root(number)
  let upper_limit = float.round(sqrt)

  list.range(from: 1, to: upper_limit)
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
