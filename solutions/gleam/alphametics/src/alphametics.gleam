import gleam/map.{type Map}
import gleam/string
import gleam/list
import gleam/result
import gleam/int

type Problem {
  Problem(parts: List(List(String)), sum: List(String), initials: List(String))
}

pub fn solve(puzzle: String) -> Result(Map(String, Int), Nil) {
  let #(parts, sum) = parse_puzzle(puzzle)

  let all_variables =
    [sum, ..parts]
    |> list.flatten()
    |> list.unique()

  let leading_variables =
    [sum, ..parts]
    |> list.map(list.first)
    |> result.values()
    |> list.unique()

  do_solve(
    Problem(parts: parts, sum: sum, initials: leading_variables),
    all_variables,
    list.range(0, 9),
    map.new(),
  )
}

fn parse_puzzle(puzzle: String) -> #(List(List(String)), List(String)) {
  let [left, right] = string.split(puzzle, " == ")

  let parts =
    left
    |> string.split(" + ")
    |> list.map(string.to_graphemes)
  let sum = string.to_graphemes(right)

  #(parts, sum)
}

fn do_solve(
  problem: Problem,
  variables: List(String),
  numbers: List(Int),
  solution: Map(String, Int),
) -> Result(Map(String, Int), Nil) {
  case variables {
    [] ->
      case sum(problem.parts, solution) == to_number(problem.sum, solution) {
        True -> Ok(solution)
        False -> Error(Nil)
      }
    [first, ..rest] ->
      list.find_map(
        numbers,
        fn(n) {
          case !{ n == 0 && list.contains(problem.initials, first) } {
            True -> {
              let solution = map.insert(solution, first, n)
              let assert Ok(#(_, numbers)) = list.pop(numbers, fn(x) { x == n })
              do_solve(problem, rest, numbers, solution)
            }
            False -> Error(Nil)
          }
        },
      )
  }
}

fn sum(parts, solution) {
  list.fold(parts, 0, fn(acc, p) { acc + to_number(p, solution) })
}

fn to_number(letters, numbers) {
  letters
  |> list.map(map.get(numbers, _))
  |> result.values()
  |> int.undigits(10)
  |> result.unwrap(0)
}
