import gleam/yielder
import gleam/bool

pub fn prime(number: Int) -> Result(Int, Nil) {
  use <- bool.guard(number <= 0, Error(Nil))

  yielder.single(2)
  |> yielder.append(yielder.iterate(3, fn(n) { n + 2 }))
  |> yielder.filter(is_prime(_, 3))
  |> yielder.at(number - 1)
}

fn is_prime(n: Int, k: Int) -> Bool {
  use <- bool.guard(n == 2, True)
  use <- bool.guard(n < k * k, True)
  use <- bool.guard(n % k == 0, False)
  is_prime(n, k + 2)
}
 