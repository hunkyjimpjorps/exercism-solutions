import gleam/bool
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
  use n <- result.try(digits_to_base10(digits, input_base, 0))
  base10_to_digits(n, output_base, [])
}

fn digits_to_base10(
  digits: List(Int),
  base: Int,
  acc: Int,
) -> Result(Int, Error) {
  case digits {
    [] -> Ok(acc)
    [h, ..] if h < 0 || h >= base -> Error(InvalidDigit(h))
    [h, ..t] -> digits_to_base10(t, base, acc * base + h)
  }
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