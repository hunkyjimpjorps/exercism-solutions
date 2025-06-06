import gleam/dict.{type Dict}
import gleam/list
import gleam/option.{None, Some}
import gleam/result
import gleam/int

pub type Category {
  Ones
  Twos
  Threes
  Fours
  Fives
  Sixes
  FullHouse
  FourOfAKind
  LittleStraight
  BigStraight
  Choice
  Yacht
}

type Bag =
  Dict(Int, Int)

pub fn score(category: Category, dice: List(Int)) -> Int {
  let bag = hand_to_bag(dice)

  case category {
    Ones | Twos | Threes | Fours | Fives | Sixes ->
      score_multiples(bag, category)
    FullHouse -> score_full_house(bag)
    FourOfAKind -> score_four_of_a_kind(bag)
    LittleStraight -> score_little_straight(dice)
    BigStraight -> score_big_straight(dice)
    Choice -> sum_of_bag(bag)
    Yacht -> score_yacht(bag)
  }
}

fn hand_to_bag(dice: List(Int)) -> Bag {
  use acc, i <- list.fold(over: dice, from: dict.new())
  use x <- dict.upsert(in: acc, update: i)
  case x {
    Some(count) -> count + 1
    None -> 1
  }
}

fn sum_of_bag(bag: Bag) -> Int {
  dict.fold(bag, 0, fn(acc, k, v) { acc + k * v })
}

fn score_multiples(bag: Bag, category: Category) -> Int {
  let die_value = case category {
    Ones -> 1
    Twos -> 2
    Threes -> 3
    Fours -> 4
    Fives -> 5
    Sixes -> 6
    _ -> 0
  }

  dict.get(bag, die_value)
  |> result.unwrap(0)
  |> fn(n) { n * die_value }
}

fn score_full_house(bag: Bag) -> Int {
  case dict.values(bag) {
    [2, 3] | [3, 2] -> sum_of_bag(bag)
    _ -> 0
  }
}

fn score_four_of_a_kind(bag: Bag) -> Int {
  case dict.values(bag) {
    [5] | [4, 1] | [1, 4] ->
      bag
      |> dict.filter(fn(_, v) { v >= 4 })
      |> dict.map_values(fn(_, _) { 4 })
      |> sum_of_bag
    _ -> 0
  }
}

fn score_little_straight(dice: List(Int)) -> Int {
  case list.sort(dice, int.compare) {
    [1, 2, 3, 4, 5] -> 30
    _ -> 0
  }
}

fn score_big_straight(dice: List(Int)) -> Int {
  case list.sort(dice, int.compare) {
    [2, 3, 4, 5, 6] -> 30
    _ -> 0
  }
}

fn score_yacht(bag: Bag) -> Int {
  case dict.values(bag) {
    [5] -> 50
    _ -> 0
  }
}
