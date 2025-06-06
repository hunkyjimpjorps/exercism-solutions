import gleam/bool
import gleam/list
import gleam/int
import gleam/result

pub type Error {
  InvalidBase(Int)
  InvalidDigit(Int)
}

pub fn rebase(
  digits digits: List(Int),
  input_base input_base: Int,
  output_base output_base: Int,
) -> Result(List(Int), Error) {
  use <- bool.guard(input_base <= 1, Error(InvalidBase(input_base)))
  use <- bool.guard(output_base <= 1, Error(InvalidBase(output_base)))
  digits
  |> digits_to_base10(input_base)
  |> result.try(base10_to_digits(_, output_base, []))
}

fn digits_to_base10(digits: List(Int), base: Int) -> Result(Int, Error) {
  digits
  |> list.reverse()
  |> list.map(fn(n) {
    case n {
      n if n < 0 || n >= base -> Error(InvalidDigit(n))
      n -> Ok(n)
    }
  })
  |> result.all()
  |> result.map(list.index_map(_, fn(i, d) { d * pow(base, i) }))
  |> result.map(int.sum)
}

fn base10_to_digits(
  n: Int,
  base: Int,
  acc: List(Int),
) -> Result(List(Int), Error) {
  case n, acc {
    0, [] -> Ok([0])
    0, acc -> Ok(acc)
    _, _ -> base10_to_digits(n / base, base, [n % base, ..acc])
  }
}

fn pow(x: Int, n: Int) -> Int {
  case n {
    0 -> 1
    1 -> x
    n ->
      case n % 2 {
        0 -> pow(x * x, n / 2)
        1 -> x * pow(x, n - 1)
      }
  }
}
