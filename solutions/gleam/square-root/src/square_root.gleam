import gleam/int
import gleam/order.{Eq, Gt, Lt}

pub fn square_root(radicand: Int) -> Int {
  do_square_root(1, radicand, radicand)
}

fn do_square_root(from: Int, to: Int, radicand: Int) -> Int {
  let guess = { from + to } / 2
  case int.compare(guess * guess, radicand) {
    Eq -> guess
    Gt -> do_square_root(from, guess, radicand)
    Lt -> do_square_root(guess, to, radicand)
  }
}
