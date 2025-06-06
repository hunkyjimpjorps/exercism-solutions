import gleam/string
import gleam/int

pub type Clock {
  Clock(hour: Int, minute: Int)
}

pub fn create(hour hour: Int, minute minute: Int) -> Clock {
  let h = rem_e(rem_e(hour, 24) + div_e(minute, 60), 24)
  let m = rem_e(minute, 60)

  Clock(h, m)
}

pub fn add(clock: Clock, minutes minutes: Int) -> Clock {
  create(clock.hour, clock.minute + minutes)
}

pub fn subtract(clock: Clock, minutes minutes: Int) -> Clock {
  create(clock.hour, clock.minute - minutes)
}

pub fn display(clock: Clock) -> String {
  pad(clock.hour) <> ":" <> pad(clock.minute)
}

fn div_e(a: Int, b: Int) -> Int {
  let assert Ok(n) = int.floor_divide(a, int.absolute_value(b))
  int.absolute_value(b) / b * n
}

fn rem_e(a: Int, b: Int) -> Int {
  let assert Ok(n) = int.floor_divide(a, int.absolute_value(b))
  a - int.absolute_value(b) * n
}

fn pad(digits: Int) -> String {
  string.pad_left(int.to_string(digits), 2, "0")
}
