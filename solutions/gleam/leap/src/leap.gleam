import gleam/int

fn is_divisible(dividend: Int, divisor: Int) -> Bool {
  case int.remainder(dividend, divisor) {
    Ok(0) -> True
    Ok(_) | Error(Nil) -> False
  }
}

pub fn is_leap_year(year: Int) -> Bool {
  is_divisible(year, 400) || {
    !is_divisible(year, 100) && is_divisible(year, 4)
  }
}
