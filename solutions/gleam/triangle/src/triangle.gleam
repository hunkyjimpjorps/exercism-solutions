import gleam/list
import gleam/float

fn valid_triangle(sides: List(Float)) -> Bool {
  sides
  |> list.sort(float.compare)
  |> fn(xs) {
    let assert [a, b, c] = xs
    a +. b >=. c && list.all(xs, fn(x) { x >. 0.0 })
  }
}

fn at_least_n_unique_sides(sides: List(Float), n: Int) -> Bool {
  sides
  |> list.unique()
  |> list.length()
  |> fn(l) { l <= n }
}

pub fn equilateral(a: Float, b: Float, c: Float) -> Bool {
  at_least_n_unique_sides([a, b, c], 1) && valid_triangle([a, b, c])
}

pub fn isosceles(a: Float, b: Float, c: Float) -> Bool {
  at_least_n_unique_sides([a, b, c], 2) && valid_triangle([a, b, c])
}  

pub fn scalene(a: Float, b: Float, c: Float) -> Bool {
  !at_least_n_unique_sides([a, b, c], 2) && valid_triangle([a, b, c])
}
