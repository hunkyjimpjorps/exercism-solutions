import gleam/iterator
import gleam/bool

pub fn prime(number: Int) -> Result(Int, Nil) {
  use <- bool.guard(number <= 0, Error(Nil))

  iterator.single(2)
  |> iterator.append(iterator.iterate(3, fn(n) { n + 2 }))
  |> iterator.filter(is_prime(_, 3))
  |> iterator.at(number - 1)
}

fn is_prime(n: Int, k: Int) -> Bool {
  use <- bool.guard(n == 2, True)
  use <- bool.guard(n < k * k, True)
  use <- bool.guard(n % k == 0, False)
  is_prime(n, k + 2)
}
