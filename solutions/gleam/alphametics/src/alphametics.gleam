import gleam/iterator.{type Iterator}
import gleam/list.{Continue, Stop}
import gleam/map.{type Map}
import gleam/result
import gleam/option.{None, Some}
import gleam/set.{type Set}
import gleam/string

fn powers_of_ten() -> Iterator(Int) {
  iterator.iterate(from: 1, with: fn(n) { 10 * n })
}

// turn a word into a map that represents its value in terms of the digit values
// ex. "ABC" becomes a map that represents 100A + 10B + C
// "ABBA" becomes 1001A + 11B
fn word_with_place_values(word: String) -> List(#(String, Int)) {
  let letters =
    word
    |> string.reverse()
    |> string.to_graphemes()
    |> iterator.from_list()

  iterator.zip(letters, powers_of_ten())
  |> iterator.to_list()
}

// add together all the words into a single polynomial
// "ABC + CBA" becomes 101A + 20B + 101C
fn add_word_equation(
  current_eqn: Map(String, Int),
  next_word: List(#(String, Int)),
) -> Map(String, Int) {
  use acc, pair <- list.fold(next_word, current_eqn)
  let #(k, v) = pair
  use maybe_v <- map.update(acc, k)
  case maybe_v {
    None -> v
    Some(current_v) -> current_v + v
  }
}

// to make the solution check easy we need a way of moving the right side to the left
// SEND + MORE = MONEY is the same as SEND + MORE - MONEY = 0
fn subtract_word(word: String) -> List(#(String, Int)) {
  let eqn = word_with_place_values(word)

  use pair <- list.map(eqn)
  let #(k, v) = pair
  #(k, -v)
}

// substitute all the variable values into the polynomial and see if it's zero
fn check_solution(
  guess: Map(String, Int),
  eqn: Map(String, Int),
) -> Result(Map(String, Int), Nil) {
  let sum = {
    use acc, k, coeff <- map.fold(eqn, 0)
    let assert Ok(v) = map.get(guess, k)
    acc + coeff * v
  }

  case sum {
    0 -> Ok(guess)
    _ -> Error(Nil)
  }
}

// if we're looking at a word-initial variable, it can't be zero because of the rules of the game
// so we remove 0 from the list of value candidates if it is
fn check_for_initial(
  digits: Set(Int),
  variable: String,
  initials: Set(String),
) -> Set(Int) {
  case set.contains(initials, variable) {
    True -> set.delete(digits, 0)
    False -> digits
  }
}

pub fn solve(input: String) -> Result(Map(String, Int), Nil) {
  let assert Ok(#(left, right_word)) = string.split_once(input, " == ")
  let left_words = string.split(left, " + ")

  let eqn =
    left_words
    |> list.map(word_with_place_values)
    |> list.prepend(subtract_word(right_word))
    |> list.fold(map.new(), add_word_equation)

  let variables = map.keys(eqn)

  let digits =
    list.range(0, 9)
    |> set.from_list

  // we need to track which variables occur at the beginning of words
  // because of the restriction that they can't be zero
  let initials =
    [right_word, ..left_words]
    |> list.map(string.first)
    |> result.values()
    |> set.from_list()

  do_solve(digits, map.new(), eqn, variables, initials)
}

fn do_solve(
  digits: Set(Int),
  current: Map(String, Int),
  eqn: Map(String, Int),
  variables: List(String),
  initials: Set(String),
) -> Result(Map(String, Int), Nil) {
  case variables {
    // if we've assigned all the variables, see if we found a solution
    [] -> check_solution(current, eqn)
    [this, ..rest] ->
      digits
      |> check_for_initial(this, initials)
      |> set.to_list()
      |> list.fold_until(Error(Nil), fn(_, v) {
        // go to the next step of the depth-first search --
        // assign one of the digit values to the current variable, add it to the solution,
        // and then recurse with the remaining variables and digit values,
        // until we hit a point where all the variables have been assigned
        // if a solution doesn't work, if we have digits left we can assign we use those, 
        // and if none of the alternate digit assignments work we step back to the previous variable
        // and try exhausting all of those possibilities, and so forth
        let remaining_digits = set.delete(digits, v)
        let this_guess = map.insert(current, this, v)
        case do_solve(remaining_digits, this_guess, eqn, rest, initials) {
          Ok(found_a_solution) -> Stop(Ok(found_a_solution))
          _err -> Continue(Error(Nil))
        }
      })
  }
}
